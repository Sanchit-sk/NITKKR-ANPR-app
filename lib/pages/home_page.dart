import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nit_anpr_app/data_repo.dart';
import 'package:nit_anpr_app/models/location_info.dart';
import 'package:nit_anpr_app/models/plate_info.dart';
import 'package:nit_anpr_app/providers/plates_data_provider.dart';
import 'package:nit_anpr_app/sample_data.dart';
import 'package:nit_anpr_app/widgets/date_picker.dart';
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
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String query = "";
  bool searchbarFocus = false;
  DateTime? startDateTime;
  DateTime? endDateTime;

  @override
  Widget build(BuildContext context) {
    // DataRepository().fetchPlates(startDateTime, endDateTime);

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
                          query = query;
                          setState(() {});
                        },
                        onFocus: () {
                          // print("Focus on");
                          setState(() {
                            searchbarFocus = true;
                          });
                        },
                        onFocusOut: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          setState(() {
                            searchbarFocus = false;
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
                    height: searchbarFocus ? 0 : null,
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              const Text(
                                "From: ",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              MyDatePicker(
                                onDateChanged: (newDateTime) {
                                  setState(() {
                                    startDateTime = newDateTime;
                                    data.fetchPlatesList(
                                        startDateTime, endDateTime);
                                    // print(newDateTime.toString());
                                  });
                                },
                                initDate: startDateTime,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              const Text(
                                "To: ",
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                              MyDatePicker(
                                onDateChanged: (newDateTime) {
                                  setState(() {
                                    endDateTime = newDateTime;
                                    data.fetchPlatesList(
                                        startDateTime, endDateTime);
                                    // print(newDateTime.toString());
                                  });
                                },
                                initDate: endDateTime,
                              ),
                            ],
                          ),
                        ],
                      ),
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
                  if (data.getFilteredPlates(query).isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      itemBuilder: (context, pos) => PlateCard(
                        plate: data.getFilteredPlates(query)[pos],
                      ),
                      itemCount: data.getFilteredPlates(query).length,
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
