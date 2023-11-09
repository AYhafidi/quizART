import 'package:flutter/material.dart';

class QuestionAnswersWidgetScales extends StatelessWidget {
  final Map question;
  final Map selectedScaleValues;
  final Function(String, dynamic) onScaleValueSelected;

  QuestionAnswersWidgetScales({
    required this.question,
    required this.selectedScaleValues,
    required this.onScaleValueSelected,
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Column(
        children: List.generate(question["answers"].length, (index) {
          return Row(
            children: [
              Text(
                question["answers"][index],
                style: TextStyle(fontSize: 18.0), // Increase font size
              ),
              Slider(
                value: selectedScaleValues[this.question["answers"][index]]?.toDouble() ?? this.question["scale"][0]!,
                min: this.question["scale"][0]!,
                max: this.question["scale"][1]!,
                divisions: this.question["scale"][1]!,
                onChanged: (value) {
                  onScaleValueSelected(this.question["answers"][index], value.toInt());
                },
                activeColor: Color(0xFFBB2649),
              ),
            ],
          );
        }),
      ),
    );
  }
}
