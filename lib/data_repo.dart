//This module/file is to connect the app to the DB

import 'package:cloud_firestore/cloud_firestore.dart';

class DataRepository {
  var firestore = FirebaseFirestore.instance;

  Future<void> testFirestore() async {
    QuerySnapshot<Map<String, dynamic>> plateDocs = await firestore
        .collection("plates_data")
        .doc("22-03-2022")
        .collection("plates")
        .get();

    for (QueryDocumentSnapshot<Map<String, dynamic>> doc in plateDocs.docs) {
      print(doc.data());
    }
  }
}
