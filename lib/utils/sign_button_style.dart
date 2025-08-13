import 'package:flutter/material.dart';

class SignButtonStyle extends StatelessWidget {
  final String text;
  final Function()? onTap;
  const SignButtonStyle({required this.text, required this.onTap, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.white70,
              offset: Offset(2, 2),
              blurRadius: 4,
              spreadRadius: 1
            ),
            BoxShadow(
              color: Colors.white,
              offset: Offset(-2, -2),
              blurRadius: 2,
              spreadRadius: 1
            ),
          ]
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
