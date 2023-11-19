import 'package:firebase_auth/firebase_auth.dart';
import 'package:quizart/services/toast.dart';
class AuthentService {
  FirebaseAuth _auth = FirebaseAuth.instance;

//Inscription
Future<User?>  Register (String email, String password) async{
try {
  UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email,password:password);
  return cred.user;
}on FirebaseAuthException catch(e) {
  if (e.code == 'email-already-in-use') {
   showToast(message: 'The email address is already in use.');
  } else {
    showToast(message: 'An error occurred: ${e.code}');
  }
}
return null;
}

//Connection:
Future<User?>  SignIn (String email, String password) async{
  try {
    UserCredential cred = await _auth.signInWithEmailAndPassword(email: email,password:password);
    return cred.user;
  }
  on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found' || e.code == 'wrong-password') {
      showToast(message: 'Invalid email or password.');
    } else {
      showToast(message: 'An error occurred: ${e.code}');
    }

  }
  return null;
}
}
