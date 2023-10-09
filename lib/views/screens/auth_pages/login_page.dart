// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:medica/config/config.dart';
import 'package:medica/views/widgets/auth_widgets/login_form.dart';
import 'package:medica/views/widgets/auth_widgets/social_button.dart';
import 'package:medica/utils/text.dart';
//this is the login screen of our app medica
//the login form is in a nother file named loginform.dart
//i tried to separate the ui from the business part
//so i can go back to the code source and understand what i did

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Image.asset(
                    'assets/images/logo.PNG',
                    height: 100,
                  ),
                  Column(
                    children: [
                      Config.bigSpace,
                      Text(
                        Apptext.enText['welcome_text']!,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Config.smallSpace,
                      Text(
                        Apptext.enText['signIn_text']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Config.smallSpace,
              LoginForm(),
              Config.smallSpace,
              Center(
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        Apptext.enText['forgotPassword_text']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Are You A Doctor?',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Click here',
                            style: TextStyle(
                              fontSize: 16,
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
              const Spacer(),
              Center(
                child: Text(
                  Apptext.enText['socialLogin_text']!,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
              Config.smallSpace,
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SocialButton(social: 'facebook'),
                  SocialButton(social: 'google'),
                ],
              ),
              Config.smallSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    Apptext.enText['signUp_text']!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey.shade500,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ));
  }
}
