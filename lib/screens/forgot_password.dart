import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_app/widgets/custom_button.dart';
import 'package:firebase_demo_app/widgets/custom_textfield.dart';
import 'package:firebase_demo_app/widgets/ui_helper.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  TextEditingController emailController = TextEditingController();

  forgotPassword(String email) async {
    if(email == ""){
      return UiHelper.customAlertBox(context, "Enter required fields");
    }
    else{
      FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Enter your registered email',
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
          const SizedBox(height: 30,),
          CustomButton(
              onPressed: () {
                forgotPassword(emailController.text.toString());
              },
              text: "Send Password",
          ),
        ],
      ),
    );
  }
}
