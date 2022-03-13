import 'package:flutter/material.dart';
import 'package:nit_anpr_app/models/location_info.dart';

class LocationCard extends StatelessWidget {
  Color cardColor;
  LocationInfo locationInfo;
  LocationCard(
      {Key? key, this.cardColor = Colors.blue, required this.locationInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          height: 100,
          width: 150,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: cardColor, borderRadius: BorderRadius.circular(15)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                locationInfo.location,
                style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  Text(
                    "${locationInfo.ins} Ins",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "${locationInfo.outs} Outs",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
