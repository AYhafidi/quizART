import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizart/services/toast.dart';
import 'package:quizart/services/database.dart';

import 'package:quizart/services/auth.dart';
class UserInfoForm extends StatefulWidget {
  @override
  _UserInfoFormState createState() => _UserInfoFormState();
}

class _UserInfoFormState extends State<UserInfoForm> {
  final AuthentService _auth = AuthentService();
  bool _registered = false;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  DataBaseService db = DataBaseService();

  String? _selectedCity;
  String? _selectedState;
  String? _selectedCountry;

  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  void dispose(){
    _nameController.dispose();
    _ageController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Info Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildTextField('Nom et Prénom', _nameController),
              SizedBox(height: 20),
              _buildTextField('Âge', _ageController,
                  keyboardType: TextInputType.number),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: IntlPhoneField(
                  controller: _phoneController,
                  decoration: InputDecoration.collapsed(
                    hintText: 'Numéro de téléphone',
                  ),


                  // initialCountryCode: _getCountryCode(),
                  // onChanged: (phone) {
                  //   // Handle phone number changes
                  // },
                ),

              ),
              SizedBox(height: 20),
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
              CSCPicker(
                layout: Layout.vertical,
                onCountryChanged: (country) {
                  setState(() {
                    _selectedCountry = country;
                  });
                },
                onStateChanged: (state) {
                  _selectedState = state;
                },
                onCityChanged: (city) {
                  setState(() {
                    _selectedCity = city;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                   _submitForm();
                   showToast(message: "user created");},
                child: Text('Submit'),
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

  void _submitForm() async{

    if (_formKey.currentState?.validate() ?? false) {
      // Form is valid, handle form submission here
      setState((){
       _registered = true;
          });
      String name = _nameController.text;
      String age = _ageController.text;
      String phoneNumber = _phoneController.text;
      String email = _emailController.text;
      String password = _passwordController.text;

      // Retrieve selected country, state, and city
      String? selectedCountry = _selectedCountry;
      String? selectedState = _selectedState;
      String? selectedCity = _selectedCity;


      User? user = await _auth.Register(email, password);
      setState((){
        _registered = false;
      });
      if(user != null){
        showToast(message:"user registered");
        db.addUserinformation(user!.uid, {
          "name" : name,
          "age" : age,
          "phoneNumber" : phoneNumber,
          "Country" : selectedCountry,
          "State" : selectedState,
          "City" : selectedCity,
          "quizes" : {},
        });
        Navigator.pushReplacementNamed(context, "/quiz",  arguments: {
          "uid" :  user!.uid,
        },);
      }else{
        showToast(message:"not registered!");
      }
    }
  }
}
