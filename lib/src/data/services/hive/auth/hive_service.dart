import 'package:hive_ce/hive.dart';
import 'package:crud_app/src/data/models/account_model.dart';

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
      final localAccount = _box.get(key);

      final updatedAccount = account.copyWith(
        failedAttempts: account.failedAttempts ?? localAccount?.failedAttempts ?? 0,
        lockUntil: account.lockUntil ?? localAccount?.lockUntil,
      );

      await _box.put(key, updatedAccount);
    }
  }

  List<AccountModel> getAllAccounts() {
    return _box.values.toList();
  }
}
