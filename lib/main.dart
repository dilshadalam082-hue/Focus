import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'config.dart';
import 'screens/auth_screen.dart';
import 'screens/main_shell.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  runApp(const FocusApp());
}
class FocusApp extends StatelessWidget {
  const FocusApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'FOCUS',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6755D8)), useMaterial3: true),
    home: Supabase.instance.client.auth.currentSession == null ? const AuthScreen() : const MainShell(),
  );
}
