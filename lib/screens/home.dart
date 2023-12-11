import 'package:flutter/material.dart';
import 'package:quizart/components/QuestionAnswersWidgetComment.dart';
import 'package:quizart/components/QuestionAnswersWidgetDichotomous.dart';
import 'package:quizart/components/QuestionAnswersWidgetImage.dart';
import 'package:quizart/components/QuestionAnswersWidgetMCQ.dart';
import 'package:quizart/components/QuestionAnswersWidgetRanking.dart';
import 'package:quizart/components/QuestionAnswersWidgetScales.dart';
import 'package:quizart/components/QuestionWidget.dart';
import 'package:quizart/screens/QuizChoose.dart';
import 'package:quizart/screens/laoding.dart';
import 'package:quizart/services/database.dart';




class Home extends StatefulWidget {
  final String topic;
  final String uid;
  const Home({super.key, required this.topic, required this.uid});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map questions = {}; // questions that we got from the database
  Map<String, dynamic> answers = {};
  bool isLoaded = false;   // true if we got the questions without problems
  String currentQuestionIndex = "1"; // Index of the current question
  DataBaseService db = DataBaseService();

  @override
  initState()  {         // this is called when the class is initialized or called for the first time
    super.initState(); //  this is the material super constructor for init state to link your instance initState to the global initState context
    getData(widget.topic);
    //prepareResponses();
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
      db.addUserResponse(widget.uid, widget.topic, answers);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuizChoose(uid: widget.uid),
        ),
      );
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
    // Retrieve arguments
    return !isLoaded ?const Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF032174),
        centerTitle: true,
        title: const Text("PollART", style: TextStyle(fontSize: 18.0, fontFamily: 'Lexend',color: Colors.white)),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 25),
            const Center(
              child: Icon(
                Icons.poll,
                size: 65.0,
                color: Colors.blueAccent, // Set the color to magenta
              ),
            ),

            QuestionWidget(text: questions[currentQuestionIndex]["text"]),
            getWidget(questions[currentQuestionIndex]["type"]),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin:
              EdgeInsets.only(bottom: 5.0), // Adjust the value as needed
              child: ClipOval(
                child: Material(
                  color: Color(0xFF032174),
                  child: InkWell(
                    splashColor: Colors.blueAccent,
                    onTap: goToPreviousQuestion,
                    child: const SizedBox(
                      width: 50,
                      height: 50,
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 22.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 60),
            Container(
              margin:
              EdgeInsets.only(bottom: 5.0), // Adjust the value as needed
              child: ClipOval(
                child: Material(
                  color: Color(0xFF032174),
                  child: InkWell(
                    splashColor: Colors.blueAccent,
                    onTap: goToNextQuestion,
                    child: const SizedBox(
                      width: 50,
                      height: 50,
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 22.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );



  }
}

