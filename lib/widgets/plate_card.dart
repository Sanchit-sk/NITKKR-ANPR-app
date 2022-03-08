import 'package:flutter/material.dart';
import 'package:nit_anpr_app/models/plate_info.dart';

class PlateCard extends StatelessWidget {
  PlateInfo plate;
  PlateCard({Key? key, required this.plate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Card(
          elevation: 8,
          // shape: Border.all(color: Colors.grey),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      plate.plateText,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26,
                      ),
                    ),
                    Text(
                      plate.activity,
                      style: TextStyle(
                        color: Colors.orange[400],
                        fontSize: 22,
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    plate.timeStamp,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[600],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
