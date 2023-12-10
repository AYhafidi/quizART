import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizart/screens/QuizChoose.dart';
import 'package:quizart/services/auth.dart';
import 'package:quizart/services/toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



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
    return Scaffold(
      appBar: AppBar(
        title: const Text('LogIn'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              _buildTextField('Email', _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail),
              const SizedBox(height: 20),
              TextFormField(
                obscureText: true,
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: ()async {

                  _submitFormSignIn();
                },
                child: const Text('Connect'),
              ),
              const SizedBox(height: 16.0), // Espacement entre les boutons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                    },
                    icon: const FaIcon(FontAwesomeIcons.google),
                    label: const Text('Connect with Google',style: TextStyle(color:Colors.white,
                    fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  // Navigation vers la page d'inscription
                  Navigator.pushNamed(context, '/user_info_form');
                },
                child: const Text(
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
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }

String? _validateEmail(String? value) =>
    value?.isEmpty ?? true
        ? 'Email requis'
        : !RegExp(r"^[ a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$").hasMatch(value!)
            ? 'Email invalide'
            : null;


void _submitFormSignIn() async {
  if (_formKey.currentState?.validate() ?? false) {
    final email = _emailController.text;
    final password = _passwordController.text;

    final user = await _auth.SignIn(email, password);

    user != null
        ? _handleSuccessfulSignIn(user)
        : showToast(message: "not registered!");
  }
}

void _handleSuccessfulSignIn(User user) {
  showToast(message: "user connected");
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (context) => QuizChoose(uid: user.uid),
    ),
  );
}

}
