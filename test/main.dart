import 'package:flutter/material.dart';
import 'Screens/pestana_resumen.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Terry App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage()//const PestanaResumen(), // 👈 ESTA ES LA CLAVE
    );
  }
}