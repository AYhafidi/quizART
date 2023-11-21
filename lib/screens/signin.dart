import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizart/services/auth.dart';
import 'package:quizart/services/toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
class UserSignIn extends StatefulWidget {
  @override
  _UserSignInState createState() => _UserSignInState();
}

class _UserSignInState extends State<UserSignIn> {
  bool _connected = false;
  final AuthentService _auth = AuthentService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LogIn'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              _buildTextField('Email', _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail),
              SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  _submitFormSignIn();
                },
                child: Text('Connect'),
              ),
              SizedBox(height: 16.0), // Espacement entre les boutons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                    },
                    icon: FaIcon(FontAwesomeIcons.google),
                    label: Text('Connect with Google',style: TextStyle(color:Colors.white,
                    fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  // Navigation vers la page d'inscription
                  Navigator.pushNamed(context, '/user_info_form');
                },
                child: Text(
                  'Pas encore inscrit ? Créer un compte',
                  style: TextStyle(
                    color: Colors.blue,
                    decoration: TextDecoration.underline,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
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
        border: OutlineInputBorder(),
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
        _connected = true;
      });
      String email = _emailController.text;
      String password = _passwordController.text;

      User? user = await _auth.SignIn(email, password);

      setState((){
        _connected= false;
      });
      if(user != null){
        showToast(message:"user connected");
        Navigator.pushReplacementNamed(context, "/quiz",  arguments: {
            "uid" :  user!.uid,
        },);
      }else{
        showToast(message:"not registered!");
      }
    }
  }
}
