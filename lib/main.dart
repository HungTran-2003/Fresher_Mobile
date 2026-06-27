import 'package:crud_app/src/app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:crud_app/src/data/models/account/account_model.dart';
import 'hive_registrar.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }

  await Hive.initFlutter();
  Hive.registerAdapters();

  Box<AccountModel>? box;
  try {
    box = await Hive.openBox<AccountModel>('accountsBox');
    // Trigger any potential deserialization errors early to clear corrupt or incompatible boxes
    box.values.toList();
  } catch (e) {
    debugPrint(
      'Hive initialization error (possible migration/schema mismatch): $e. Recreating box...',
    );
    await Hive.deleteBoxFromDisk('accountsBox');
    box = await Hive.openBox<AccountModel>('accountsBox');
  }

  runApp(MyApp());
}
