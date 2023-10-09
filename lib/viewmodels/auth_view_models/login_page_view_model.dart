import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medica/config/config.dart';
import 'package:medica/data/models/user_model.dart';
import 'package:medica/viewmodels/auth_view_models/auth.dart';

class LoginPageViewModel extends ChangeNotifier {
  final UserModel user = UserModel(
    firstName: '',
    lastName: '',
    email: '',
    password: '',
  );

  // bool _isLoading = false;
  bool obsecurePassword = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // bool get isLoading => _isLoading;

  void updateEmail(String value) {
    user.email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    user.password = value;
    notifyListeners();
  }

  void showSnackBarMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Config.primaryColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  bool confirmEmail(BuildContext context) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';

    final regex = RegExp(pattern);
    final email = emailController.text.trim();

    if (!regex.hasMatch(email)) {
      showSnackBarMessage(context, 'Enter a valid email address');
      notifyListeners();
      return false;
    } else {
      return true;
    }
  }

  void togglePasswordVisibility() {
    obsecurePassword = !obsecurePassword;
    notifyListeners();
  }

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
    } on FirebaseAuthException {
      // on error msg is displayed
    }
  }
}
