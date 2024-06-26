import 'package:flutter/material.dart';
import 'package:medica/config/config.dart';
import 'package:medica/viewmodels/auth_view_models/login_page_view_model.dart';
import 'package:medica/views/widgets/auth_widgets/button.dart';
import 'package:medica/views/widgets/auth_widgets/fields.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();

  LoginPageViewModel viewModel = LoginPageViewModel();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginPageViewModel>(
      create: (_) => LoginPageViewModel(),
      child: Consumer<LoginPageViewModel>(
        builder: (context, viewModel, _) {
          return Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
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
                //login button
                Button(
                  width: double.infinity,
                  title: 'Sign In',
                  disable: false,
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      if (viewModel.confirmEmail(context)) {
                        viewModel.signInWithEmailAndPassword();
                        Navigator.pushReplacementNamed(context, '/main');
                      }
                    }
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
