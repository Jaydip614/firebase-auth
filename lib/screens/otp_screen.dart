import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({
    super.key,
    required this.verificationId,
  });

  final String verificationId;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController otpController = TextEditingController();

  verifyOTP() async {
    try {
      PhoneAuthCredential phoneAuthCredential =
          await PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: otpController.text.toString(),
      );
      FirebaseAuth.instance.signInWithCredential(phoneAuthCredential).then(
        (value) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
          );
        },
      );
    } catch (ex) {
      log(ex.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify your OTP'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Enter OTP to verify your number',
            style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 10,
          ),
          CustomTextfield(
            controller: otpController,
            hintText: "Phone Number",
            hideText: false,
          ),
          const SizedBox(
            height: 30,
          ),
          CustomButton(
            onPressed: () {
              verifyOTP();
            },
            text: 'Verify',
          ),
        ],
      ),
    );
  }
}
