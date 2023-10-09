// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medica/config/config.dart';
import 'package:medica/data/models/user_model.dart';

class SignUpViewModel extends ChangeNotifier {
  bool obsecurePassword = true;
  bool obsecurePassword2 = true;
  final UserModel user = UserModel(
    firstName: '',
    lastName: '',
    email: '',
    password: '',
  );
  final ImagePicker _picker = ImagePicker();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void updateFirstName(String value) {
    user.firstName = value;
    notifyListeners();
  }

  void updateLastName(String value) {
    user.lastName = value;
    notifyListeners();
  }

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

  bool confirmPassword(BuildContext context) {
    if (passwordController.text != confirmPasswordController.text) {
      showSnackBarMessage(context, 'please confirm your password');
      notifyListeners();
      return false;
    } else {
      return true;
    }
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

  void togglePasswordVisibility2() {
    obsecurePassword2 = !obsecurePassword2;
    notifyListeners();
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      user.updateImageFile(File(pickedFile.path));
      notifyListeners();
    }
  }

  void controllerToString() {
    user.updateFirstName(firstNameController.text.trim());
    user.updateLastName(lastNameController.text.trim());
    user.updateEmail(emailController.text.trim());
    user.updatePassword(passwordController.text.trim());
  }
}
