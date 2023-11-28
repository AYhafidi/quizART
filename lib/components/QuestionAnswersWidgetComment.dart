import 'dart:async';
import 'package:flutter/material.dart';

class QuestionAnswersWidgetComment extends StatelessWidget {
  final String comment;
  final Function(String) onCommentSubmitted;

  QuestionAnswersWidgetComment({super.key,
    required this.comment,
    required this.onCommentSubmitted});

  final TextEditingController _controller = TextEditingController();
  Timer _timer = Timer(const Duration(milliseconds: 0), (){});


  void ReboundUpdateComment(String text){
    if (_timer.isActive) {
      _timer.cancel();
    }
    _timer = Timer(const Duration(milliseconds: 500), (){
      onCommentSubmitted(text);
    });


  }

  @override
  Widget build(BuildContext context) {

    _controller.value = TextEditingValue(
      text: comment,
      selection: TextSelection.fromPosition(
        TextPosition(offset: comment.length),
      ),
    );
    return Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
          TextField(
            onChanged: (value){
              ReboundUpdateComment(value);
              },
            controller: _controller,
            maxLines: 4,
            decoration: const InputDecoration(
            labelText: 'Your Comment',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16.0),
    ],
    ),
    );
  }
}