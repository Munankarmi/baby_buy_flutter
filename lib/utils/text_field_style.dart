import 'package:flutter/material.dart';

class TextFieldStyle extends StatelessWidget {
  final String hintText;
  final TextEditingController textController;
  final TextInputType kType;
  final bool obsecureText;
  final double textFieldSize;
  const TextFieldStyle({
    this.kType = TextInputType.text,
    this.obsecureText = false,
    this.textFieldSize = 12.0,
    required this.hintText,
    required this.textController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      keyboardType: kType,
      obscureText: obsecureText,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: textFieldSize),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        fillColor: Colors.lightBlue[200],
        filled: true,
        hintText: hintText,
      ),
    );
  }
}
