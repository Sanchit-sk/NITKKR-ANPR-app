import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nit_anpr_app/models/plate_info.dart';
import 'package:nit_anpr_app/sample_data.dart';
import 'package:nit_anpr_app/widgets/location_card.dart';
import 'package:nit_anpr_app/widgets/my_pie_chart.dart';
import 'package:nit_anpr_app/widgets/my_search_bar.dart';
import 'package:nit_anpr_app/widgets/plate_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';

class HomePage extends StatefulWidget {
  List<PlateInfo> plates;
  String query = "";
  HomePage({Key? key, required this.plates}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<PlateInfo> filteredPlates = widget.plates
        .where(
            (element) => element.plateText.contains(widget.query.toUpperCase()))
        .toList();

    return Material(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              child: Text("NIT Campus",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.leagueScript(
                      textStyle: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ))),
            ),
            MyPieChart(chartData: pieChartData),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  LocationCard(location: "Gate1", ins: 150, outs: 100),
                  LocationCard(
                    location: "Gate1",
                    ins: 150,
                    outs: 100,
                    cardColor: Colors.yellow,
                  ),
                  LocationCard(
                    location: "Gate1",
                    ins: 150,
                    outs: 100,
                    cardColor: Colors.pink,
                  ),
                ],
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: MySearchBar(
                    hint: "Search for license plate",
                    suffixIcon: const Icon(Icons.search),
                    onSearch: (query) {
                      widget.query = query;
                      // print("Search query changed: ${widget.query}");
                      setState(() {});
                    })),
            // PlateCard(plate: demoPlate),
            // PlateCard(plate: demoPlate)
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, pos) => PlateCard(
                  plate: filteredPlates[pos],
                ),
                itemCount: filteredPlates.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
