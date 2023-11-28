import 'package:flutter/material.dart';

class QuestionAnswersWidgetScales extends StatelessWidget {
  final List<dynamic> answers;
  final List<dynamic> Scale;
  final Map SelectedAnswers;
  final Function(String, dynamic) onScaleValueSelected;

  const QuestionAnswersWidgetScales({super.key, 
    required this.Scale,
    required this.answers,
    required this.SelectedAnswers,
    required this.onScaleValueSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(answers.length, (index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                answers[index],
                style: const TextStyle(fontSize: 18.0), // Increase font size
              ),
              Slider(
                value: SelectedAnswers[answers[index]]?.toDouble() ?? Scale[0].toDouble()!,
                min: Scale[0].toDouble()!,
                max: Scale[1].toDouble()!,
                divisions: Scale[1]!,
                onChanged: (value) {
                  onScaleValueSelected(answers[index], value.toInt());
                },
                activeColor: const Color(0xFFBB2649),
              ),
              const SizedBox(
                width:10,
              ),
              Container(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.blue,  // specify the color you want
                      width: 2.0,  // specify the width you want
                      style: BorderStyle.solid,  // specify the style you want
                    ),
                  ),
                ),
                child: Text(
                    SelectedAnswers[answers[index]]!.toString(),
                    style: const TextStyle(
                      fontFamily: "lato",
                      color: Colors.cyan,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
