import 'package:flutter/material.dart';

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

  void _moveBox() {
    setState(() {
      height = screenHeight;
      width = screenWidth;
      boxX = 100; // Changing the alignment value to animate box movement
      boxY = 100; // Changing the alignment value to animate box movement
    });
  }

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GestureDetector(
        onTap: _moveBox,
        child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            color: Colors.cyanAccent,
            width: width,
            height: height,
            margin: EdgeInsets.only(left: boxX, top: boxY), // Use margin to position the container
          ),
      ),
    );
  }
}
