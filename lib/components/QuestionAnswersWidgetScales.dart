import 'package:flutter/material.dart';

class QuestionAnswersWidgetScales extends StatelessWidget {
  final List<dynamic> answers;
  final List<dynamic> Scale;
  final Map SelectedAnswers;
  final Function(String, dynamic) onScaleValueSelected;

  QuestionAnswersWidgetScales({
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
                style: TextStyle(fontSize: 18.0), // Increase font size
              ),
              Slider(
                value: SelectedAnswers[this.answers[index]]?.toDouble() ?? this.Scale[0].toDouble()!,
                min: this.Scale[0].toDouble()!,
                max: this.Scale[1].toDouble()!,
                divisions: this.Scale[1]!,
                onChanged: (value) {
                  onScaleValueSelected(this.answers[index], value.toInt());
                },
                activeColor: Color(0xFFBB2649),
              ),
              SizedBox(
                width:10,
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.blue,  // specify the color you want
                      width: 2.0,  // specify the width you want
                      style: BorderStyle.solid,  // specify the style you want
                    ),
                  ),
                ),
                child: Text(
                    SelectedAnswers[this.answers[index]]!.toString(),
                    style: TextStyle(
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
