import 'package:hive_ce/hive.dart';
import 'package:crud_app/src/data/models/account/account_model.dart';

class HiveService {
  HiveService._();
  static final HiveService instance = HiveService._();
  factory HiveService() => instance;

  Box<AccountModel> get _box => Hive.box<AccountModel>('accountsBox');

  AccountModel? getAccount(String taxIdOrId, String username) {
    final key = "${taxIdOrId.trim()}_${username.trim()}";
    return _box.get(key);
  }

  AccountModel? getAccountByUsername(String username) {
    for (final acc in _box.values) {
      if (acc.username == username) {
        return acc;
      }
    }
    return null;
  }

  Future<void> saveAccount(AccountModel account) async {
    for (final taxId in account.taxIdOrIds) {
      final key = "${taxId.trim()}_${account.username.trim()}";
      final copy = AccountModel(
        taxIdOrIds: account.taxIdOrIds,
        username: account.username,
        passwordHash: account.passwordHash,
        salt: account.salt,
        fullName: account.fullName,
        enabled: account.enabled,
        updatedAt: account.updatedAt,
        failedAttempts: account.failedAttempts,
        lockUntil: account.lockUntil,
      );
      await _box.put(key, copy);
    }
  }

  Future<void> updateFailedAttempts(String taxIdOrId, String username, int failedAttempts, DateTime? lockUntil) async {
    final key = "${taxIdOrId.trim()}_${username.trim()}";
    final localAccount = _box.get(key);
    if (localAccount != null) {
      final updatedAccount = AccountModel(
        taxIdOrIds: localAccount.taxIdOrIds,
        username: localAccount.username,
        passwordHash: localAccount.passwordHash,
        salt: localAccount.salt,
        fullName: localAccount.fullName,
        enabled: localAccount.enabled,
        updatedAt: DateTime.now(),
        failedAttempts: failedAttempts,
        lockUntil: lockUntil,
      );
      await _box.put(key, updatedAccount);
    }
  }

  Future<void> resetFailedAttempts(String taxIdOrId, String username) async {
    await updateFailedAttempts(taxIdOrId, username, 0, null);
  }

  List<AccountModel> getAllAccounts() {
    return _box.values.toList();
  }
}
