import 'package:flutter/material.dart';
import 'package:nit_anpr_app/models/plate_info.dart';
import 'package:nit_anpr_app/widgets/plate_card.dart';

class MySearchBar extends StatelessWidget {
  Icon? suffixIcon;
  String hint;
  MySearchBar({Key? key, this.hint = "", this.suffixIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          hintText: hint,
          suffixIcon: suffixIcon),
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  PlateInfo demoPlate = PlateInfo(
      plateText: "HR06AH1935",
      activity: "IN",
      location: "Gate1",
      timeStamp: "09/03.2022 01:07AM");

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: MySearchBar(
                    hint: "Search for license plate",
                    suffixIcon: const Icon(Icons.search))),
            PlateCard(plate: demoPlate),
            PlateCard(plate: demoPlate)
          ],
        ),
      ),
    );
  }
}
