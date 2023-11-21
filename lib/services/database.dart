import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizart/firebase_options.dart';
import 'package:flutter/services.dart';
import 'dart:convert';


class DataBaseService{
  // collection reference
  final CollectionReference questionCollection = FirebaseFirestore.instance.collection("Questions");
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection("Users");

                                /* Get the data from database*/

  Future<List> getData(String title) async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await questionCollection
        .where('title', isEqualTo: title)
        .get();

    // Get data from docs and convert map to List.
    List data = querySnapshot.docs.map((doc) => doc.data()).toList();
    return data[0]["Questions"];
  }

  Future<void> addQuestions(String File) async {
    // Get docs from collection reference
    String jsonString = await rootBundle.loadString('data.json');
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
      DocumentReference userDoc = usersCollection.doc(id);

      // Get the current data of the document
      DocumentSnapshot userSnapshot = await userDoc.get();
      dynamic userData = userSnapshot.data();
      // Get the current 'quizes' data from the document

      Map<String, dynamic> currentQuizes = userData['quizes'] ?? {};

      // Merge the new quiz data with the current 'quizes' data
      Map<String, dynamic> updatedQuizes = {...currentQuizes, ...quizMap};

      // Update the 'quizes' field in the document
      await userDoc.update({'quizes': updatedQuizes});
    } catch (e) {
      print("Failed to add quiz to user: $e");
    }
  }
}
