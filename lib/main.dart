import 'package:baby_buy/pages/home_page.dart';
import 'package:baby_buy/pages/login_page.dart';
import 'package:baby_buy/pages/register_page.dart';
import 'package:baby_buy/pages/splash_screen.dart';
import 'package:baby_buy/providers/category_provider.dart';
import 'package:baby_buy/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CategoryProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage());
  }
}
