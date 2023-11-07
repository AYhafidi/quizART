import 'package:flutter/material.dart';
import 'package:quizart/components/Questions.dart';

class QuestionAnswersWidgetMCQ extends StatelessWidget {
  final Map question;
  final List<bool> selectedAnswersMCQ;
  final Function(int) onMCQAnswerSelected;

  QuestionAnswersWidgetMCQ({
    required this.question,
    required this.selectedAnswersMCQ,
    required this.onMCQAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: List.generate(question["answers"].length, (index) {
          return Row(
            children: [
              Checkbox(
                value: selectedAnswersMCQ?[index] ?? false,
                onChanged: (value) {
                  onMCQAnswerSelected(index);
                },
                activeColor: Color(0xFFBB2649),
              ),
              Text(
                question["answers"][index],
                style: TextStyle(fontSize: 18.0), // Increase font size
              ),
            ],
          );
        }),
      ),
    );
  }
}
