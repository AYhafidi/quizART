import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizart/firebase_options.dart';
import 'package:quizart/screens/QuizChoose.dart';
import 'package:quizart/screens/bilan.dart';
import 'package:quizart/screens/SplashScreen.dart';
import 'package:quizart/screens/home.dart';
import 'package:quizart/screens/laoding.dart';
import 'package:quizart/screens/user_info_form.dart';
import 'package:quizart/screens/signin.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/quiz",
      routes: {
        '/': (context) => const SplashScreen(),
        '/loading':(context) => const Loading(),
        '/user_info_form': (context) => const UserInfoForm(),
        '/signin': (context) => const UserSignIn(), // Route to UserInfoForm
        '/quiz' : (context) => QuizChoose(uid: "FA7KreLYeOYtYpp7ALumLzZyNvE3"),
        '/question': (context) => Home(topic: 'Art', uid: "FA7KreLYeOYtYpp7ALumLzZyNvE3")
      },
    );
  }
}

