import 'package:flutter/material.dart';

class QuestionHolder extends StatelessWidget {
  final String text;

  QuestionHolder({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xffffa404),
      ),
      child: Center(
        child: Text(this.text),
      ),
    );
  }
}
