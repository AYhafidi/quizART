import 'package:flutter/material.dart';


class QuestionAnswersWidgetMCQ extends StatelessWidget {

  final Map question;
  final Map SelectedAnswersMCQ;
  final Function(String, dynamic) onMCQAnswerSelected;

  const QuestionAnswersWidgetMCQ({
        super.key,
        required this.question,
        required this.SelectedAnswersMCQ,
        required this.onMCQAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: List.generate(this.question["answers"].length, (index) {
          return Row(
            children: [
              Checkbox(
                value: this.SelectedAnswersMCQ[this.question["answers"][index]],
                onChanged: (value) {
                  onMCQAnswerSelected(this.question["answers"][index], value!);
                },
                activeColor: Color(0xFFBB2649),
              ),
              Text(
                this.question["answers"][index],
                style: TextStyle(fontSize: 18.0), // Increase font size
              ),
            ],
          );
        }),
      ),
    );
  }
}
