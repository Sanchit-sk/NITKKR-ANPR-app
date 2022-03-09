import 'package:flutter/material.dart';
import 'package:nit_anpr_app/models/plate_info.dart';
import 'package:nit_anpr_app/widgets/plate_card.dart';

class MySearchBar extends StatelessWidget {
  Icon? suffixIcon;
  String hint;
  Function(String val) onSearch;
  MySearchBar(
      {Key? key, this.hint = "", this.suffixIcon, required this.onSearch})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        hintText: hint,
        suffixIcon: suffixIcon,
      ),
      onChanged: (value) => onSearch(value),
    );
  }
}

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
