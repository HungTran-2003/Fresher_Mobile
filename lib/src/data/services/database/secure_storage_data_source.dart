import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageDataSource {
  static const _keySessionToken = 'session_token';

  final FlutterSecureStorage _secureStorage;

  SecureStorageDataSource._(this._secureStorage);

  static final SecureStorageDataSource _instance =
  SecureStorageDataSource._(const FlutterSecureStorage());

  static SecureStorageDataSource get instance => _instance;

  /// Saves the session token securely.
  Future<void> saveSession({
    required String username,
    required String taxIdOrId,
  }) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final token = "${username}_${taxIdOrId}_$timestamp";
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
