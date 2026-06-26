import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

class CryptoUtil {
  const CryptoUtil._();

  /// Hashes a password using PBKDF2-HMAC-SHA256.
  /// [password] is the plain text password.
  /// [saltBase64] is the Base64-encoded salt.
  /// [iterations] is the number of PBKDF2 iterations (default: 100,000).
  /// [keyLength] is the length of the derived key in bytes (default: 32 bytes / 256 bits).
  static String hashPassword({
    required String password,
    required String saltBase64,
    int iterations = 100000,
    int keyLength = 32,
  }) {
    final passwordBytes = utf8.encode(password);
    final saltBytes = base64.decode(saltBase64);

    final derivedBytes = _pbkdf2(
      passwordBytes,
      saltBytes,
      iterations,
      keyLength,
    );

    return _toHex(derivedBytes);
  }

  /// Generates a random Base64 salt for creating new accounts.
  static String generateSalt([int length = 16]) {
    final random = Random.secure();
    final values = List<int>.generate(length, (i) => random.nextInt(256));
    return base64.encode(values);
  }

  static Uint8List _pbkdf2(
    List<int> password,
    List<int> salt,
    int iterations,
    int keyLength,
  ) {
    final hmac = Hmac(sha256, password);
    final derivedKey = Uint8List(keyLength);
    final int blocks = (keyLength / 32).ceil();

    for (int i = 1; i <= blocks; i++) {
      final blockInput = BytesBuilder()
        ..add(salt)
        ..add([(i >> 24) & 0xff, (i >> 16) & 0xff, (i >> 8) & 0xff, i & 0xff]);

      var u = hmac.convert(blockInput.toBytes()).bytes;
      var xorSum = List<int>.from(u);

      for (int j = 2; j <= iterations; j++) {
        u = hmac.convert(u).bytes;
        for (int k = 0; k < 32; k++) {
          xorSum[k] ^= u[k];
        }
      }

      final offset = (i - 1) * 32;
      final length = (offset + 32 <= keyLength) ? 32 : keyLength - offset;
      derivedKey.setRange(offset, offset + length, xorSum.sublist(0, length));
    }
    return derivedKey;
  }

  static String _toHex(List<int> bytes) {
    return bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  }
}
