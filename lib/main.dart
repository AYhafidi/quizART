import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizart/firebase_options.dart';
import 'package:quizart/screens/QuizChoose.dart';
import 'package:quizart/screens/home.dart';
import 'package:quizart/screens/laoding.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/quiz",
      routes: {
        "/quiz" : (context) => QuizChoose(),
        "/home" : (context) => Home(),
      },
    );
  }
}

