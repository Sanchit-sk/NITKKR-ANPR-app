import 'package:nit_anpr_app/models/plate_info.dart';

final List<PlateInfo> platesData = [
  PlateInfo(
      plateText: "HR06AH1935",
      activity: "IN",
      location: "Gate1",
      timeStamp: "09/03.2022 01:07AM"),
  PlateInfo(
      plateText: "HR06AH1234",
      activity: "OUT",
      location: "Gate2",
      timeStamp: "09/03.2022 01:07AM"),
  PlateInfo(
      plateText: "HR06AH2345",
      activity: "IN",
      location: "Gate3",
      timeStamp: "09/03.2022 01:07AM"),
  PlateInfo(
      plateText: "HR06AH3456",
      activity: "OUT",
      location: "Gate1",
      timeStamp: "09/03.2022 01:07AM"),
  PlateInfo(
      plateText: "HR06AH4567",
      activity: "IN",
      location: "Gate2",
      timeStamp: "09/03.2022 01:07AM"),
  PlateInfo(
      plateText: "HR06AH5678",
      activity: "IN",
      location: "Gate3",
      timeStamp: "09/03.2022 01:07AM"),
  PlateInfo(
      plateText: "HR06AH6789",
      activity: "IN",
      location: "Gate2",
      timeStamp: "09/03.2022 01:07AM"),
  PlateInfo(
      plateText: "HR06AH7890",
      activity: "IN",
      location: "Gate3",
      timeStamp: "09/03.2022 01:07AM"),
  PlateInfo(
      plateText: "HR06AH0123",
      activity: "IN",
      location: "Gate1",
      timeStamp: "09/03.2022 01:07AM"),
];

final Map<String, double> pieChartData = {
  "Ins": 200,
  "Outs": 150,
};
