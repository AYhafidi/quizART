import 'dart:async';

import 'package:async/async.dart';
import 'package:flutter/material.dart';

class QuestionAnswersWidgetComment extends StatelessWidget {
  final String comment;
  final Function(String, dynamic) onCommentSubmitted;

  QuestionAnswersWidgetComment({super.key,
    required this.comment,
    required this.onCommentSubmitted});

  TextEditingController _controller = TextEditingController();
  Timer _timer = Timer(const Duration(milliseconds: 0), (){});


  void ReboundUpdateComment(String text){
    if (_timer.isActive) {
      _timer.cancel();
    }
      _timer = Timer(const Duration(milliseconds: 500), (){
        onCommentSubmitted("comment", text);
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
          TextField(
            onChanged: (value){
              ReboundUpdateComment(value);
              },
            controller: _controller,
            maxLines: 4,
            decoration: InputDecoration(
            labelText: 'Your Comment',
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 16.0),
    ],
    ),
    );
  }
}