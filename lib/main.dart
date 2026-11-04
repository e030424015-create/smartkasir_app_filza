import 'package:flutter/material.dart';
import 'pages/splash_screen_page.dart';

void main() {
  runApp(const SmartKasirApp());
}

class SmartKasirApp extends StatelessWidget {
  const SmartKasirApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartKasir',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        // Tantangan Live Tweak 1: Tema Warna Baru (Burgundy)
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF800020),
          primary: const Color(0xFF800020),
          secondary: const Color(0xFFFF69B4),
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          elevation: 2,
          backgroundColor: Color(0xFF800020),
          foregroundColor: Colors.white,
        ),
      ),
      home: const SplashScreenPage(),
    );
  }
}