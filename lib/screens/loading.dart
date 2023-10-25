import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:demo/services/database.dart';



class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  getData() async{

    try {
      List data = await DataBaseService().getData();
      Navigator.pushReplacementNamed(context, "/home", arguments: {'data': data});
    } catch (e) {
      // Handle any potential errors here
      print('Error fetching data: $e');
    }
  }

  @override
  void initState () {
    super.initState();
    getData();
  }


  Widget build(BuildContext context) {
    return  Container(
      color: Colors.white,
      child: Center(
        child: SpinKitWaveSpinner(
          color: Colors.cyan,
          waveColor: Colors.blue,
          size: 50.0,
        ),
      ),
    );;
  }
}
