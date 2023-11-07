import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quizart/firebase_options.dart';


class DataBaseService{
  // collection reference
  final CollectionReference questionCollection = FirebaseFirestore.instance.collection("Questions");
  final CollectionReference responseCollection = FirebaseFirestore.instance.collection("Responses");


                            /* Returns the ID of a new document created in responses collection */

  String newDocumentID(){
    DocumentReference newDocRef = responseCollection.doc();
    return newDocRef.id;
  }
                                /* Get the data from database*/

  Future<List> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await questionCollection.get();

    // Get data from docs and convert map to List.
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

                            /* put response in the database*/
  Future<void> addUserResponse(String id, String question, String response) async {
    // Get docs from collection reference
    responseCollection.doc(id).set({"question" : question, "response":response}, SetOptions(merge: true)); // <-- Set merge to true.
  }

                            /* update response in the database*/
  Future<void> updateUserResponse(String id, String question, String response) async {
    // Get docs from collection reference
    responseCollection.doc(id).update({question : response}); // <-- Set merge to true.
  }
}
