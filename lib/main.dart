import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_demo_app/firebase_options.dart';
import 'package:firebase_demo_app/notification_services.dart';
import 'package:firebase_demo_app/screens/check_user.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await NotificationServices.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CheckUser(),
    );
  }
}
