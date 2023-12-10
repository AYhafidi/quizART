import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:quizart/screens/signin.dart'; 

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: AnimatedSplashScreen(
          duration: 3000,
          splash: Lottie.asset(
            'Json/splash_animation.json',
            width: MediaQuery.of(context).size.width, // width of the device
            height: MediaQuery.of(context).size.height, // height of the device
            fit: BoxFit.contain, // to avoid distortion
          ),
          nextScreen: const UserSignIn(), // Navigate to the Signin page after the splash screen
          splashTransition: SplashTransition.fadeTransition,
          backgroundColor: Colors.transparent, // Make the background color transparent
          splashIconSize: double.infinity, // Use the maximum splash size
        ),
      ),
    );
  }
}