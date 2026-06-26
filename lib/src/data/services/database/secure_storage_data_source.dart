import 'package:crud_app/src/data/services/database/share_preferrences_data_source.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class SecureStorageDataSource extends GetxService {
  static const _keySessionToken = 'session_token';

  final FlutterSecureStorage _secureStorage;

  SecureStorageDataSource(this._secureStorage);

  static SecureStorageDataSource get instance => Get.find<SecureStorageDataSource>();

  /// Saves the session token securely.
  Future<void> saveSession({
    required String username,
    required String taxIdOrId,
  }) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final token = "${username}_${taxIdOrId}_$timestamp";
    await SharedPreferencesDataSource.instance.setLastTaxIdOrId(taxIdOrId);
    await SharedPreferencesDataSource.instance.setLastUsername(username);
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
