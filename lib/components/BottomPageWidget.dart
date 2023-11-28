import 'package:flutter/material.dart';

class  BottomPageWidget extends StatelessWidget {

  final Function() goToPreviousQuestion;
  final Function() goToNextQuestion;

  const BottomPageWidget({super.key, required this.goToPreviousQuestion, required this.goToNextQuestion});

  @override
  Widget build(BuildContext context) {
    return Container(
    child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                onPressed: goToPreviousQuestion,
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xFFBB2649)),
                ),
                child: const Text('Previous Question'),
                ),
                ),
          Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                onPressed: goToNextQuestion,
                style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xFFBB2649)),
                ),
                child: const Text('Next Question'),
                ),
                ),
      ],
    ),
    );
  }
}
