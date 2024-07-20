import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo_app/screens/home_screen.dart';
import 'package:firebase_demo_app/widgets/custom_button.dart';
import 'package:firebase_demo_app/widgets/custom_textfield.dart';
import 'package:firebase_demo_app/widgets/ui_helper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewSignupScreen extends StatefulWidget {
  const NewSignupScreen({super.key});

  @override
  State<NewSignupScreen> createState() => _NewSignupScreenState();
}

class _NewSignupScreenState extends State<NewSignupScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? pickedImage;

  signUp(String email, String password) async {
    if(email == "" && password == "" && pickedImage == null){
      UiHelper.customAlertBox(context, "Enter required fields!");
    }
    else{
      UserCredential? userCredential;
      try{
        userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email, password: password).then((value) {
              uploadData(email);
            },);
      }
      on FirebaseAuthException catch(ex){
        UiHelper.customAlertBox(context, ex.code.toString());
      }
    }
  }

  uploadData(String email) async {
    UploadTask uploadTask = FirebaseStorage.instance.ref("Profile Pics").child(email).putFile(pickedImage!);
    TaskSnapshot taskSnapshot = await uploadTask;
    String url = await taskSnapshot.ref.getDownloadURL();
    FirebaseFirestore.instance.collection("Users").doc(email).set({
      "Email" : email,
      "Image" : url,
    }).then((value) {
      log("User data uploaded successfully");
      Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen(),));
    },);
  }

  showAlertBox(){
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Choose your image"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  onTap: () {
                    pickImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.camera_alt),
                  title: const Text('Camara', style: TextStyle(fontWeight: FontWeight.w500,),
                  ),
                ),
                ListTile(
                  onTap: () {
                    pickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  leading: const Icon(Icons.image),
                  title: const Text("Gallery", style: TextStyle(fontWeight: FontWeight.w500,),
                ),
                )
              ],
            ),
          );
        },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Sign Up'),
        centerTitle: true,
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 100,),
            InkWell(
              onTap: () {
                showAlertBox();
              },
              child: pickedImage == null ? const CircleAvatar(
                radius: 80,
                child: Icon(Icons.person, size: 80,),
              ): CircleAvatar(
                radius: 80,
                backgroundImage: FileImage(pickedImage!),
              )
            ),
            const SizedBox(height: 30,),
            CustomTextfield(
                controller: emailController,
                hintText: "Email",
                hideText: false,
            ),
            CustomTextfield(
              controller: passwordController,
              hintText: "Password",
              hideText: true,
            ),
            const SizedBox(height: 30,),
            CustomButton(
                onPressed: () {
                  signUp(emailController.text.toString(), passwordController.text.toString());
                },
                text: "Sign Up",
            ),
          ],
        ),
      ),
    );
  }

  pickImage(ImageSource imageSource) async {
    try{
      final image = await ImagePicker().pickImage(source: imageSource);
      if(image == null) return;
      final tempImage = File(image.path);
      setState(() {
        pickedImage = tempImage;
      });
    }
    catch(ex){
      log(ex.toString());
    }
  }
}
