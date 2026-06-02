import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'home_page.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    print("1");

    await dotenv.load(fileName: ".env");
    print("2");

    await Supabase.initialize(
      url: dotenv.env['SUPABASE_URL']!,
      anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
    );
    print("3");

    await Supabase.instance.client.auth.signInWithPassword(
      email: dotenv.env['SUPABASE_EMAIL']!,
      password: dotenv.env['SUPABASE_PASSWORD']!,
    );
    print("4");

    print(dotenv.env['SUPABASE_URL']);
    print(Supabase.instance.client.auth.currentUser);

    runApp(const MyApp());

  } catch (e, stackTrace) {
    print("ERROR:");
    print(e);
    print(stackTrace);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}