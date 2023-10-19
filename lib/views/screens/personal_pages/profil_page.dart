import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medica/viewmodels/auth_view_models/auth.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/medica_background.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
            child: Column(
              children: <Widget>[
                const Center(
                  child: CircleAvatar(
                    radius: 84.0,
                    backgroundImage: AssetImage('assets/images/default.jpg'),
                  ),
                ),
                _userUid(),
                _signOutButton(),
              ],
            ),
          )),
    );
  }
}
