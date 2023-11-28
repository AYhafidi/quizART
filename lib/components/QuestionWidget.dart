import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final String text;

  const QuestionWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 21.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center, // Center the text
        ),
      ),
    );
  }
}
