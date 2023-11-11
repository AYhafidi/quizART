import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final String text;

  QuestionWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          this.text,
          style: TextStyle(
            fontSize: 21.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center, // Center the text
        ),
      ),
    );
  }
}
