import 'package:firebase_demo_app/screens/contacts.dart';
import 'package:firebase_demo_app/screens/new_signup_screen.dart';
import 'package:firebase_demo_app/screens/phone_auth_screen.dart';
import 'package:firebase_demo_app/screens/user_profile.dart';
import 'package:firebase_demo_app/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
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
                      MaterialPageRoute(builder: (context) => const UserProfile(),));
                },
                text: 'Your Profile',
            ),
            const SizedBox(height: 20,),
            CustomButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const PhoneAuthScreen(),));
              },
              text: 'Verify Phone No',
            ),
            const SizedBox(height: 20,),
            CustomButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Contacts(),),
                );
              },
              text: 'Contacts',
            ),
            const SizedBox(height: 20,),
            CustomButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NewSignupScreen(),),
                );
              },
              text: 'New SignUp',
            ),
          ],
        ),
    );
  }
}
