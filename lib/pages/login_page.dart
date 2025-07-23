import 'package:baby_buy/pages/home_page.dart';
import 'package:baby_buy/pages/register_page.dart';
import 'package:baby_buy/styles/sign_button_style.dart';
import 'package:baby_buy/styles/text_field_style.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

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
      backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              Image.asset("lib/assets/baby_ss.webp", width: 150, height: 150),
              SizedBox(height: 30),
              Text(
                "LogIn",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
              SizedBox(height: 30),

              TextFieldStyle(
                hintText: "Username",
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
                  ),
                  Text("Remember me"),
                ],
              ),
              SizedBox(height: 15),

              Divider(thickness: 1, color: Colors.white),
              SizedBox(height: 30),
              SignButtonStyle(
                text: "Sign-In",
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
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
                        color: Colors.lightBlue[200],
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
