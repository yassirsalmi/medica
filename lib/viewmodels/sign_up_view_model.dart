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
    user.updateFirstName(value);
    notifyListeners();
  }

  void updateLastName(String value) {
    user.updateLastName(value);
    notifyListeners();
  }

  void updateEmail(String value) {
    user.updateEmail(value);
    notifyListeners();
  }

  void updatePassword(String value) {
    user.updatePassword(value);
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

  void confirmPassword(BuildContext context) {
    if (passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty) {
      if (passwordController.text != confirmPasswordController.text) {
        showSnackBarMessage(context, 'please confirm your password');
      }
    } else {
      showSnackBarMessage(context, 'password field can\'t be empty');
    }

    notifyListeners();
  }

  void confirmEmail(BuildContext context) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';

    final regex = RegExp(pattern);
    final email = emailController.text.trim();

    if (email.isEmpty) {
      showSnackBarMessage(context, 'email field can\'t be empty');
      notifyListeners();
    } else if (!regex.hasMatch(email)) {
      showSnackBarMessage(context, 'Enter a valid email address');
      notifyListeners();
    } else {}
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

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  void controllerToString() {
    user.updateFirstName(firstNameController.text.trim());
    user.updateLastName(lastNameController.text.trim());
    user.updateEmail(emailController.text.trim());
    user.updatePassword(passwordController.text.trim());
  }

  // Future<void> saveUser() async {
  //   final userCollection = FirebaseFirestore.instance.collection('users');
  //   final userId = FirebaseAuth.instance.currentUser!.uid;
  //   await userCollection.doc(userId).set({
  //     'email': user.email,
  //     'firstName': user.firstName,
  //     'lastName': user.lastName,
  //   });
  // }

  // Future<void> signUp(BuildContext context) async {
  //   controllerToString();
  //   try {
  //     await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //       email: user.email,
  //       password: user.password,
  //     );
  //     saveUser();

  //     Navigator.of(context).pushNamed('/');
  //   } catch (exp) {
  //     String errorMessage =
  //         'An error occurred during sign up. Please try again.';
  //     if (exp is FirebaseAuthException) {
  //       errorMessage = exp.message ?? errorMessage;
  //     }

  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(errorMessage),
  //        backgroundColor: Config.primaryColor,
  // behavior: SnackBarBehavior.floating,),
  //     );
  //   }
  // }
}
