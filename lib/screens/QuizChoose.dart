import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';



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
  _QuizChooseState createState() => _QuizChooseState();
}

class _QuizChooseState extends State<QuizChoose> {

  List<Survey> surveys = [
    Survey(
      name: 'Cinema',
      image:
      'https://mediakwest.com/wp-content/uploads/2019/07/1_Beaugrenelle.ONYX-c-Fr%C3%A9d%C3%A9ric-Berthet.HD_.006.jpg',
      icon: Icons.theater_comedy,
    ),
    Survey(
      name: 'Gaming',
      image:
      'https://builtin.com/cdn-cgi/image/f=auto,quality=80,width=752,height=435/https://builtin.com/sites/www.builtin.com/files/styles/byline_image/public/2022-08/gaming-companies.png',
      icon: Icons.videogame_asset,
    ),
    Survey(
      name: 'Education',
      image:
      'https://i.guim.co.uk/img/media/423d3ddf306e98864c1d887c1dcf290421cd21a7/0_169_4912_6140/master/4912.jpg?width=700&quality=85&auto=format&fit=max&s=864393ed1c322fc5ddcb2766c3c945e6',
      icon: Icons.book,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Menu page',
          style: GoogleFonts.lexend(
            fontSize: 20.0,
          ),
        ),
        backgroundColor: Color(0xFF032174),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height * 0.4,
              enlargeCenterPage: true,
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.55,
            ),
            items: surveys.map((survey) {
              return Builder(
                builder: (BuildContext context) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DestinationPage(),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.7,
                      margin: EdgeInsets.symmetric(horizontal: 1.0),
                      decoration: BoxDecoration(
                        color: Color(0xffa99d76),
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 10,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          survey.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'All Surveys',
            style: GoogleFonts.lexend(
              fontSize: 25.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Column(
            children: surveys.map((survey) {
              return CustomCard(
                iconData: survey.icon,
                text: survey.name,
                // You can modify the completion logic based on your requirements
                completed: false,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class DestinationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Destination Page'),
        // Add any additional app bar customization here
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Destination Page!',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // You can add functionality for the button if needed
                Navigator.pop(context); // Navigate back to the previous page
              },
              child: Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}


class CustomCard extends StatelessWidget {
  final IconData iconData;
  final String text;
  final bool completed;

  CustomCard({
    required this.iconData,
    required this.text,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.all(8.0),
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            iconData,
            size: 42.0,
            color: Color(0xFF032174),
          ),
          Spacer(),
          SizedBox(width: 10.0),
          Text(
            text,
            style: GoogleFonts.lexend(
              fontSize: 22.0,
            ),
          ),
          Spacer(),
          if (completed)
            Icon(
              Icons.check_circle_outline,
              color: Color(0xFF032174),
              size: 30.0,
            )
          else
            Icon(
              Icons.more_horiz,
              color: Color(0xFF032174),
              size: 30.0,
            ),
        ],
      ),
    );
  }
}

