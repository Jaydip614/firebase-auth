import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_app/screens/login_screen.dart';
import 'package:firebase_demo_app/screens/user_details.dart';
import 'package:firebase_demo_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {

  logOut() async {
    FirebaseAuth.instance.signOut().then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen(),));
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Profile'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
          ),
          CustomButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserDetails(),),
              );
            },
            text: "Add details",
          ),
          const SizedBox(height: 20,),
          CustomButton(
            onPressed: () {
              logOut();
            },
            text: "Logout",
          ),
        ],
      ),
    );
  }
}
