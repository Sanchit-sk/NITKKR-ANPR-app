import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:nit_anpr_app/models/plate_info.dart';
import 'package:nit_anpr_app/storage_handler.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class PlateDetailsPage extends StatelessWidget {
  final PlateInfo plateInfo;
  const PlateDetailsPage({Key? key, required this.plateInfo}) : super(key: key);

  List<int> makePdf(String text) {
    PdfDocument doc = PdfDocument();
    doc.pages
        .add()
        .graphics
        .drawString(text, PdfStandardFont(PdfFontFamily.helvetica, 18));

    List<int> pdfFile = doc.save();
    doc.dispose();
    return pdfFile;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Vehicle activity",
              style: TextStyle(
                fontSize: 24,
              )),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          shadowColor: Colors.white,
        ),
        body: Center(
          child: Card(
              elevation: 10,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      plateInfo.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          List<int> pdfData = makePdf(plateInfo.toString());
                          String filePath = await StorageHandler.saveFile(
                              pdfData, plateInfo.plateText);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "PDF successfully downloaded at $filePath")));
                          print(filePath);
                        },
                        child: const Text("Download PDF"))
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
