import 'package:flutter/material.dart';


class QuestionAnswersWidgetDichotomous extends StatelessWidget {
  final List answers;
  final String selectedAnswer;
  final Function(String) onDichotomousAnswerSelected;

  const QuestionAnswersWidgetDichotomous({super.key, 
    required this.answers,
    required this.selectedAnswer,
    required this.onDichotomousAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(answers.length, (index) {
        return RadioListTile<int>(
          title: Text(
            answers[index],
            style: const TextStyle(fontSize: 18.0),
          ),
          value: index,
          groupValue: answers.indexOf(selectedAnswer ),
          onChanged: (value) {
            onDichotomousAnswerSelected(answers[value!]);
          },
          activeColor: const Color(0xFFBB2649),
        );
      }),
    );
  }
}


