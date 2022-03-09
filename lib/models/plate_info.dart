import 'package:flutter/material.dart';

class PlateInfo {
  String plateText;
  String activity;
  String location;
  String timeStamp;

  PlateInfo(
      {required this.plateText,
      required this.activity,
      required this.location,
      required this.timeStamp});

  @override
  String toString() {
    // TODO: implement toString
    return "Platetext: $plateText \nActivity: $activity\nLocation: $location\ntimestamp: $timeStamp\n";
  }
}
