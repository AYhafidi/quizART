import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizart/services/auth.dart';
import 'package:quizart/services/toast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UserSignIn extends StatefulWidget {
  const UserSignIn({super.key});

  @override
  _UserSignInState createState() => _UserSignInState();
}

class _UserSignInState extends State<UserSignIn> {
  bool _connected = false;
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
      backgroundColor: Colors.white, // Set background color to white
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Set AppBar background to transparent
        elevation: 0, // Remove shadow
        centerTitle: true, // Center title
        title: const Text('LogIn', style: TextStyle(color: Colors.black)), // Set title text style
      ),
      body: SingleChildScrollView( // Allow the form to be scrollable
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextField(
                  'Email',
                  _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: _validateEmail,
                ),
                const SizedBox(height: 20),
                _buildTextField(
                  'Password',
                  _passwordController,
                  isPassword: true, // Specify this field is for password input
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _connected ? null : _submitFormSignIn, // Disable button if _connected is true
                  child: _connected
                    ? const CircularProgressIndicator() // Show loading indicator if _connected is true
                    : const Text('Connect'),
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromRGBO(54, 76, 244, 1), // Button background color
                    onPrimary: Colors.white, // Button text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0), // Button border radius
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: _connected ? null : () {
                        // Add Google sign-in logic
                      },
                      icon: const FaIcon(FontAwesomeIcons.google, color: Colors.white),
                      label: const Text(
                        'Connect with Google',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Color.fromRGBO(54, 76, 244, 1), // Google button background color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0), // Google button border radius
                        ),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: _connected ? null : () {
                    Navigator.pushNamed(context, '/user_info_form');
                  },
                  child: const Text(
                    'Pas encore inscrit ? Créer un compte',
                    style: TextStyle(
                      color: Color.fromRGBO(54, 76, 244, 1), // Sign-up prompt color
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType? keyboardType,
    String? Function(String?)? validator,
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0), // Input field border radius
        ),
        filled: true,
        fillColor: Colors.grey[200], // Input field fill color for light theme
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

  

  void _submitFormSignIn() async {
    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid, handle form submission here
      setState(() {
        _connected = true;
      });
      String email = _emailController.text;
      String password = _passwordController.text;

      User? user = await _auth.SignIn(email, password);

      setState(() {
        _connected = false;
      });
      if (user != null) {
        showToast(message: "user connected");
        Navigator.pushReplacementNamed(context, "/quiz", arguments: {
          "uid": user.uid,
        });
      } else {
        showToast(message: "not registered!");
      }
    }
  }
}
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:quizart/services/auth.dart';
// import 'package:quizart/services/toast.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class UserSignIn extends StatefulWidget {
//   const UserSignIn({super.key});

//   @override
//   _UserSignInState createState() => _UserSignInState();
// }

// class _UserSignInState extends State<UserSignIn> {
//   bool _connected = false;
//   final AuthentService _auth = AuthentService();

//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   void dispose(){
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }
//   final _formKey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('LogIn'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: <Widget>[

//               _buildTextField('Email', _emailController,
//                   keyboardType: TextInputType.emailAddress,
//                   validator: _validateEmail),
//               const SizedBox(height: 20),
//               TextFormField(
//                 obscureText: true,
//                 controller: _passwordController,
//                 decoration: const InputDecoration(
//                   labelText: 'Password',
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//               const SizedBox(height: 20),

//               ElevatedButton(
//                 onPressed: () {
//                   _submitFormSignIn();
//                 },
//                 child: const Text('Connect'),
//               ),
//               const SizedBox(height: 16.0), // Espacement entre les boutons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: () {
//                     },
//                     icon: const FaIcon(FontAwesomeIcons.google),
//                     label: const Text('Connect with Google',style: TextStyle(color:Colors.white,
//                     fontWeight: FontWeight.bold)),
//                   ),
//                 ],
//               ),
//               GestureDetector(
//                 onTap: () {
//                   // Navigation vers la page d'inscription
//                   Navigator.pushNamed(context, '/user_info_form');
//                 },
//                 child: const Text(
//                   'Pas encore inscrit ? Créer un compte',
//                   style: TextStyle(
//                     color: Colors.blue,
//                     decoration: TextDecoration.underline,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(String label, TextEditingController controller,
//       {TextInputType? keyboardType, String? Function(String?)? validator}) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       decoration: InputDecoration(
//         labelText: label,
//         border: const OutlineInputBorder(),
//       ),
//       validator: validator,
//     );
//   }

//   String? _validateEmail(String? value) {
//     if (value == null || value.isEmpty) {
//       return 'Email requis';
//     }
//     if (!RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$")
//         .hasMatch(value)) {
//       return 'Email invalide';
//     }
//     return null;
//   }


//   void _submitFormSignIn() async{
//     if (_formKey.currentState?.validate() ?? false) {
//       // Form is valid, handle form submission here
//       setState((){
//         _connected = true;
//       });
//       String email = _emailController.text;
//       String password = _passwordController.text;

//       User? user = await _auth.SignIn(email, password);

//       setState((){
//         _connected= false;
//       });
//       if(user != null){
//         showToast(message:"user connected");
//         Navigator.pushReplacementNamed(context, "/quiz",  arguments: {
//             "uid" :  user.uid,
//         },);
//       }else{
//         showToast(message:"not registered!");
//       }
//     }
//   }
// }
