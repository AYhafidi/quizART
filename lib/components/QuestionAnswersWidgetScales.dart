import 'package:flutter/material.dart';

class QuestionAnswersWidgetScales extends StatelessWidget {
  final Map question;
  final List<int>? selectedScaleValues;
  final Function(int, int) onScaleValueSelected;

  QuestionAnswersWidgetScales({
    required this.question,
    this.selectedScaleValues,
    required this.onScaleValueSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: List.generate(question["responses"].length, (index) {
          return Row(
            children: [
              Text(
                question["responses"][index],
                style: TextStyle(fontSize: 18.0), // Increase font size
              ),
              Slider(
                value: selectedScaleValues?[index]?.toDouble() ?? 1.0,
                min: 1.0,
                max: 5.0,
                divisions: 4,
                onChanged: (value) {
                  onScaleValueSelected(index, value.toInt());
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
