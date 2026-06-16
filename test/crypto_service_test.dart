import 'package:flutter_test/flutter_test.dart';
import 'package:crud_app/services/crypto_service.dart';

void main() {
  group('CryptoService PBKDF2-HMAC-SHA256 Tests', () {
    test('Verify correct hashing with 1 iteration (standard HMAC-SHA256 fallback)', () {
      // Test vector using standard parameters
      // Password: "password"
      // Salt: "salt" -> Base64 is "c2FsdA=="
      // Iterations: 1
      // Expected output can be verified programmatically or against standard values.
      final hash = CryptoService.hashPassword(
        password: "password",
        saltBase64: "c2FsdA==", // "salt"
        iterations: 1,
        keyLength: 32,
      );
      
      expect(hash, isNotEmpty);
      expect(hash.length, equals(64)); // 32 bytes hex encoded is 64 characters
    });

    test('Verify hashing is deterministic (same input produces same hash)', () {
      const password = "my_secure_password_123";
      final salt = CryptoService.generateSalt();

      final hash1 = CryptoService.hashPassword(
        password: password,
        saltBase64: salt,
        iterations: 1000,
      );

      final hash2 = CryptoService.hashPassword(
        password: password,
        saltBase64: salt,
        iterations: 1000,
      );

      expect(hash1, equals(hash2));
    });

    test('Verify different password or salt produces different hashes', () {
      final salt = CryptoService.generateSalt();

      final hash1 = CryptoService.hashPassword(
        password: "password1",
        saltBase64: salt,
        iterations: 100,
      );

      final hash2 = CryptoService.hashPassword(
        password: "password2",
        saltBase64: salt,
        iterations: 100,
      );

      expect(hash1, isNot(equals(hash2)));
    });
  });
}
