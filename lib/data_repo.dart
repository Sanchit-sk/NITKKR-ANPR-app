//This module/file is to connect the app to the DB

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:nit_anpr_app/models/plate_info.dart';

class DataRepository {
  var firestore = FirebaseFirestore.instance;

  List<DateTime> getDaysInBeteween(DateTime startDate, DateTime endDate) {
    List<DateTime> days = [];
    for (int i = 0; i <= endDate.difference(startDate).inDays; i++) {
      days.add(startDate.add(Duration(days: i)));
    }
    return days;
  }

  Future<List<PlateInfo>> getDayPlates(DateTime date) async {
    List<PlateInfo> plates = [];
    try {
      QuerySnapshot<Map<String, dynamic>> plateDocs = await firestore
          .collection("plates")
          .doc(dateToString(date))
          .collection("plates_data")
          .get();

      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in plateDocs.docs) {
        // print(doc.id);
        // // print(doc.data());
        // String plateText = doc.id;
        Map<String, dynamic> docData = doc.data();
        plates.add(PlateInfo(
            plateText: docData["plate"],
            activity: docData["activity"],
            location: docData["location"],
            timeStamp: dateToString(date) +
                " " +
                docData["time"].toString().substring(0, 5)));

        print(docData);
        print(plates.length);
      }
    } catch (e) {
      print(e);
    }

    return plates;
  }

  String dateToString(DateTime dateTime) {
    return DateFormat("yyyy-MM-dd").format(dateTime);
  }

  Future<List<PlateInfo>> fetchPlates(
      DateTime? startDateTime, DateTime? endDateTime) async {
    startDateTime = startDateTime ?? DateTime.now();
    endDateTime = endDateTime ?? DateTime.now();
    List<DateTime> days = getDaysInBeteween(startDateTime, endDateTime);
    days.forEach((element) {
      print(dateToString(element));
    });

    List<PlateInfo> plates = [];
    for (var day in days) {
      List<PlateInfo> dayPlates = await getDayPlates(day);
      plates.addAll(dayPlates);
    }

    // print(plates.length);
    print("Fetched plates list length : ${plates.length}");
    plates.sort((a, b) => a.timeStamp.compareTo(b.timeStamp));
    return plates.reversed.toList();
  }
}
