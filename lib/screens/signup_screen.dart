import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import '../widgets/ui_helper.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    signUp(String email, String password) async {
      if(email == "" && password == ""){
        UiHelper.customAlertBox(context, "Enter Required Fields!");
      }
      else{
        UserCredential? userCredential;
        try{
          userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen(),));
          },);
        }
        on FirebaseAuthException catch(ex){
          return UiHelper.customAlertBox(context, ex.code.toString());
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
        foregroundColor: Colors.white,
        backgroundColor: Colors.purple,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextfield(
              controller: emailController,
              hideText: false,
              hintText: "Email",
          ),
          CustomTextfield(
            controller: passwordController,
            hideText: true,
            hintText: "password",
          ),
          const SizedBox(height: 30,),
          CustomButton(
              onPressed: (){
                signUp(emailController.text.toString(), passwordController.text.toString());
              },
              text: "Sign Up",
          ),
        ],
      ),
    );
  }
}
