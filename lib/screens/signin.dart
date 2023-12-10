import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizart/screens/QuizChoose.dart';
import 'package:quizart/services/auth.dart';
import 'package:quizart/services/toast.dart';



class UserSignIn extends StatefulWidget {
  const UserSignIn({super.key});

  @override
  _UserSignInState createState() => _UserSignInState();
}

class _UserSignInState extends State<UserSignIn> {
  final AuthentService _auth = AuthentService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }


  final _formKey = GlobalKey<FormState>();
  @override
Widget build(BuildContext context) {
  var backgroundImage = 'assets/images/background_LOGIN_page.png'; // Replace with your actual asset path

  return Scaffold(
    backgroundColor: Colors.white,
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        // Background image with text on top
        Container(
          height: MediaQuery.of(context).size.height * 0.60, // Adjust the height as needed
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundImage),
              fit: BoxFit.cover,
            ),
          ),
          alignment: Alignment.center,
          child: const Text(
            'Welcome To PollArt',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        // Form starts here
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, // Align form at the top of the remaining space
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 0), // Space between image and form
                  _buildTextField('Email', _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: _validateEmail),
                  SizedBox(height: 20),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      _submitFormSignIn();
                    },
                    child: const Text('Connect'),
                    style: ElevatedButton.styleFrom(
                      primary: const Color.fromRGBO(109, 114, 224, 1), // background
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/user_info_form');
                  },
                  style: TextButton.styleFrom(
                    primary: Colors.blue, // Text color
                    backgroundColor: const Color.fromARGB(0, 0, 0, 0), // Transparent background
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Minimizes the tap area to the size of the child
                    padding: EdgeInsets.zero, // No padding
                  ),
                  child: Text(
                    'Not registered? Register here',
                    style: TextStyle(
                      decoration: TextDecoration.underline, // Underline to indicate it's a link
                    ),
                  ),
                ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

  Widget _buildTextField(String label, TextEditingController controller,
      {TextInputType? keyboardType, String? Function(String?)? validator}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email requis';
    }
    if (!RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
        .hasMatch(value)) {
      return 'Email invalide';
    }
    return null;
  }


  void _submitFormSignIn() async{
    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid, handle form submission here
      setState((){
      });
      String email = _emailController.text;
      String password = _passwordController.text;

      User? user = await _auth.SignIn(email, password);

      setState((){
      });
      if(user != null){
        showToast(message:"user connected");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => QuizChoose(uid: user.uid),
          ),
        );
      }else{
        showToast(message:"not registered!");
      }
    }
  }
}
