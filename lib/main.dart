import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizart/firebase_options.dart';
import 'package:quizart/screens/QuizChoose.dart';
import 'package:quizart/screens/home.dart';
import 'package:quizart/screens/laoding.dart';
import 'package:quizart/screens/home_page.dart';
import 'package:quizart/screens/user_info_form.dart';
import 'package:quizart/screens/signin.dart';

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
      initialRoute: "/",
      routes: {
        '/': (context) => HomePage(),
        "/quiz" : (context) => QuizChoose(),
        "/home" : (context) => Home(),
        '/user_info_form': (context) => UserInfoForm(),
        '/signin': (context) => UserSignIn(), // Route to UserInfoForm
      },
    );
  }
}

