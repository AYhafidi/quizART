import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo/firebase_options.dart';

class DataBaseService{
  // collection reference
  final CollectionReference questionCollection = FirebaseFirestore.instance.collection("Questions");
  Future<List> getData() async {
    // Get docs from collection reference
    QuerySnapshot querySnapshot = await questionCollection.get();

    // Get data from docs and convert map to List

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }
}
