import 'package:flutter/material.dart';
import 'package:quizart/screens/QuizChoose.dart';
import 'package:quizart/screens/laoding.dart';
import 'package:quizart/services/database.dart';

class BilanPage extends StatefulWidget {
  final String topic;
  final String uid;

  const BilanPage({Key? key, required this.topic, required this.uid}) : super(key: key);

  @override
  _BilanPageState createState() => _BilanPageState();
}

class _BilanPageState extends State<BilanPage> {
  late Future<List> data;
  DataBaseService db = DataBaseService();

  @override
  void initState() {
    super.initState();
    data = fetchData();
  }

  Future<List> fetchData() async {
    try {
      return [await db.getUserData(widget.uid), await db.getTopicResponses(widget.uid, widget.topic), await db.getData(widget.topic)];
    } catch (e) {
      print("Erreur lors de la récupération des données : $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: data,
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return const Loading(); // Assuming Loading() is a widget for showing loading state
        } else if (snapshot.hasError) {
          final error = snapshot.error;
          return Text("Error has occurred: $error");
        } else {
          if (snapshot.hasData) {
            List data = snapshot.data!;
            Map<String, dynamic> userData = data[0]; // all available topics
            Map<String, dynamic> topicResponses = data[1]; // topics that the user has already answered to
            Map<String, dynamic> Questions = data[2];

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

                    User_card(name: userData['name']??  "", city: userData['City']??  "", state: userData['State']??  "", country: userData['Country']??  "", user_age: userData['age']??  "", phone_number: userData['phoneNumber'] ??  ""),
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
          } else {
            return const Loading(); // Return loading state if there's no data yet
          }
        }
      },
    );
  }
}


class User_card extends StatelessWidget {
  String name, city, state, country, user_age, phone_number;
  User_card({
                super.key,
                required this.name,
                required this.city,
                required this.state,
                required this.country,
                required this.user_age,
                required this.phone_number,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
         margin: EdgeInsets.symmetric(vertical: 10),
         width: MediaQuery. of(context). size. width * 0.9,
         decoration: BoxDecoration(
          color:  Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 3,
              offset: const Offset(0, 3),
            ),
          ],
        ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
                Text(
                  "name : $name",
                ),
              Text(
                  "age : $user_age",
              ),
              Text(
                  "phone_number : $phone_number",
              ),
              Text(
                  "country : $country",
              ),
              Text(
                  "city : $city",
              ),
              Text(
                "state : $state",
              ),
            ],
          ),
      ),
    );
  }
}


