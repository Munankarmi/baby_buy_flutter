import 'package:baby_buy/pages/home_page.dart';
import 'package:baby_buy/pages/login_page.dart';
import 'package:baby_buy/pages/register_page.dart';
import 'package:baby_buy/pages/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}