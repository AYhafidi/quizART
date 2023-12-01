import 'package:flutter/material.dart';

class QuestionAnswersWidgetDichotomous extends StatelessWidget {
  final List answers;
  final String selectedAnswer;
  final Function(String) onDichotomousAnswerSelected;

  const QuestionAnswersWidgetDichotomous({
    Key? key,
    required this.answers,
    required this.selectedAnswer,
    required this.onDichotomousAnswerSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
      ),
      child: Column(
        children: List.generate(answers.length, (index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(
                color: index == answers.indexOf(selectedAnswer)
                    ? const Color(0xFFBB2649) // Pink color when selected
                    : Colors.transparent,
                width: 2.0, // Adjust the border width as needed
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3),
                ),

              ],
            ),
            child: RadioListTile<int>(
              title: Text(
                answers[index],
                style: const TextStyle(fontSize: 18.0),
              ),
              value: index,
              groupValue: answers.indexOf(selectedAnswer),
              onChanged: (value) {
                onDichotomousAnswerSelected(answers[value!]);
              },
              activeColor: const Color(0xFFBB2649),
            ),
          );
        }),
      ),
    );
  }
}
