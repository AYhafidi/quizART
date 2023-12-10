import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quizart/screens/home.dart';
import 'package:quizart/screens/laoding.dart';
import 'package:quizart/services/database.dart';
import 'package:quizart/components/CustomCard.dart';
import 'package:lottie/lottie.dart';



class QuizChoose extends StatefulWidget {
  final String uid;
  QuizChoose({Key? key, required this.uid}) : super(key: key);

  @override
  QuizChooseState createState() => QuizChooseState();
}

class QuizChooseState extends State<QuizChoose> {
  DataBaseService db = DataBaseService();
  late Future<List<dynamic>> info;

  IconData topicIcon(String topic){
    switch(topic){
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

  String topicLottie(String topic){
    switch(topic){
      case "Education":
        return "https://lottie.host/975f4dee-d9a1-43cc-b1f3-e7ab848768bf/egm1ImyvXk.json";
      case "Gaming":
        return "https://lottie.host/2b4fa19a-8677-473b-99ad-8c76e39b9ae5/vHxkaDV3nU.json";
      case "Cinema":
        return "https://lottie.host/3ef34fbc-805a-4d92-8819-c1b26cd4ed47/g7mekcAYaN.json" ;
      case "Art":
        return "https://lottie.host/c11da15c-bbff-47c5-b9ee-290996bf9285/IdWN17BKoU.json";
      default:
        return "https://lottie.host/421aace8-ae32-44ec-9d23-c6c9dc281dbc/c7udAJiEMn.json";
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

    return  [await getTopics(), await getUserTopics(widget.uid) ];
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
          return const Loading(); 
        } else if (snapshot.hasError) {
          final error = snapshot.error;
          return Text("Error has occurred: $error");
        } else {
          if (snapshot.hasData) {
            List<dynamic> data = snapshot.data!;
            List<dynamic> topics = data[0]; // all available topics
            List<dynamic> userTopics = data[1]; // topics that the user has already answered to
            String uid = widget.uid;
            

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
                                    if( ! userTopics.contains(topic)){
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                            builder: (context) => Home(topic: topic, uid: uid),
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
                                  child: Lottie.network(
                                    topicLottie(topic),
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

