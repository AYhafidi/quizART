import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizart/screens/home.dart';
import 'package:quizart/screens/laoding.dart';
import 'package:quizart/services/database.dart';
import 'package:quizart/components/CustomCard.dart';



class Survey {
  String name;
  String image;
  IconData icon;

  Survey({
    required this.name,
    required this.image,
    required this.icon,
  });


}

class QuizChoose extends StatefulWidget {
  const QuizChoose({Key? key}) : super(key: key);

  @override
  QuizChooseState createState() => QuizChooseState();
}

class QuizChooseState extends State<QuizChoose> {
  DataBaseService db = DataBaseService();
  late Future<List> topics;
  late Future<List> userTopics;

  // 'https://mediakwest.com/wp-content/uploads/2019/07/1_Beaugrenelle.ONYX-c-Fr%C3%A9d%C3%A9ric-Berthet.HD_.006.jpg',


  IconData topicIcon(String icon){
    switch(icon){
      case "Education":
        return Icons.book;
      case "Gaming":
        return Icons.videogame_asset;
      case "Cinema":
        return Icons.theater_comedy ;
      default:
        return Icons.poll;
    }
  }

  Future<List> getTopics() async{
    List topics = await db.getAllTopics();
    return topics;
  }

  Future<List> getUserTopics() async{
    List topics = await db.getUserTopics("12345");
    return topics;
  }


  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    topics = getTopics();
    userTopics = getUserTopics();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Future.wait([topics, userTopics]),
        builder: (context, snapshot){
              if(snapshot.hasData){
                List data = snapshot.data!;
                List topics = data[0]; // all available topics
                List userTopics = data[1]; // topics that the user has already answered to
                print(userTopics);
                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      'Menu page',
                      style: GoogleFonts.lexend(
                        fontSize: 20.0,
                      ),
                    ),
                    backgroundColor: const Color(0xFF032174),
                  ),
                  body: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 5,
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: MediaQuery.of(context).size.height * 0.4,
                            enlargeCenterPage: true,
                            autoPlay: true,
                            autoPlayCurve: Curves.fastOutSlowIn,
                            autoPlayAnimationDuration: const Duration(milliseconds: 800),
                            viewportFraction: 0.55,
                          ),
                          items: topics.map((topic) {
                            return Builder(
                              builder: (BuildContext context) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Home(topic: topic, uid: "12345")
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width * 0.7,
                                    margin: const EdgeInsets.symmetric(horizontal: 1.0),
                                    decoration: BoxDecoration(
                                      color: const Color(0xffa99d76),
                                      borderRadius: BorderRadius.circular(15.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.3),
                                          spreadRadius: 5,
                                          blurRadius: 10,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        'https://mediakwest.com/wp-content/uploads/2019/07/1_Beaugrenelle.ONYX-c-Fr%C3%A9d%C3%A9ric-Berthet.HD_.006.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ),


                      Expanded(
                        flex: 1,
                        child: Text(
                          'All Surveys',
                          style: GoogleFonts.lexend(
                            fontSize: 25.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 4,
                        child: Container(
                            child: ListView.builder(
                              itemCount: topics.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  CustomCard(
                                    iconData: topicIcon(topics[index]),
                                    text: topics[index],
                                    completed: userTopics.contains(topics[index]),
                                  )
                              ,)
                        ),
                      ),
                    ],
                  ),
                );
              }else if(snapshot.hasError){
                  final error = snapshot.error;
                  return Text("Error has occured : $error");
              }
              else{
                return Loading();
              }
        }
    );
    /*return */
  }
}

