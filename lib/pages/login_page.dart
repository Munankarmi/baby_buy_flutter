import 'package:baby_buy/pages/register_page.dart';
import 'package:baby_buy/providers/sign_provider.dart';
import 'package:baby_buy/utils/extensions.dart';
import 'package:baby_buy/utils/sign_button_style.dart';
import 'package:baby_buy/utils/text_field_style.dart';
import 'package:baby_buy/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameTextController = TextEditingController();
  final usernamePasswordController = TextEditingController();
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Image.asset("lib/assets/baby_ss.webp", width: 150, height: 150),
              SizedBox(height: 30),
              Text(
                "Login Account",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(height: 30),

              TextFieldStyle(
                hintText: "Email or Username",
                obsecureText: false,
                textController: usernameTextController,
              ),
              SizedBox(height: 20),
              TextFieldStyle(
                hintText: "Password",
                obsecureText: true,
                textController: usernamePasswordController,
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Checkbox(
                    value: checked,
                    onChanged: (value) {
                      setState(() {
                        checked = value!;
                      });
                    },
                    activeColor: Colors.black,
                  ),
                  StyleText(
                    text: "Remember me",
                    textSpace: 0,
                    textSize: 16,
                    textWeight: true,
                    textColor: Colors.black,
                  ),
                ],
              ),
              SizedBox(height: 15),

              Divider(thickness: 1, color: Colors.black),
              SizedBox(height: 30),
              Provider.of<SignProvider>(context).isLoading
                  ? CircularProgressIndicator(color: Colors.black)
                  : SignButtonStyle(
                      text: "Sign-In",
                      onTap: () {
                        context.signProvider.signinUser(
                          usernameTextController.text.trim(),
                          usernamePasswordController.text.trim(),
                          context,
                        );
                      },
                    ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Don't have an Account yet?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
