import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizart/screens/home.dart';
import 'package:quizart/screens/bilan.dart';
import 'package:quizart/screens/laoding.dart';
import 'package:quizart/services/database.dart';
import 'package:quizart/components/CustomCard.dart';
import 'package:lottie/lottie.dart';



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
  final String uid;
  QuizChoose({Key? key, required this.uid}) : super(key: key);

  @override
  QuizChooseState createState() => QuizChooseState();
}

class QuizChooseState extends State<QuizChoose> {
  DataBaseService db = DataBaseService();
  late Future<List<dynamic>> info;

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

  Future<List> getUserTopics(String uid) async{
    List topics = await db.getUserTopics(uid);
    return topics;
  }


  Future<List<dynamic>> getInfo() async {
    String uid = widget.uid;
    // Call func_2 with the result of func_1 and await its result
    await Future.delayed(const Duration(seconds: 2), () {
      return '';
    });

    List<dynamic> userTopics = await getUserTopics(uid);


    // Call func_3 and await its result
    List<dynamic> topics = await getTopics();

    // Combine all results into one list
    List<dynamic> combinedResults = [topics, userTopics, uid];


    return combinedResults;
  }

  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    info = getInfo();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: info,
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          return const Loading(); // Assuming Loading() is a widget for showing loading state
        } else if (snapshot.hasError) {
          final error = snapshot.error;
          return Text("Error has occurred: $error");
        } else {
          if (snapshot.hasData) {
            List<dynamic> data = snapshot.data!;
            List<dynamic> topics = data[0]; // all available topics
            List<dynamic> userTopics = data[1]; // topics that the user has already answered to
            String uid = data[2];

            return Scaffold(
              appBar: AppBar(
                title: Center(
                  child: Text(
                    'Choose Quiz',
                    style: GoogleFonts.lexend(

                      color: Colors.white,
                      fontSize: 20.0,
                    ),
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
                                    if( ! userTopics.contains(topic)){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                            builder: (context) => Home(topic: topic, uid: uid),
                                         ),
                                    );
                              }else {
                                      // L'utilisateur a déjà répondu à ce sujet, naviguez vers la page Bilan
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BilanPage(topic: topic, uid: uid),
                                        ),
                                      );
                                    }
                                    },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.7,
                                margin: const EdgeInsets.symmetric(horizontal: 1.0),
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
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10.0),
                                  child: Lottie.asset(
                                    'assets/Json/$topic.json',
                                    fit: BoxFit.contain, // Use BoxFit.contain to avoid distortion
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
                        itemBuilder: (BuildContext context, int index) => GestureDetector(
                          onTap: (){
                            if( ! userTopics.contains(topics[index])){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(topic: topics[index], uid: uid),
                                ),
                              );
                            }else {
                              // L'utilisateur a déjà répondu à ce sujet, naviguez vers la page Bilan
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BilanPage(topic: topics[index], uid: uid),
                                ),
                              );
                            }

                          },
                          child: CustomCard(
                            iconData: topicIcon(topics[index]),
                            text: topics[index],
                            completed: userTopics.contains(topics[index]),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
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

