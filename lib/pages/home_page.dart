import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:nit_anpr_app/data_repo.dart';
import 'package:nit_anpr_app/firebase_auth.dart';
import 'package:nit_anpr_app/models/location_info.dart';
import 'package:nit_anpr_app/models/plate_info.dart';
import 'package:nit_anpr_app/pages/login_page.dart';
import 'package:nit_anpr_app/pages/plate_details_page.dart';
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
          child: FutureBuilder<List<PlateInfo>>(
              future: Provider.of<PlatesDataProvider>(context, listen: false)
                  .fetchPlatesList(startDateTime, endDateTime),
              builder: ((context, snapshot) {
                print(query);
                return (snapshot.connectionState != ConnectionState.waiting)
                    ? SafeArea(
                        child: CustomScrollView(
                          physics: const BouncingScrollPhysics(),
                          slivers: [
                            SliverAppBar(
                              backgroundColor: Colors.white,
                              title: const Text(
                                "NITKKR Campus",
                                // textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.deepPurpleAccent,
                                ),
                              ),
                              actions: [
                                IconButton(
                                    onPressed: () async {
                                      await FireAuth.signOut();
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage()),
                                          (route) => false);
                                    },
                                    icon: const Icon(
                                      Icons.logout,
                                      color: Colors.red,
                                    ))
                              ],
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
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: MySearchBar(
                                          hint: "Search for license plate",
                                          initText: query,
                                          onSearch: (query) {
                                            this.query = query;
                                            // setState(() {});
                                          },
                                          // onFocus: () {
                                          //   // print("Focus on");
                                          //   setState(() {
                                          //     searchbarFocus = true;
                                          //   });
                                          // },
                                          // onFocusOut: () {
                                          //   FocusManager.instance.primaryFocus
                                          //       ?.unfocus();
                                          //   setState(() {
                                          //     searchbarFocus = false;
                                          //   });
                                          // },
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {});
                                          },
                                          icon: const Icon(Icons.search)),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              //Nothing here
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.refresh,
                                            // color: Colors.grey,
                                          ))
                                    ],
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
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
                                              startDateTime = newDateTime;
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
                                                endDateTime = newDateTime;
                                            },
                                            initDate: endDateTime,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  MyPieChart(chartData: {
                                    "Ins": data
                                        .getTotalIns(
                                            data.getFilteredPlates(query))
                                        .toDouble(),
                                    "Outs": data
                                        .getTotalOuts(
                                            data.getFilteredPlates(query))
                                        .toDouble()
                                  }),
                                  Container(
                                    height: 150,
                                    alignment: Alignment.topLeft,
                                    child: ListView.builder(
                                        physics: const ClampingScrollPhysics(),
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, pos) {
                                          List<LocationInfo> locationDataList =
                                              data
                                                  .getLocationData(data
                                                      .getFilteredPlates(query))
                                                  .values
                                                  .toList();
                                          // print(data.locationData.length);
                                          return LocationCard(
                                              colorIndex: pos,
                                              locationInfo:
                                                  locationDataList[pos]);
                                        },
                                        itemCount: data
                                            .getLocationData(
                                                data.getFilteredPlates(query))
                                            .length),
                                  ),
                                ]),
                              ),
                              if (data.getFilteredPlates(query).isNotEmpty)
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemBuilder: (context, pos) => InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PlateDetailsPage(
                                                      plateInfo: data
                                                          .getFilteredPlates(
                                                              query)[pos])));
                                    },
                                    child: PlateCard(
                                      plate: data.getFilteredPlates(query)[pos],
                                    ),
                                  ),
                                  itemCount:
                                      data.getFilteredPlates(query).length,
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
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Fetching plates data..."),
                          ),
                        ],
                      );
              })),
        );
      },
    );
  }
}
