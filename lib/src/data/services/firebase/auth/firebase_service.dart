import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_app/src/data/models/account/account_model.dart';

class FirebaseService {
  FirebaseService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Future<List<AccountModel>> getEnabledAccounts() async {
    final snapshot = await _firestore
        .collection('accounts')
        .where('enabled', isEqualTo: true)
        .get();

    final List<AccountModel> list = [];
    for (final doc in snapshot.docs) {
      try {
        list.add(AccountModel.fromJson(doc.data()));
      } catch (_) {}
    }
    return list;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> queryAccountDoc(
    String taxIdOrId,
    String username,
  ) async {
    final snapshot = await _firestore
        .collection('accounts')
        .where('enabled', isEqualTo: true)
        .where('username', isEqualTo: username.trim())
        .where('taxIdOrId', arrayContains: taxIdOrId.trim())
        .get(const GetOptions(source: Source.server))
        .timeout(const Duration(seconds: 5));

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first;
    }
    return null;
  }

  Future<void> updateFailedAttempts(
    DocumentReference docRef,
    int failedAttempts,
    DateTime? lockUntil,
  ) async {
    final updatedFields = {
      'failedAttempts': failedAttempts,
      'lockUntil': lockUntil != null ? Timestamp.fromDate(lockUntil) : null,
      'updatedAt': FieldValue.serverTimestamp(),
    };
    await docRef.update(updatedFields);
  }

  Future<void> resetFailedAttempts(DocumentReference docRef) async {
    await docRef.update({
      'failedAttempts': 0,
      'lockUntil': null,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
