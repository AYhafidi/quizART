import 'package:flutter/material.dart';
import 'package:quizart/components/CardWidget.dart';

class QuestionAnswersWidgetImage extends StatelessWidget {
  final List answers;
  final Map selectedAnswers;
  final Function(String, dynamic) onImageAnswerSelected;

  // Use the key parameter directly in the constructor
  const QuestionAnswersWidgetImage({
    Key? key,
    required this.answers,
    required this.selectedAnswers,
    required this.onImageAnswerSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
          child :SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children : List.generate(answers.length, (index) {
                return GestureDetector(
                  onTap: () {
                    onImageAnswerSelected(
                        answers[index], !selectedAnswers[answers[index]]);
                  },
                  child: CardWidget(
                    answer: answers[index],
                    size: 300,
                    fontSize: 20,
                    fontFamily: "lato",
                    borderRadius: 15,
                    choosed: selectedAnswers[answers[index]],
                  ),
                );
              }),
              ),
            ),
      );
    }
  }
