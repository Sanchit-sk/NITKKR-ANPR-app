import 'package:flutter/material.dart';
import 'package:nit_anpr_app/data_repo.dart';
import 'package:nit_anpr_app/firebase_auth.dart';
import 'package:nit_anpr_app/pages/home_page.dart';
import 'package:nit_anpr_app/pages/login_page.dart';
import 'package:nit_anpr_app/providers/plates_data_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import './sample_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await DataRepository().testFirestore();
  runApp(ChangeNotifierProvider(
      create: (context) => PlatesDataProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Provider.of<PlatesDataProvider>(context, listen: false)
        .fetchPlatesList(DateTime.now(), DateTime.now());
    //Testing firestore
    //TODO: Remove later
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: FireAuth.getUser() == null ? LoginPage() : HomePage(),
    );
  }
}
