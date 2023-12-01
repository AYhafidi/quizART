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
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05
      ),
      child: Column(
        children: List.generate(answers.length, (index) {
          bool isSelected = SelectedAnswers[answers[index]] == true;

          return GestureDetector(
            onTap: () {
              onMCQAnswerSelected(answers[index] ,!isSelected);
            },
            child: Container(
              margin: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: isSelected ? const Color(0xFFBB2649) : Colors.white,
                borderRadius: BorderRadius.circular(13.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.48),
                    spreadRadius: 3,
                    blurRadius: 13,
                    offset: const Offset(2, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 18.0, horizontal: 16.0),
                child: Row(
                  children: [
                    Text(
                      answers[index],
                      style: TextStyle(
                        fontSize: 20.0,
                        fontFamily: 'Lexend',
                        color: isSelected ? Colors.white : Colors.grey[800],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
