import 'package:baby_buy/pages/login_page.dart';
import 'package:baby_buy/providers/sign_provider.dart';
import 'package:baby_buy/utils/extensions.dart';
import 'package:baby_buy/utils/sign_button_style.dart';
import 'package:baby_buy/utils/text_field_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final registerUsernameController = TextEditingController();
  final registerEmailController = TextEditingController();
  final registerPasswordController = TextEditingController();
  final registerConfirmPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset("lib/assets/baby_ss.webp", height: 150, width: 150),
                SizedBox(height: 20),
                Text(
                  "Register Account",
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 20),
                TextFieldStyle(
                  hintText: "Username",
                  obsecureText: false,
                  textController: registerUsernameController,
                ),
                SizedBox(height: 20),
                TextFieldStyle(
                  hintText: "Email",
                  obsecureText: false,
                  textController: registerEmailController,
                ),
                SizedBox(height: 20),

                TextFieldStyle(
                  hintText: "Password",
                  obsecureText: true,
                  textController: registerPasswordController,
                ),
                SizedBox(height: 20),

                TextFieldStyle(
                  hintText: "Confirm-Password",
                  obsecureText: true,
                  textController: registerConfirmPasswordController,
                ),
                SizedBox(height: 40),
                Divider(thickness: 1, color: Colors.black),
                SizedBox(height: 30),
                Provider.of<SignProvider>(context).isLoading
                    ? CircularProgressIndicator(color: Colors.black,)
                    : SignButtonStyle(
                        text: "Register",
                        onTap: () {
                          context.signProvider.registerUser(
                            registerUsernameController.text,
                            registerEmailController.text,
                            registerPasswordController.text,
                            registerConfirmPasswordController.text,
                            context,
                          );
                        },
                      ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Already have an Account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        "LogIn",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
