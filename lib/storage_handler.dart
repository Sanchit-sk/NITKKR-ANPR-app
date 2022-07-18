import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart' as per;

class StorageHandler {
  static Future<bool> getStoragePermission() async {
    if (await per.Permission.storage.request().isGranted) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String> saveFile(ss_file, filename) async {
    // print(ss_file);

    if (await getStoragePermission()) {
      print("permisson given : )");
      Directory extDirectory = Directory('/storage/emulated/0/Download');
      String path = extDirectory.path;
      String filePath = "$path/${filename}.pdf";
      print(path);
      File file = File(filePath);
      int num = 0;
      while (await file.exists()) {
        filePath = "$path/${filename}" + "_$num.pdf";
        file = File(filePath);
        num++;
      }

      await file.writeAsBytes(ss_file);
      print("file saved completely with path : $filePath");
      return filePath;
    } else {
      print("permisson denied : (");
    }

    return "";
  }
}
