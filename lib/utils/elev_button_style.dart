import 'dart:ffi';

import 'package:baby_buy/utils/text_style.dart';
import 'package:flutter/material.dart';

class ElevButtonStyle extends StatelessWidget {
  final String buttonText;
  final void Function()? buttonPressed;
  const ElevButtonStyle({
    required this.buttonText,
    required this.buttonPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: buttonPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: StyleText(
        text: buttonText,
        textWeight: true,
        textSize: 20,
        textColor: Colors.blue,
      ),
    );
  }
}
