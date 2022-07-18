import 'package:flutter/cupertino.dart';
import 'package:nit_anpr_app/Constants.dart';
import 'package:nit_anpr_app/data_repo.dart';
import 'package:nit_anpr_app/models/location_info.dart';
import 'package:nit_anpr_app/models/plate_info.dart';
import 'package:nit_anpr_app/sample_data.dart';

class PlatesDataProvider extends ChangeNotifier {
  List<PlateInfo> _platesList = [];

  List<PlateInfo> get plates => _platesList;

  Map<String, LocationInfo> getLocationData(List<PlateInfo> plates) {
    Map<String, LocationInfo> locData = {};
    plates.forEach((element) {
      String loc = element.location;
      String act = element.activity;
      locData.putIfAbsent(loc, () => LocationInfo(location: loc));
      if (act == AppConstants.ACTIVITY_IN) locData[loc]!.ins += 1;
      if (act == AppConstants.ACTIVITY_OUT) locData[loc]!.outs += 1;
    });

    return locData;
  }

  int getTotalIns(List<PlateInfo> plates) {
    int countIns = 0;
    plates.forEach((element) {
      if (element.activity == AppConstants.ACTIVITY_IN) countIns += 1;
    });

    return countIns;
  }

  int getTotalOuts(List<PlateInfo> plates) {
    int countOuts = 0;
    plates.forEach((element) {
      if (element.activity == AppConstants.ACTIVITY_OUT) countOuts += 1;
    });

    return countOuts;
  }

  // To set the original list from the DB
  //TODO: Change the method to fetch the list based on date/time given as filters by the user
  //Must fetch the new list everytime the time frame is changed by the user
  void setPlatesList(List<PlateInfo> newPlates) {
    _platesList = newPlates;
    // notifyListeners();
  }

  Future<List<PlateInfo>> fetchPlatesList(
      DateTime? startDay, DateTime? endDay) async {
    List<PlateInfo> plates =
        await DataRepository().fetchPlates(startDay, endDay);

    plates.forEach(
      (element) {
        print(element.toString());
      },
    );
    setPlatesList(plates);
    return plates;
  }

  List<PlateInfo> getFilteredPlates(String query) {
    List<PlateInfo> filteredList = _platesList
        .where((element) =>
            element.plateText.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return filteredList;
  }
}
