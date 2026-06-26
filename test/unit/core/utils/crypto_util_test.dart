import 'package:crud_app/src/core/utils/crypto_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CryptoUtil', () {
    test('generateSalt should return a valid base64 string of correct length', () {
      final salt = CryptoUtil.generateSalt(16);
      expect(salt, isA<String>());
      expect(salt.isNotEmpty, true);
      // Base64 for 16 bytes is 24 chars (including padding)
      expect(salt.length, greaterThanOrEqualTo(22));
    });

    test('generateSalt should produce different values each time', () {
      final salt1 = CryptoUtil.generateSalt();
      final salt2 = CryptoUtil.generateSalt();
      expect(salt1, isNot(equals(salt2)));
    });

    test('hashPassword should return consistent hex string for same input', () {
      const password = 'password123';
      final salt = CryptoUtil.generateSalt();
      
      final hash1 = CryptoUtil.hashPassword(
        password: password,
        saltBase64: salt,
        iterations: 100, // Using fewer iterations for faster test
      );
      
      final hash2 = CryptoUtil.hashPassword(
        password: password,
        saltBase64: salt,
        iterations: 100,
      );
      
      expect(hash1, equals(hash2));
      expect(hash1.length, equals(64)); // SHA256 hex is 64 chars
    });

    test('hashPassword should return different hash for different passwords', () {
      final salt = CryptoUtil.generateSalt();
      
      final hash1 = CryptoUtil.hashPassword(
        password: 'pass1',
        saltBase64: salt,
        iterations: 100,
      );
      
      final hash2 = CryptoUtil.hashPassword(
        password: 'pass2',
        saltBase64: salt,
        iterations: 100,
      );
      
      expect(hash1, isNot(equals(hash2)));
    });
  });
}
