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
      backgroundColor: Colors.blue,
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(
                    "lib/assets/baby_ss.webp",
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
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
                  SizedBox(height: 20),
                  Divider(thickness: 1, color: Colors.white),
                  SizedBox(height: 20),
                  Provider.of<SignProvider>(context).isLoading
                      ? CircularProgressIndicator()
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Already have an Account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          "LogIn",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.lightBlue[200],
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
      ),
    );
  }
}
