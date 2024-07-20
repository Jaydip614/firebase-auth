import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_app/screens/forgot_password.dart';
import 'package:firebase_demo_app/screens/home_screen.dart';
import 'package:firebase_demo_app/screens/signup_screen.dart';
import 'package:firebase_demo_app/widgets/ui_helper.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login(String email, String password) async {
    if(email == "" && password == ""){
      UiHelper.customAlertBox(context, "Enter Required Fields");
    }
    else{
      UserCredential? userCredential;
      try{
        userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(),));
        },
        );
      }
      on FirebaseAuthException catch(ex){
        return UiHelper.customAlertBox(context, ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login In'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomTextfield(
              controller: emailController,
              hideText: false,
              hintText: 'Email',
          ),
          CustomTextfield(
            controller: passwordController,
            hideText: true,
            hintText: 'Password',
          ),
          const SizedBox(height: 30,),
          CustomButton(
            onPressed: () {
              login(emailController.text.toString(), passwordController.text.toString());
            },
            text: 'Login',
          ),
          const SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already have an Account?",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              TextButton(
                  onPressed: (){
                    Navigator.push(
                      context, MaterialPageRoute(builder: (context) => const SignupScreen(),),
                    );
                  },
                  child: const Text('Sign Up',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ForgotPassword(),),
              );
            },
            child: const Text('Forgot Password?',
              style: TextStyle(
                fontSize: 16,
              ),),
          ),
        ],
      ),
    );
  }
}
