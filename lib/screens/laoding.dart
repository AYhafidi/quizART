import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quizart/services/database.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  DataBaseService db = DataBaseService();

  @override
  void initState() {
    super.initState();
    //db.addQuestions("Json/data.json");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery. of(context). size. width,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:[
           Expanded(
             flex: 1,
               child: SizedBox()
           ),
            Expanded(
              flex: 5,
              child: Lottie.network(
              "https://lottie.host/dc3504c4-60a6-4617-b6b8-c5a170f85421/4EoZU5taUr.json",
              fit: BoxFit.contain, // Use BoxFit.contain to avoid distortion
                         ),
            ),

            Expanded(
              flex: 4,
              child: Lottie.network(
                "https://lottie.host/4864bf78-0ad1-4b74-8667-b0ed4cb1cd55/v1cbhRb6q2.json",
                fit: BoxFit.contain, // Use BoxFit.contain to avoid distortion
              ),
            ),
          ]
        ),
      )
    );
  }
}
