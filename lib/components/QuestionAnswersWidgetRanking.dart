import 'package:flutter/material.dart';

class QuestionAnswersWidgetRanking extends StatelessWidget {
  final List selectedOrderValues;
  final Function(List) onOrderValueSelected;

  const QuestionAnswersWidgetRanking({
    super.key,
    required this.selectedOrderValues,
    required this.onOrderValueSelected,
  });

  void onReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final option = selectedOrderValues.removeAt(oldIndex);
    selectedOrderValues.insert(newIndex, option);
    onOrderValueSelected(selectedOrderValues);
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.07),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: ReorderableListView(
              onReorder: onReorder,
              children: List.generate(selectedOrderValues.length, (index) {
                final option = selectedOrderValues[index];
                return SizedBox(
                  key: Key(option),
                  height: 75.0,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.48),
                          spreadRadius: 3,
                          blurRadius: 13,
                          offset: Offset(2, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      title: Text(
                        option,
                        style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Lexend',
                          color: Colors.grey[950],
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        // Additional widgets in the Column can be added here
      ],
    );
  }
}




