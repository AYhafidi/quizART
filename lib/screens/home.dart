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

  Map questions = {
    "1": {
      "is_linked": false,
      "text": "Do you play or develop video games?",
      "answers": ["Playing", "Development"],
      "type": "dichotomous",
      "nextIndex": "2"
      },
    "2": {
      "is_linked": false,
      "text": "Rank these games per order of preference?",
      "answers": ["Action", "RPG", "Shooter", "MOBA", "Battle Royale", "Strategy", "Simulation", "Sports"],
      "type": "rank",
      "nextIndex": "3"
    },
    "3": {
      "is_linked": false,
      "text": "what the name of the competition",
      "type": "comment",
      "nextIndex": "4"
    },
    "4": {
      "text": "for how long have you been playing",
      "is_linked": false,
      "type": "scale",
      "answers": ["years"],
      "scale": [1, 20],
      "nextIndex": "5"
    },
    "5": {
      "is_linked": false,
      "text": "Do you prefer competitive or cooperative multiplayer games?",
      "type": "qcm",
      "answers": ["Competitive", "Cooperative", "Micheal jordan", "Yasmine Hamddaoui",  "Other"],
      "nextIndex": "5"
    },

  }; // questions that we got from the database
  Map<String, dynamic> answers = {};    // list of client answers
  bool isLoaded = true;   // true if we got the questions without problems
  String topic = "";
  String uid = "";
  String currentQuestionIndex = "1"; // Index of the current question
  DataBaseService db = DataBaseService();
  late dynamic data;

  @override
  initState()  {         // this is called when the class is initialized or called for the first time
    super.initState(); //  this is the material super constructor for init state to link your instance initState to the global initState context
    //getData(topic);
    //getData("Video games");
    prepareResponses();
  }

  void getData(String topic) async {
    questions = await db.getData(topic);
    setState(() {
      isLoaded = questions.isNotEmpty;
      }
    );
    prepareResponses();
  }

  Map listToMap(List array){
    Map map = Map.fromEntries(
      array.asMap().entries.map((entry) => MapEntry(entry.key.toString(), entry.value)),
    );

    return map;
  }



  void goToNextQuestion() {
    String index = questions[currentQuestionIndex]["is_linked"] ? questions[currentQuestionIndex]["nextIndex"][answers[currentQuestionIndex]] : questions[currentQuestionIndex]["nextIndex"];
    if (index == "-1") {
      db.addUserResponse(uid, "Video games", answers);
      Navigator.pushReplacementNamed(context, "/quiz"); // navigate to the page of choosing topics
    }else{
      questions[index]["prevIndex"] = currentQuestionIndex ;
      setState(() {
        currentQuestionIndex = index;
      });
      if (answers[currentQuestionIndex] == null){
        prepareResponses();
      }
    }
  }


  void goToPreviousQuestion() {
    setState(() {
      currentQuestionIndex = questions[currentQuestionIndex]["prevIndex"] == -1 ? currentQuestionIndex : questions[currentQuestionIndex]["prevIndex"];
    });

  }

  void onAnswerSelected(String answer, dynamic value){
    setState(() {
      answers[currentQuestionIndex]![answer] = value;
    });
  }

  void onDichotomousCommentAnswerSelected(String answer){
    setState(() {
      answers[currentQuestionIndex] = answer;
    });
  }

  void onOrderValueSelected(List qAnswers){

    setState(() {
      answers[currentQuestionIndex] = listToMap(qAnswers) ;
    });
  }

  Widget getWidget(String type){
    switch(type){
      case "dichotomous":
        return QuestionAnswersWidgetDichotomous(answers: questions[currentQuestionIndex]["answers"] , selectedAnswer: answers[currentQuestionIndex] , onDichotomousAnswerSelected: onDichotomousCommentAnswerSelected);
      case "qcm":
        return QuestionAnswersWidgetMCQ(answers: questions[currentQuestionIndex]["answers"] ?? ["Doesn't work $currentQuestionIndex"], SelectedAnswers: answers[currentQuestionIndex]!, onMCQAnswerSelected: onAnswerSelected);
      case "scale":
        return QuestionAnswersWidgetScales(Scale: questions[currentQuestionIndex]["scale"] ?? ["Doesn't work $currentQuestionIndex"], answers: questions[currentQuestionIndex]["answers"], SelectedAnswers: answers[currentQuestionIndex]!, onScaleValueSelected: onAnswerSelected);
      case "rank":
        return QuestionAnswersWidgetRanking(selectedOrderValues: answers[currentQuestionIndex]!.values.toList(), onOrderValueSelected: onOrderValueSelected);
      case "comment":
        return QuestionAnswersWidgetComment(comment: answers[currentQuestionIndex], onCommentSubmitted: onDichotomousCommentAnswerSelected);
      case "image":
        return QuestionAnswersWidgetImage(answers: questions[currentQuestionIndex]["answers"], selectedAnswers: answers[currentQuestionIndex]!, onImageAnswerSelected: onAnswerSelected);
      default :
        return const Text("Nothing found !!");
    }

  }

  void prepareResponses(){
    answers[currentQuestionIndex] = {};
    switch(questions[currentQuestionIndex]["type"]){
      case "dichotomous":
        answers[currentQuestionIndex] = questions[currentQuestionIndex]["answers"][0];
      case "qcm":
      case "image":
        questions[currentQuestionIndex]["answers"].forEach((element) => answers[currentQuestionIndex]![element]=false);
      case "scale":
        questions[currentQuestionIndex]["answers"].forEach((element) => answers[currentQuestionIndex]![element]= questions[currentQuestionIndex]["scale"][0]);
      case "rank":
        //answers[currentQuestionIndex] = questions[currentQuestionIndex]["answers"].asMap();
        questions[currentQuestionIndex]["answers"].asMap().forEach((index, element) => answers[currentQuestionIndex]![index.toString()] = element );
        //print(answers[currentQuestionIndex]);
      case "comment":
        answers[currentQuestionIndex] = "";
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
    return !isLoaded ?const Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        centerTitle: true,
        title: const Text("Helllllllllllllllo"),
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

