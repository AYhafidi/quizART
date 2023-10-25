import 'package:demo/screens/loading.dart';
import 'package:flutter/material.dart';
import 'package:demo/screens/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:demo/firebase_options.dart';
import 'package:demo/screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
          "/" : (context) => Welcome(),
          "/home" : (context) => Home(),

      },
    );
  }
}
