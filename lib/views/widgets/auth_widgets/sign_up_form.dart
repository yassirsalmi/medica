// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medica/config/config.dart';
import 'package:medica/viewmodels/auth_view_models/sign_up_view_model.dart';
import 'package:medica/views/widgets/auth_widgets/button.dart';
import 'package:medica/views/widgets/auth_widgets/fields.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  bool obsecurePassword = true;
  bool obsecurePassword2 = true;
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  SignUpViewModel viewModel = SignUpViewModel();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ChangeNotifierProvider<SignUpViewModel>(
        create: (_) => SignUpViewModel(),
        child: Consumer<SignUpViewModel>(
          builder: (context, viewModel, _) {
            return Form(
              key: _formKey,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    profilePicture(viewModel),
                    Config.smallSpace,
                    personalInfoField(
                      'First name',
                      'First name',
                      viewModel.firstNameController,
                      const Icon(Icons.person),
                      Config.primaryColor,
                      (value) => viewModel.updateFirstName(value),
                    ),
                    Config.smallSpace,
                    personalInfoField(
                      'Last name',
                      'Last name',
                      viewModel.lastNameController,
                      const Icon(Icons.person),
                      Config.primaryColor,
                      (value) => viewModel.updateLastName(value),
                    ),
                    Config.smallSpace,
                    emailField(
                      'Email',
                      'Email Adresse',
                      viewModel.emailController,
                      Config.primaryColor,
                      (value) => viewModel.updateEmail(value),
                    ),
                    Config.smallSpace,
                    passwordField(
                      'Password',
                      'Password',
                      viewModel.passwordController,
                      Config.primaryColor,
                      viewModel.obsecurePassword,
                      viewModel.togglePasswordVisibility,
                    ),
                    Config.smallSpace,
                    confirmPasswordField(
                      'Confirm Your Password',
                      'Confirm Your Password',
                      viewModel.confirmPasswordController,
                      Config.primaryColor,
                      viewModel.obsecurePassword2,
                      viewModel.togglePasswordVisibility2,
                    ),
                    Config.smallSpace,
                    Button(
                      width: double.infinity,
                      title: 'Sign In',
                      disable: false,
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          //after validate that the form field is not empty
                          //we pass to confirm email format and confirmation
                          //of password so we process data and let the user
                          //sign up and create a new account
                          if (viewModel.confirmEmail(this.context) &&
                              viewModel.confirmPassword(this.context)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget profilePicture(viewModel) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: _imageFile == null
              ? const AssetImage('assets/images/default.jpg')
              : FileImage(File(_imageFile!.path)) as ImageProvider,
        ),
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: ((builder) => bottomSheet()),
            );
          },
          child: const Padding(
            padding: EdgeInsets.only(bottom: 8, right: 8),
            child: Icon(
              Icons.camera_alt,
              color: Config.primaryColor,
              size: 32,
            ),
          ),
        )
      ],
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: double.infinity,
      margin: const EdgeInsetsDirectional.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: [
          const Text(
            'Choose Your Profile Picture',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Config.smallSpace,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                child: Row(
                  children: const [
                    Icon(
                      Icons.camera_alt_outlined,
                      size: 36,
                    ),
                    Text('Camera')
                  ],
                ),
                onTap: () {
                  takePhoto(ImageSource.camera);
                },
              ),
              SizedBox(
                width: 32,
              ),
              GestureDetector(
                child: Row(
                  children: const [
                    Icon(
                      Icons.image,
                      size: 36,
                    ),
                    Text('Gallery')
                  ],
                ),
                onTap: () {
                  takePhoto(ImageSource.gallery);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.pickImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
    });
  }
}
/*

*/
