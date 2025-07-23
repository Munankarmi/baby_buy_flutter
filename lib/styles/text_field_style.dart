import 'package:flutter/material.dart';

class TextFieldStyle extends StatelessWidget {
  final String hintText;
  final TextEditingController textController;
  bool obsecureText;
  double textFieldSize;
  TextFieldStyle(
  {
    this.obsecureText= false,
    this.textFieldSize = 12.0,
    required this.hintText,
    required this.textController,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
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
