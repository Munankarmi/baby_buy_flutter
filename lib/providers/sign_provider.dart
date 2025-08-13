import 'package:baby_buy/pages/home_page.dart';
import 'package:baby_buy/utils/elev_button_style.dart';
import 'package:baby_buy/utils/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String _userName = '';
  String get userName => _userName;
  Future<void> signinUser(
    String userEmail,
    String userPassword,
    BuildContext context,
  ) async {
    _isLoading = true;
    notifyListeners();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = getErrorMessage(e.code);
      if (context.mounted) {
        showErrorDialog(context, errorMessage);
      }
    } catch (e) {
      if (context.mounted) {
        showErrorDialog(context, "An unexpected error occured, plz try again");
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  String getErrorMessage(String errorCode) {
    switch (errorCode) {
      case 'user-not-found':
        return 'No user found with this email address.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'invalid-email':
        return 'Please enter a valid email address.';
      case 'user-disabled':
        return 'This account has been disabled.';
      case 'too-many-requests':
        return 'Too many failed attempts. Please try again later.';
      case 'invalid-credential':
        return 'Invalid email or password. Please check your credentials.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection.';
      default:
        return 'Login failed. Please try again.';
    }
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: StyleText(text: "LogIn Error"),
          content: StyleText(text: message),
          backgroundColor: Colors.grey,
          actions: [
            ElevButtonStyle(
              buttonText: "Okay",
              buttonPressed: () => Navigator.pop(context),
            ),
          ],
        );
      },
    );
  }

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  Future<void> registerUser(
    String registerfullName,
    String registerEmail,
    String registerPassword,
    String registerConfirmPassword,
    BuildContext context,
  ) async {
    _isLoading = true;
    notifyListeners();
    try {
      if (registerPassword == registerConfirmPassword) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: registerEmail,
          password: registerPassword,
        );
        _userName = registerfullName;
        notifyListeners();
        success(context);
      }
    } on FirebaseAuthException {
      if (context.mounted) {
        return showErrorDialog(context, "Password didn't matched.");
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void success(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey,
          title: StyleText(
            text: "User created Successfully",
            textColor: Colors.black,
            textWeight: true,
          ),
          content: ElevButtonStyle(
            buttonText: "Okay",
            buttonPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
        );
      },
    );
  }
}
