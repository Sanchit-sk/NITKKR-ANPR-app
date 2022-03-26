import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nit_anpr_app/models/location_info.dart';
import 'package:nit_anpr_app/models/plate_info.dart';
import 'package:nit_anpr_app/providers/plates_data_provider.dart';
import 'package:nit_anpr_app/sample_data.dart';
import 'package:nit_anpr_app/widgets/location_card.dart';
import 'package:nit_anpr_app/widgets/my_pie_chart.dart';
import 'package:nit_anpr_app/widgets/my_search_bar.dart';
import 'package:nit_anpr_app/widgets/plate_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  String query = "";
  bool searchbarFocus = false;

  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<PlatesDataProvider>(
      builder: (context, data, child) {
        return Material(
          child: SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                const SliverAppBar(
                  backgroundColor: Colors.white,
                  title: Text(
                    "NITKKR Campus",
                    // textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurpleAccent,
                    ),
                  ),
                ),
                // SliverAppBar(
                //   backgroundColor: Colors.white,
                //   expandedHeight: 200,
                //   flexibleSpace: Image.asset("./assets/images/campus.png",
                //       fit: BoxFit.fitHeight, alignment: Alignment.center),
                // ),
                SliverAppBar(
                  backgroundColor: Colors.white,
                  flexibleSpace: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      child: MySearchBar(
                        hint: "Search for license plate",
                        suffixIcon: const Icon(Icons.search),
                        onSearch: (query) {
                          widget.query = query;
                          setState(() {});
                        },
                        onFocus: () {
                          print("Focus on");
                          setState(() {
                            widget.searchbarFocus = true;
                          });
                        },
                        onFocusOut: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          setState(() {
                            widget.searchbarFocus = false;
                          });
                        },
                      )),
                  pinned: true,
                ),
                SliverList(
                    delegate: SliverChildListDelegate(<Widget>[
                  //The contents under this container will hide
                  //When the user is typing something in the searchbar
                  Container(
                    height: widget.searchbarFocus ? 0 : null,
                    child: Column(children: [
                      MyPieChart(chartData: {
                        "Ins": data.totalIns.toDouble(),
                        "Outs": data.totalOuts.toDouble()
                      }),
                      SizedBox(
                        height: 150,
                        child: ListView.builder(
                            physics: const ClampingScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, pos) {
                              List<LocationInfo> locationDataList =
                                  data.locationData.values.toList();
                              // print(data.locationData.length);
                              return LocationCard(
                                  colorIndex: pos,
                                  locationInfo: locationDataList[pos]);
                            },
                            itemCount: data.locationData.length),
                      ),
                    ]),
                  ),
                  if (data.getFilteredPlates(widget.query).isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, pos) => PlateCard(
                        plate: data.getFilteredPlates(widget.query)[pos],
                      ),
                      itemCount: data.getFilteredPlates(widget.query).length,
                    )
                  else
                    const Center(
                      child: Text(
                        "Nothing to show",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                ]))
              ],
            ),
          ),
        );
      },
    );
  }
}
