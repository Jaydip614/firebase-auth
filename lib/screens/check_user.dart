import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_app/screens/home_screen.dart';
import 'package:firebase_demo_app/screens/login_screen.dart';
import 'package:flutter/material.dart';

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: FirebaseAuth.instance.authStateChanges().first,
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        else if (snapshot.hasData) {
          return const HomeScreen();
        }
        else {
          return const LoginScreen();
        }
      },
    );
  }
}