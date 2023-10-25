import 'package:flutter/material.dart';
import 'package:demo/screens/loading.dart';


class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading?Loading(): Scaffold(
        body: Center(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: ElevatedButton.icon(
                onPressed: () => {
                  setState(()=> {
                    loading = true
                  })
                },
                label: Text("Start"),
                icon: Icon(Icons.navigate_before),
            ),
          )
        )
    );
  }
}
