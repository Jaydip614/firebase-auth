import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo_app/screens/home_screen.dart';
import 'package:firebase_demo_app/widgets/custom_button.dart';
import 'package:firebase_demo_app/widgets/custom_textfield.dart';
import 'package:firebase_demo_app/widgets/ui_helper.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({super.key});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController professionController = TextEditingController();

  addDetails(String email, String name, String profession) async {
    if(email == "" && name == "" && profession == ""){
      UiHelper.customAlertBox(context, "Enter required fields!");
    }
    else{
      FirebaseFirestore.instance.collection("Users").doc(email).set({
        "Name" : name,
        "Profession" : profession,
      }).then((value) {
        log("Data inserted successfully");
        Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
      },);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Details'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Enter more details about you',
            style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500
            ),
          ),
          const SizedBox(height: 10,),
          CustomTextfield(
            controller: emailController,
            hintText: "Email",
            hideText: false,
          ),
          CustomTextfield(
            controller: nameController,
            hintText: "Name",
            hideText: false,
          ),
          CustomTextfield(
            controller: professionController,
            hintText: "Profession",
            hideText: false,
          ),
          const SizedBox(height: 30,),
          CustomButton(
              onPressed: () {
                addDetails(
                    emailController.text.toString(),
                    nameController.text.toString(),
                    professionController.text.toString(),
                );
              },
              text: "Save",
          ),
        ],
      ),
    );
  }
}
