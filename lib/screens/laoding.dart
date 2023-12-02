import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quizart/services/database.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  double width = 100, height = 100, boxX = 1, boxY = 1;
  late double screenWidth, screenHeight;
  DataBaseService db = DataBaseService();

  @override
  void initState() {
    super.initState();
    //db.addQuestions("data.json");
  }


  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
            Lottie.network(
            'https://lottie.host/dc3504c4-60a6-4617-b6b8-c5a170f85421/4EoZU5taUr.json',
            fit: BoxFit.contain, // Use BoxFit.contain to avoid distortion
           ),

            Lottie.asset(
              'Json/Loading2.json',
              fit: BoxFit.contain, // Use BoxFit.contain to avoid distortion
            ),
          ]
        ),
      )
    );
  }
}
