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
            fontSize: 24.0,
            fontFamily: 'Lexend',
            color: Color(0xFF262626),

          ),
          textAlign: TextAlign.center, // Center the text
        ),
      ),

    );
  }
}
