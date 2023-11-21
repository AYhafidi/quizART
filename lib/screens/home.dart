import 'package:flutter/material.dart';
import 'package:quizart/components/BottomPageWidget.dart';
import 'package:quizart/components/QuestionAnswersWidgetComment.dart';
import 'package:quizart/components/QuestionAnswersWidgetDichotomous.dart';
import 'package:quizart/components/QuestionAnswersWidgetImage.dart';
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

  List questions = []; // questions that we got from the database
  Map<String, Map<String, dynamic>> responses = {};    // list of client responses
  bool isLoaded = false;   // true if we got the questions without problems
  String topic = "";
  String uid = "";
  int currentQuestionIndex = 0; // Index of the current question
  DataBaseService db = DataBaseService();
  late dynamic data;

  @override
  initState()  {         // this is called when the class is initialized or called for the first time
    super.initState(); //  this is the material super constructor for init state to link your instance initState to the global initState context
    //getData(topic);
    getData("Video games");
    //prepareResponses();
  }

  void getData(String topic) async {
    questions = await db.getData(topic);
    setState(() {
      isLoaded = !(questions == []);
      }
    );
    prepareResponses();
  }


  void goToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
      if (responses[currentQuestionIndex.toString()] == null){
        prepareResponses();
      }
    }else if(currentQuestionIndex == questions.length - 1 ){
      db.addUserResponse(uid, topic, responses);
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
      responses[currentQuestionIndex.toString()]![answer] = value;
    });
  }

  void onDichotomousAnswerSelected(String answer, int value){
    setState(() {
      responses[currentQuestionIndex.toString()] = {answer : value};
    });
  }

  void onOrderValueSelected(List answers){
    setState(() {
      responses[currentQuestionIndex.toString()] = Map<String, dynamic>.from(answers.asMap()) ;
    });
  }

  Widget getWidget(String type){
    switch(type){
      case "dichotomous":
        return QuestionAnswersWidgetDichotomous(answers: questions[currentQuestionIndex]["answers"] ?? ["Doesn't work $currentQuestionIndex"], selectedAnswerIndex: responses[currentQuestionIndex.toString()]!.values.toList()[0].toInt() ?? [0], onDichotomousAnswerSelected: onDichotomousAnswerSelected);
      case "qcm":
        return QuestionAnswersWidgetMCQ(answers: questions[currentQuestionIndex]["answers"] ?? ["Doesn't work $currentQuestionIndex"], SelectedAnswers: responses[currentQuestionIndex.toString()]!, onMCQAnswerSelected: onAnswerSelected);
      case "scale":
        return QuestionAnswersWidgetScales(Scale: questions[currentQuestionIndex]["scale"] ?? ["Doesn't work $currentQuestionIndex"], answers: questions[currentQuestionIndex]["answers"], SelectedAnswers: responses[currentQuestionIndex.toString()]!, onScaleValueSelected: onAnswerSelected);
      case "rank":
        return QuestionAnswersWidgetRanking(selectedOrderValues: responses[currentQuestionIndex.toString()]!.values.toList(), onOrderValueSelected: onOrderValueSelected);
      case "comment":
        return QuestionAnswersWidgetComment(comment: responses[currentQuestionIndex.toString()]!["comment"], onCommentSubmitted: onAnswerSelected);
      case "image":
        return QuestionAnswersWidgetImage(answers: questions[currentQuestionIndex]["answers"], selectedAnswers: responses[currentQuestionIndex.toString()]!, onImageAnswerSelected: onAnswerSelected);
      default :
        return Text("Nothing found !!");
    }

  }

  void prepareResponses(){
    responses[currentQuestionIndex.toString()] = {};
    switch(questions[currentQuestionIndex]["type"]){
      case "dichotomous":
        responses[currentQuestionIndex.toString()]![questions[currentQuestionIndex]["answers"][0]] = 0;
      case "qcm":
      case "image":
        questions[currentQuestionIndex]["answers"].forEach((element) => responses[currentQuestionIndex.toString()]![element]=false);
      case "scale":
        questions[currentQuestionIndex]["answers"].forEach((element) => responses[currentQuestionIndex.toString()]![element]= questions[currentQuestionIndex]["scale"][0]);
      case "rank":
        //responses[currentQuestionIndex.toString()] = questions[currentQuestionIndex]["answers"].asMap();
        questions[currentQuestionIndex]["answers"].asMap().forEach((index, element) => responses[currentQuestionIndex.toString()]![index.toString()] = element );
        //print(responses[currentQuestionIndex.toString()]);
      case "comment":
        responses[currentQuestionIndex.toString()] = {"comment":""};
    }
  }


  @override
  Widget build(BuildContext context) {
    if (topic == "" &&  !(ModalRoute.of(context)!.settings.arguments==null)){
      data = ModalRoute.of(context)!.settings.arguments;
      topic = data!["ChoosedTopic"];
      uid = data!["uid"];
      getData("Video games");
    }


    // Retrieve arguments
    return !isLoaded ?Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        centerTitle: true,
        title: Text("Helllllllllllllllo"),
      ),
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

