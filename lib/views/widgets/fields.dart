import 'package:flutter/material.dart';

Widget personalInfoField(
  String labelText,
  String hintText,
  TextEditingController controller,
  Icon icon,
  Color color,
  void Function(dynamic value) param4,
) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.emailAddress,
    cursorColor: color,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'this field can\'t be empty';
      }
      return null;
    },
    decoration: InputDecoration(
      hintText: hintText,
      labelText: labelText,
      alignLabelWithHint: true,
      prefixIcon: icon,
      prefixIconColor: color,
    ),
  );
}

Widget emailField(
  String labelText,
  String hintText,
  TextEditingController controller,
  String? Function(String?)? validateEmail,
  Color color,
  void Function(dynamic value) param4,
) {
  return TextFormField(
    controller: controller,
    keyboardType: TextInputType.emailAddress,
    cursorColor: color,
    validator: validateEmail,
    // (value) {
    //   if (value == null || value.isEmpty) {
    //     return 'Please enter your email';
    //   }
    //   return null;
    // },
    decoration: InputDecoration(
      hintText: 'Email Adresse',
      labelText: 'Email',
      alignLabelWithHint: true,
      prefixIcon: const Icon(Icons.email_outlined),
      prefixIconColor: color,
    ),
  );
}

Widget passwordField(
  String labelText,
  String hintText,
  TextEditingController controller,
  Color color,
  bool obsecurePassword,
  VoidCallback togglePasswordVisibility,
) {
  return TextFormField(
    keyboardType: TextInputType.visiblePassword,
    controller: controller,
    cursorColor: color,
    obscureText: obsecurePassword,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter your password';
      }
      return null;
    },
    decoration: InputDecoration(
      hintText: hintText,
      labelText: labelText,
      alignLabelWithHint: true,
      prefixIcon: const Icon(Icons.lock_outline),
      prefixIconColor: color,
      suffixIcon: IconButton(
        onPressed: togglePasswordVisibility,
        icon: obsecurePassword
            ? const Icon(
                Icons.visibility_off_outlined,
                color: Colors.black38,
              )
            : Icon(
                Icons.visibility_outlined,
                color: color,
              ),
      ),
    ),
  );
}

Widget confirmPasswordField(
  String labelText,
  String hintText,
  TextEditingController confirmController,
  Color color,
  bool obsecurePassword,
  VoidCallback togglePasswordVisibility,
) {
  return TextFormField(
    keyboardType: TextInputType.visiblePassword,
    controller: confirmController,
    cursorColor: color,
    obscureText: obsecurePassword,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please confirm your password';
      }
      return null;
    },
    decoration: InputDecoration(
      hintText: hintText,
      labelText: labelText,
      alignLabelWithHint: true,
      prefixIcon: const Icon(Icons.lock_outline),
      prefixIconColor: color,
      suffixIcon: IconButton(
        onPressed: togglePasswordVisibility,
        icon: obsecurePassword
            ? const Icon(
                Icons.visibility_off_outlined,
                color: Colors.black38,
              )
            : Icon(
                Icons.visibility_outlined,
                color: color,
              ),
      ),
    ),
  );
}
