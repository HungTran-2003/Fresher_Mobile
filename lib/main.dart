import 'package:crud_app/src/app.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:crud_app/models/account_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('Firebase initialization failed: $e');
  }

  await Hive.initFlutter();
  Hive.registerAdapter(AccountModelAdapter());
  await Hive.openBox<AccountModel>('accountsBox');

  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}
