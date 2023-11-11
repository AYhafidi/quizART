import 'package:flutter/material.dart';


class QuestionAnswersWidgetDichotomous extends StatelessWidget {
  final List answers;
  final int selectedAnswerIndex;
  final Function(String ,int) onDichotomousAnswerSelected;

  QuestionAnswersWidgetDichotomous({
    required this.answers,
    required this.selectedAnswerIndex,
    required this.onDichotomousAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(answers.length, (index) {
        return RadioListTile<int>(
          title: Text(
            answers[index],
            style: TextStyle(fontSize: 18.0),
          ),
          value: index,
          groupValue: selectedAnswerIndex,
          onChanged: (value) {
            onDichotomousAnswerSelected(answers[value!], value ?? 0);
          },
          activeColor: Color(0xFFBB2649),
        );
      }),
    );
  }
}


