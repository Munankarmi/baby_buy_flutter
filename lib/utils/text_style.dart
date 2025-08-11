import 'package:flutter/material.dart';

class StyleText extends StatelessWidget {
  final String text;
  final double textSize;
  final bool textWeight;
  final Color textColor;
  final double textSpace;
  const StyleText({
    this.textColor = Colors.white,
    this.textSize = 20,
    this.textWeight = false,
    this.textSpace = 1,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: textSize,
          fontWeight: textWeight ? FontWeight.bold : FontWeight.normal,
          color: textColor,
          letterSpacing: textSpace,
        ),
      ),
    );
  }
}
