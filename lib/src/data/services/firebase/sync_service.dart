import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_ce/hive.dart';
import 'package:crud_app/src/data/models/account_model.dart';
import 'package:flutter/foundation.dart';

class SyncService {
  const SyncService._();

  /// Pulls the 'accounts' collection from Cloud Firestore (where enabled == true)
  /// and merges the records into Hive 'accountsBox' based on the 'updatedAt' field.
  static Future<void> syncAccounts() async {
    try {
      final firestore = FirebaseFirestore.instance;
      
      // Get all enabled accounts from Firestore
      final snapshot = await firestore
          .collection('accounts')
          .where('enabled', isEqualTo: true)
          .get();

      final box = Hive.box<AccountModel>('accountsBox');

      for (final doc in snapshot.docs) {
        try {
          final data = doc.data();
          final account = AccountModel.fromJson(data);
          
          // Composite keys to uniquely identify an account on the device for each tax ID
          for (final singleTaxId in account.taxIdOrIds) {
            final key = "${singleTaxId.trim()}_${account.username.trim()}";
            final localAccount = box.get(key);

            // Merge: save if local doesn't exist or Firestore has newer data
            if (localAccount == null || account.updatedAt.isAfter(localAccount.updatedAt)) {
              await box.put(key, account);
            }
          }
        } catch (e) {
          debugPrint("SyncService: Failed to parse/save document ${doc.id}: $e");
        }
      }
      
      debugPrint("SyncService: Completed account synchronization successfully. Cache size: ${box.length}");
    } catch (e) {
      debugPrint("SyncService: Account sync failed: $e. Using offline Hive cache.");
    }
  }
}
