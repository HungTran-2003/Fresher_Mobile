import 'package:crud_app/src/data/services/hive/auth/hive_service.dart';
import 'package:crud_app/src/data/services/firebase/auth/firebase_service.dart';
import 'package:flutter/foundation.dart';

class SyncService {
  const SyncService._();

  /// Pulls the 'accounts' collection from Cloud Firestore (where enabled == true)
  /// and merges the records into Hive 'accountsBox' based on the 'updatedAt' field.
  static Future<void> syncAccounts({
    required HiveService hiveService,
    required FirebaseService firebaseService,
  }) async {
    try {
      final accounts = await firebaseService.getEnabledAccounts();

      for (final account in accounts) {
        try {
          // Composite keys to uniquely identify an account on the device for each tax ID
          for (final singleTaxId in account.taxIdOrIds) {
            final localAccount = hiveService.getAccount(singleTaxId, account.username);

            // Merge: save if local doesn't exist or updatedAt is different
            if (localAccount == null || !account.updatedAt.isAtSameMomentAs(localAccount.updatedAt)) {
              await hiveService.saveAccount(account);
            }
          }
        } catch (e) {
          debugPrint("SyncService: Failed to merge account ${account.username}: $e");
        }
      }
      
      debugPrint("SyncService: Completed account synchronization successfully. Cache size: ${hiveService.getAllAccounts().length}");
    } catch (e) {
      debugPrint("SyncService: Account sync failed: $e. Using offline Hive cache.");
    }
  }
}
