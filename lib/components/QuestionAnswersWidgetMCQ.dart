import 'package:flutter/material.dart';


class QuestionAnswersWidgetMCQ extends StatelessWidget {

  final List answers;
  final Map SelectedAnswers;
  final Function(String, dynamic) onMCQAnswerSelected;

  const QuestionAnswersWidgetMCQ({
        super.key,
        required this.answers,
        required this.SelectedAnswers,
        required this.onMCQAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: List.generate(answers.length, (index) {
          return Row(
            children: [
              Checkbox(
                value: SelectedAnswers[answers[index]],
                onChanged: (value) {
                  onMCQAnswerSelected(answers[index], value!);
                },
                activeColor: const Color(0xFFBB2649),
              ),
              Text(
                answers[index],
                style: const TextStyle(fontSize: 18.0), // Increase font size
              ),
            ],
          );
        }),
      ),
    );
  }
}
