import 'package:flutter/material.dart';
import 'package:quizart/screens/laoding.dart';
import 'package:quizart/services/database.dart';




class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List Questions = [];  // Questions that we go fromthe database
  Map Response = {};    // list of client responses
  bool isLoaded = false;   // true if we got the questions without problems
  late String docId ;     // Id of the doc that will contain the clients responses

  @override
  initState()  {         // this is called when the class is initialized or called for the first time
    super.initState();  //  this is the material super constructor for init state to link your instance initState to the global initState context
    getData();
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


  void AddResponse(String response, int Value){
    setState(() {
      Response[response] = Value;
    });
  }
  @override
  Widget build(BuildContext context) {
    // Retrieve arguments

    return !isLoaded ?Loading() : Scaffold(
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            ]
        ),
      ),
    );
  }
}
