import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizart/services/toast.dart';

class QuizChoose extends StatefulWidget {
  const QuizChoose({Key? key}) : super(key: key);

  @override
  State<QuizChoose> createState() => _QuizChooseState();
}

class _QuizChooseState extends State<QuizChoose> {
  List<String> Topics = ["Video games", "Sport", "Art", "Cinema"];
  late String ChoosedTopic;

  @override
  void initState() {
    super.initState();
    ChoosedTopic = Topics[0];
  }

  @override
  Widget build(BuildContext context) {
    dynamic arguments = ModalRoute.of(context)!.settings.arguments;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        color: Color(0xffCCCCFF),
        child: Column(
          children: [
            Container(
              width: width,
              height: 0.9*height,
              padding: EdgeInsets.fromLTRB(0, width * 0.08, 0, 0),
              child: GridView.count(
                primary: false,
                padding: EdgeInsets.fromLTRB(width * 0.08, 0, width * 0.08, 0),
                crossAxisSpacing: width * 0.08,
                mainAxisSpacing: width * 0.08,
                crossAxisCount: 2,
                children: [...List.generate(Topics.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        ChoosedTopic = Topics[index];
                      });
                    },
                    child: Container(
                      width: width * 0.6,
                      height: width * 0.6,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xffEE9CA7),
                            Color(0xffFFDDE1),
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: ChoosedTopic == Topics[index]
                                  ?Colors.black.withOpacity(0.4)
                                  :Colors.black.withOpacity(0.2),
                            offset: Offset(0, 4),
                            blurRadius: ChoosedTopic == Topics[index]
                                ?4
                                :5,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          Topics[index],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "lato",
                            fontWeight: ChoosedTopic == Topics[index]
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 30,
                          ),
                        ),
                      ),
                    ),
                  );
                })],
              ),
            )
          , FloatingActionButton.extended(
              label: Text("Let's go to ${ChoosedTopic} Quiz"), // <-- Text
              backgroundColor: Colors.black,
              icon: Icon( // <-- Icon
                Icons.start,
                size: 24.0,
              ),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/home",  arguments: {
                  'ChoosedTopic': ChoosedTopic,
                  ...arguments,
                },);
              },
            ),],
        ),
      ),
    );
  }
}

