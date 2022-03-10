import 'package:flutter/material.dart';

class LocationCard extends StatelessWidget {
  Color cardColor;
  String location;
  int ins;
  int outs;
  LocationCard(
      {Key? key,
      this.cardColor = Colors.blue,
      required this.location,
      required this.ins,
      required this.outs})
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
                location,
                style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              Column(
                children: [
                  Text(
                    "$ins Ins",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    "$outs Outs",
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
