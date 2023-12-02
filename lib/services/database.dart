import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'dart:convert';


class DataBaseService{
  // collection reference
  final CollectionReference questionCollection = FirebaseFirestore.instance.collection("Questions");
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection("Users");
  final CollectionReference AnswersCollection = FirebaseFirestore.instance.collection("Answers");


                                /* Get the data from database*/

  Future<Map> getData(String title) async {
    // Get docs from collection reference

    try{
      QuerySnapshot querySnapshot = await questionCollection
          .where('title', isEqualTo: title)
          .limit(1) // Limit the result to 1 document
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        dynamic data = querySnapshot.docs.first.data();
        return data["Questions"]; // Return the first (and only) document
      } else {
        return {}; // No document found
      }

    }
    catch(e){
      print('Error: $e');
      return {};
    }

  }

  Future<List> getAllTopics() async{
    try{
      QuerySnapshot querySnapshot = await questionCollection.get();
      if (querySnapshot.docs.isNotEmpty) {
        List<QueryDocumentSnapshot> documents = querySnapshot.docs;
        return documents.map((doc){
        dynamic data = doc.data();
        return data["title"];
        }
        ).toList(); // Return the first (and only) document
      } else {
        return []; // No document found
      }

    }
    catch(e){
      print('Error: $e');
      return [];
    }
  }

  Future<List> getUserTopics(String uid) async{
    try{
      // Get the user's document reference
      DocumentReference userDoc = AnswersCollection.doc(uid);
      // Get the current data of the document
      DocumentSnapshot userSnapshot = await userDoc.get();
      dynamic userData = userSnapshot.data() ?? {};

      return userData.keys.toList();
    }catch(e){
        print("Error occured : ${e}");
        return [];
    }
  }

  Future<void> addQuestions(String File) async {
    // Get docs from collection reference
    String jsonString = await rootBundle.loadString(File);
    Map<String, dynamic> data = jsonDecode(jsonString);
    questionCollection.add({"title" : data["title"], "Questions":data["Questions"]}); // <-- Set merge to true.
  }


                            /* put response in the database*/
  Future<void> addUserinformation(String id, Map<String, dynamic> information) async {
    // Get docs from collection reference
    usersCollection.doc(id).set(information, SetOptions(merge: true)); // <-- Set merge to true.
  }

  Future<void> addUserResponse(String id, String title, Map<String, dynamic> data) async {
    try {
      // Create a map with the quizId as key and the quizData as value
      Map<String, dynamic> quizMap = {title: data};

      // Get the user's document reference
      DocumentReference userDoc = AnswersCollection.doc(id);


      // Get the current data of the document
      DocumentSnapshot userSnapshot = await userDoc.get();
      dynamic userData = userSnapshot.data() ?? {};

      // add the answers to firebase with the title of the quiz
      userData.isEmpty ? await userDoc.set(quizMap) : await userDoc.update(quizMap);

    } catch (e) {
      print("Failed to add quiz to user: $e");
    }
  }
}
