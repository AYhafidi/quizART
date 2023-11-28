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

    return  SizedBox(
      height: 300, // Set a specific height
      child: ReorderableListView(
        onReorder: onReorder,
        children: List.generate(selectedOrderValues.length, (index) {
          final option = selectedOrderValues[index];
          return ListTile(
            key: Key(option),
            title: Text(option),
            leading: const Icon(Icons.drag_handle),
          );
        }),
      ),
    );
  }
}



