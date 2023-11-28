import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

  late ValueNotifier<String> welcomeTextNotifier;
  late AnimationController _blinkController;

  @override
  void initState() {
    super.initState();
    welcomeTextNotifier = ValueNotifier<String>('');
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);
    _animateText();
  }

  Future<void> _animateText() async {
    String text = '''Welcome    \n\nto our     \n\ngaming poll\n\n''';
    List<String> lines = text.split('\n');
    for (String line in lines) {
      for (int i = 0; i < line.length; i++) {
        await Future.delayed(
            const Duration(milliseconds: 65)); // Adjust animation speed here
        welcomeTextNotifier.value =
            text.substring(0, text.indexOf(line) + i + 1);
      }
      await Future.delayed(
          const Duration(milliseconds: 65)); // Pause for a second between lines
    }
  }

  @override
  void dispose() {
    _blinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: _buildBackgroundDecoration(),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(
                top: screenHeight * 0.22,
                right: screenWidth * 0.10,
                child: _buildWelcomeMessage(screenWidth),
              ),
              Positioned(
                bottom: screenHeight * 0.35,
                right: screenWidth * 0.33,
                child:
                    _buildStartQuizButton(context, screenWidth, screenHeight),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBackgroundDecoration() {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('images/background_image.jpg'),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildWelcomeMessage(double screenWidth) {
    return Padding(
      padding: const EdgeInsets.all(70.0),
      child: Align(
        alignment: Alignment.center,
        child: ValueListenableBuilder<String>(
          valueListenable: welcomeTextNotifier,
          builder: (context, value, child) {
            return Text(
              value,
              style: TextStyle(
                fontSize: screenWidth * 0.035,
                fontWeight: FontWeight.normal,
                fontFamily: 'PressStart2P',
                color: const Color(0xff4a58a9),
              ),
              textAlign: TextAlign.center,
            );
          },
        ),
      ),
    );
  }

  Widget _buildStartQuizButton(
      BuildContext context, double screenWidth, double screenHeight) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamed(context, '/signin');
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFF488E),
        minimumSize: Size(screenWidth * 0.3, screenHeight * 0.08),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: screenHeight * 0.02),
        child: Text(
          'Start Poll',
          style: TextStyle(
            fontSize: screenWidth * 0.023,
            fontWeight: FontWeight.bold,
            fontFamily: 'PressStart2P',
          ),
        ),
      ),
    );
  }
}

