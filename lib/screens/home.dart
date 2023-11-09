import 'package:flutter/material.dart';
import 'package:quizart/components/BottomPageWidget.dart';
import 'package:quizart/components/QuestionAnswersWidgetMCQ.dart';
import 'package:quizart/components/QuestionAnswersWidgetRanking.dart';
import 'package:quizart/components/QuestionAnswersWidgetScales.dart';
import 'package:quizart/components/QuestionWidget.dart';
import 'package:quizart/screens/laoding.dart';
import 'package:quizart/services/database.dart';




class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List Questions = [{
    "text" : "Ça va?",
    "type" : "scale",
    "answers" : ["Oui", "Non", "Peut-être"],
    "scale" : [1, 8],
  },{
    "text" : "Ça va?",
    "type" : "scale",
    "answers" : ["Hola", "Non", "COCO"],
    "scale" : [1, 10],
  }
  ];  // Questions that we got from the database
  Map Responses = {};    // list of client responses
  bool isLoaded = true;   // true if we got the questions without problems
  late String docId ;     // Id of the doc that will contain the clients responses
  int currentQuestionIndex = 0; // Index of the current question

  @override
  initState()  {         // this is called when the class is initialized or called for the first time
    super.initState();  //  this is the material super constructor for init state to link your instance initState to the global initState context
    //getData();
    PrepareResponses();
  }

  void getData() async {
    DataBaseService db =DataBaseService();
    Questions = await db.getData();
    setState(() {
      isLoaded = !(Questions == []);
      docId = db.newDocumentID();
      }
    );
  }


  void goToNextQuestion() {
    if (currentQuestionIndex < Questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
      if (Responses[currentQuestionIndex] == null){
        PrepareResponses();
      }
    }
  }
  void goToPreviousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  void onMCQAnswerSelected(String answer, dynamic value){
    setState(() {
      Responses[currentQuestionIndex][answer] = value;
    });
  }

  void PrepareResponses(){
    Responses[currentQuestionIndex] = {};
    switch(Questions[currentQuestionIndex]["type"]){
      case "dechotomie":
        Questions[currentQuestionIndex]["answers"].forEach((element) => Responses[currentQuestionIndex][element]=false);
      case "scale":
        Questions[currentQuestionIndex]["answers"].forEach((element) => Responses[currentQuestionIndex][element]= Questions[currentQuestionIndex]["scale"][0]);
    }
  }


  @override
  Widget build(BuildContext context) {
    // Retrieve arguments
    return !isLoaded ?Loading() : Scaffold(
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              QuestionWidget(text: Questions[currentQuestionIndex]["text"]),
              //QuestionAnswersWidgetMCQ(question: Questions[currentQuestionIndex], SelectedAnswersMCQ: Responses[currentQuestionIndex], onMCQAnswerSelected: onMCQAnswerSelected),
              QuestionAnswersWidgetScales(question: Questions[currentQuestionIndex], selectedScaleValues: Responses[currentQuestionIndex], onScaleValueSelected: onMCQAnswerSelected),
              //QuestionAnswersWidgetRanking(question: Questions[currentQuestionIndex]),
              BottomPageWidget(goToPreviousQuestion: goToPreviousQuestion, goToNextQuestion: goToNextQuestion)
            ]
        ),
      ),
    );
  }
}

