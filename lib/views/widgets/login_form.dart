import 'package:flutter/material.dart';
import 'package:medica/config/config.dart';
import 'package:medica/viewmodels/login_page_view_model.dart';
import 'package:medica/views/widgets/button.dart';
import 'package:medica/views/widgets/fields.dart';
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
                  // viewModel.validateEmail,
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
                        viewModel.login();
                        if (viewModel.isLoading) {
                          const CircularProgressIndicator();
                        }
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('try to connect to hame page')),
                        );
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
