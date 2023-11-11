import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:quizart/services/database.dart';



class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {



  @override


  Future<void> loadData() async {
    DataBaseService().addQuestions('data.json');
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    //loadData();

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      child: Center(
        child: SpinKitWave(
          color: Colors.blueAccent,
          size: 50.0,
        ),
      ),
    );
  }
}
