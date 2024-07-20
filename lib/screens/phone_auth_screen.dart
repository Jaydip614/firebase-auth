import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_app/screens/otp_screen.dart';
import 'package:firebase_demo_app/widgets/custom_button.dart';
import 'package:firebase_demo_app/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class PhoneAuthScreen extends StatefulWidget {
  const PhoneAuthScreen({super.key});

  @override
  State<PhoneAuthScreen> createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  TextEditingController phoneController = TextEditingController();

  sendOTP() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
      verificationFailed: (FirebaseAuthException error) {},
      codeSent: (String verificationId, int? forceResendingToken) {
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => OTPScreen(verificationId: verificationId,),));
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
      phoneNumber: phoneController.text.toString(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Phone Authentication'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Enter your phone number to verify',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextfield(
            controller: phoneController,
            hintText: "Phone Number",
            hideText: false,
          ),
          const SizedBox(
            height: 30,
          ),
          CustomButton(
            onPressed: () {
              sendOTP();
            },
            text: 'Verify',
          ),
        ],
      ),
    );
  }
}
