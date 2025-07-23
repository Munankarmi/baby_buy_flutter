import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("lib/assets/baby_ss.webp"),
            SizedBox(height: 50),
            Text(
              "BabyBuy",
              style: TextStyle(
                fontSize: 45,
                fontWeight: FontWeight.bold,
                letterSpacing: 8.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
