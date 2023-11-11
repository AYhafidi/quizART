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
    final option = this.selectedOrderValues.removeAt(oldIndex);
    this.selectedOrderValues.insert(newIndex, option);
    onOrderValueSelected(selectedOrderValues);
  }

  @override
  Widget build(BuildContext context) {

    return  Container(
      height: 300, // Set a specific height
      child: ReorderableListView(
        children: List.generate(this.selectedOrderValues.length, (index) {
          final option = this.selectedOrderValues[index];
          return ListTile(
            key: Key(option),
            title: Text(option),
            leading: Icon(Icons.drag_handle),
          );
        }),
        onReorder: onReorder,
      ),
    );
  }
}



