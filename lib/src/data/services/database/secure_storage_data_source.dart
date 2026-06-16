import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageDataSource {
  static const _keySessionToken = 'session_token';

  final FlutterSecureStorage _secureStorage;

  SecureStorageDataSource(this._secureStorage);

  /// Saves the session token securely.
  Future<void> saveSession({
    required String username,
  }) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final token = "${username}_$timestamp";
    await _secureStorage.write(key: _keySessionToken, value: token);
  }

  /// Retrieves the active session token, or null if no session exists.
  Future<String?> getSessionToken() async {
    return await _secureStorage.read(key: _keySessionToken);
  }

  /// Clears the active user session from secure storage.
  Future<void> clearSession() async {
    await _secureStorage.delete(key: _keySessionToken);
  }
}
