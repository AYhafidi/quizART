import 'package:flutter/material.dart';
import 'package:quizart/components/BottomPageWidget.dart';
import 'package:quizart/components/QuestionAnswersWidgetComment.dart';
import 'package:quizart/components/QuestionAnswersWidgetDichotomous.dart';
import 'package:quizart/components/QuestionAnswersWidgetMCQ.dart';
import 'package:quizart/components/QuestionAnswersWidgetRanking.dart';
import 'package:quizart/components/QuestionAnswersWidgetScales.dart';
import 'package:quizart/components/QuestionWidget.dart';
import 'package:quizart/screens/laoding.dart';
import 'package:quizart/services/database.dart';
//import 'package:quizart/components/QuestionAnswersWidgetSmileys.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List questions = []; // questions that we got from the database
  Map responses = {};    // list of client responses
  bool isLoaded = false;   // true if we got the questions without problems
  String topic = "";
  late String docId ;     // Id of the doc that will contain the clients responses
  int currentQuestionIndex = 0; // Index of the current question

  @override
  initState()  {         // this is called when the class is initialized or called for the first time
    super.initState(); //  this is the material super constructor for init state to link your instance initState to the global initState context
    //getData("Video games");
  }

  void getData(String topic) async {
    DataBaseService db = DataBaseService();
    questions = await db.getData(topic);
    setState(() {
      isLoaded = !(questions == []);
      docId = db.newDocumentID();
      }
    );
    prepareResponses();
  }


  void goToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
      if (responses[currentQuestionIndex] == null){
        prepareResponses();
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

  void onAnswerSelected(String answer, dynamic value){
    setState(() {
      responses[currentQuestionIndex][answer] = value;
    });
  }

  void onDichotomousAnswerSelected(String answer, int value){

    setState(() {
      responses[currentQuestionIndex] = {answer : value};
    });
  }

  void onOrderValueSelected(List answers){
    setState(() {
      responses[currentQuestionIndex] = answers.asMap();
    });
  }

  Widget getWidget(String type){
    switch(type){
      case "dichotomous":
        return QuestionAnswersWidgetDichotomous(answers: questions[currentQuestionIndex]["answers"] ?? ["Doesn't work $currentQuestionIndex"], selectedAnswerIndex: responses[currentQuestionIndex].values.toList()[0].toInt() ?? [0], onDichotomousAnswerSelected: onDichotomousAnswerSelected);
      case "qcm":
        return QuestionAnswersWidgetMCQ(answers: questions[currentQuestionIndex]["answers"] ?? ["Doesn't work $currentQuestionIndex"], SelectedAnswers: responses[currentQuestionIndex] ?? {"Doesn't work $currentQuestionIndex", true}, onMCQAnswerSelected: onAnswerSelected);
      case "scale":
        return QuestionAnswersWidgetScales(Scale: questions[currentQuestionIndex]["scale"] ?? ["Doesn't work $currentQuestionIndex"], answers: questions[currentQuestionIndex]["answers"], SelectedAnswers: responses[currentQuestionIndex], onScaleValueSelected: onAnswerSelected);
      case "rank":
        return QuestionAnswersWidgetRanking(selectedOrderValues: responses[currentQuestionIndex].values.toList(), onOrderValueSelected: onOrderValueSelected);
      case "comment":
        return QuestionAnswersWidgetComment(comment: responses[currentQuestionIndex]["comment"], onCommentSubmitted: onAnswerSelected);
      /*case "satisfaction":
        return QuestionAnswersWidgetSmileys(smileys: responses[currentQuestionIndex]["answers"], onSmileySelected: onSmileySelected);*/
      default :
        return Text("Nothing found !!");
    }

  }

  void prepareResponses(){
    responses[currentQuestionIndex] = {};
    switch(questions[currentQuestionIndex]["type"]){
      case "dichotomous":
        responses[currentQuestionIndex][questions[currentQuestionIndex]["answers"][0]] = 0;
      case "qcm":
        questions[currentQuestionIndex]["answers"].forEach((element) => responses[currentQuestionIndex][element]=false);
      case "scale":
        questions[currentQuestionIndex]["answers"].forEach((element) => responses[currentQuestionIndex][element]= questions[currentQuestionIndex]["scale"][0]);
      case "rank":
        responses[currentQuestionIndex] = questions[currentQuestionIndex]["answers"].asMap();
      case "comment":
        responses[currentQuestionIndex] = {"comment":""};
    }
  }


  @override
  Widget build(BuildContext context) {
    if (topic == "" ){
      dynamic choosedTopic = ModalRoute.of(context)!.settings.arguments;
      topic = choosedTopic!["ChoosedTopic"];
      getData(topic);
    }


    // Retrieve arguments
    return !isLoaded ?Loading() : Scaffold(
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              QuestionWidget(text: questions[currentQuestionIndex]["text"]),
              getWidget(questions[currentQuestionIndex]["type"]),
              BottomPageWidget(goToPreviousQuestion: goToPreviousQuestion, goToNextQuestion: goToNextQuestion)
            ]
        ),
      ),
    );
  }
}

