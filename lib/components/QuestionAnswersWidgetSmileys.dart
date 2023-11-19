import 'package:flutter/material.dart';

class QuestionAnswersWidgetSmileys extends StatelessWidget {
  final List<String> smileys;
  final int selectedSmileyIndex;
  final Function(int) onSmileySelected;

  QuestionAnswersWidgetSmileys({
    required this.smileys,
    required this.selectedSmileyIndex,
    required this.onSmileySelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(smileys.length, (index) {
        return GestureDetector(
          onTap: () {
            onSmileySelected(index);
          },
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: selectedSmileyIndex == index
                  ? Colors.blueAccent
                  : Colors.grey,
            ),
            child: Text(
              smileys[index],
              style: TextStyle(fontSize: 30),
            ),
          ),
        );
      }),
    );
  }
}
