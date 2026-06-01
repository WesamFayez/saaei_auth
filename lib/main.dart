import 'package:flutter/material.dart';
import 'auth/login/screen/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Saaei Auth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2D7D76)),
        useMaterial3: true,
        fontFamily: 'Cairo',
      ),
      home: const LoginScreen(),
    );
  }
}
