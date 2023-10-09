import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medica/viewmodels/auth_view_models/auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? user = Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
    if (!context.mounted) return;
    Navigator.pushReplacementNamed(context, '/login');
  }

  Widget _userUid() {
    return Text(user?.email ?? "user email");
  }

  Widget _signOutButton() {
    return ElevatedButton(onPressed: signOut, child: const Text("signout"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: _userUid(),
        ),
        body: Center(
          child: _signOutButton(),
        ));
  }
}
