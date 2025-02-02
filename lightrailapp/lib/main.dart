import 'package:flutter/material.dart';
import 'package:lightrailapp/helper/station.dart';
import 'package:lightrailapp/homePage.dart';
import 'package:lightrailapp/carPage.dart';
import 'helper/constants.dart';
import 'package:lightrailapp/listPage.dart';
import 'helper/station.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  final routes = <String, WidgetBuilder>{
    listPageTag: (context) => listPage(),
    homePageTag: (context) => homePage(),
  };

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      theme: ThemeData(
        primaryColor: appDarkGreyColor,
      ),
      home: homePage(),
      routes: routes,
    );
  }
}
