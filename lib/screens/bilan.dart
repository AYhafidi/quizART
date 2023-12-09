import 'package:flutter/material.dart';
import 'package:quizart/screens/QuizChoose.dart';
import 'package:quizart/services/database.dart';

class BilanPage extends StatefulWidget {
  final String topic;
  final String uid;

  const BilanPage({Key? key, required this.topic, required this.uid}) : super(key: key);

  @override
  _BilanPageState createState() => _BilanPageState();
}

class _BilanPageState extends State<BilanPage> {
  Map<String, dynamic> userData = {}; // Pour stocker les informations de l'utilisateur
  Map<String, dynamic> topicResponses = {}; // Pour stocker les réponses au topic

  DataBaseService db = DataBaseService();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      // Récupérer les informations de l'utilisateur
      userData = await db.getUserData(widget.uid);

      // Récupérer les réponses pour le topic spécifique
      topicResponses = await db.getTopicResponses(widget.uid, widget.topic);

      setState(() {
        // Mettre à jour l'interface après avoir récupéré les données
      });
    } catch (e) {
      print("Erreur lors de la récupération des données : $e");
      // Gérer l'erreur ici (par exemple, afficher un message d'erreur à l'utilisateur)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF032174),
        centerTitle: true,
        title: Text(
          'Bilan - ${widget.topic}',
          style: TextStyle(
            fontSize: 18.0,
            fontFamily: 'Lexend',
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => QuizChoose(uid: widget.uid),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.blue, // Barre supérieure
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Name: ${userData['name']}',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'City: ${userData['City']}',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Country: ${userData['Country']}',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'State: ${userData['State']}',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Age: ${userData['age']}',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Phone number: ${userData['phoneNumber']}',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${widget.topic} topic Answers:',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: topicResponses.entries.map((entry) {
                String key = entry.key;
                dynamic response = entry.value;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text(
                    '- Question: $key\nAnswer: $response',
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                );
              }).toList(),
            ),
            Container(
              color: Colors.blue, // Barre inférieure
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}