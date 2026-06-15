import 'package:finance/src/app.dart';
import 'package:finance/src/core/utils/supabase_logger.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://jugebomzlkpdxemmjwkc.supabase.co',
    anonKey: 'sb_publishable_1fG6Sn2VRER4QnyONLvgUg_1SRAt6aR',
    debug: true,
    httpClient: SupabaseLoggingClient(),
  );

  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}
