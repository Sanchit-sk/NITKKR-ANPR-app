import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MyPieChart extends StatefulWidget {
  Map<String, double> chartData;
  int touchedIndex = -1;
  static const List<Color> sectionColorOptions = [
    Colors.blueAccent,
    Colors.orangeAccent,
    Colors.green,
    Colors.purpleAccent,
    Colors.pink,
    Colors.yellowAccent,
  ];

  MyPieChart({Key? key, required this.chartData}) : super(key: key);

  @override
  State<MyPieChart> createState() => _MyPieChartState();
}

class _MyPieChartState extends State<MyPieChart> {
  Color getSectionColor(int index) {
    int options = MyPieChart.sectionColorOptions.length;
    index = index % options;
    return MyPieChart.sectionColorOptions[index];
  }

  List<PieChartSectionData> getChartSections() {
    List<PieChartSectionData> sections = [];
    int sectionCount = 0;
    widget.chartData.forEach((key, value) {
      bool isTouched = widget.touchedIndex == sectionCount;
      sections.add(PieChartSectionData(
          color: getSectionColor(sectionCount),
          radius: isTouched ? 80 : 50,
          title: isTouched ? value.toInt().toString() : key,
          value: value,
          titleStyle: TextStyle(
            fontSize: isTouched ? 27 : 23,
            color: Colors.white,
          )));

      sectionCount++;
    });

    return sections;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 250,
        width: 250,
        child: PieChart(PieChartData(
            sections: getChartSections(),
            sectionsSpace: 5,
            centerSpaceRadius: 50,
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    widget.touchedIndex = -1;
                  } else {
                    if (pieTouchResponse.touchedSection != null) {
                      widget.touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    }
                  }
                });
              },
            ))),
      ),
    );
  }
}
