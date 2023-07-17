import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'helper/constants.dart';
import 'helper/station.dart';
import 'homePage.dart';
import 'listPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class carPage extends StatefulWidget {
  const carPage({super.key, required this.station});

  // Declare a field that holds the Todo.
  final Station station;

  @override
  _carPageState createState() {
    return _carPageState();
  }
}

class _carPageState extends State<carPage> {
  void getJson() async {
    var url = Uri.parse(
        "https://rt.data.gov.hk/v1/transport/mtr/lrt/getSchedule?station_id=" +
            widget.station.index);
    http.Response response = await http.get(url);
    print(jsonDecode(response.body)['platform_list'][0]);
  }

  @override
  Widget build(BuildContext context) {
    getJson();
    return Scaffold(
        appBar: AppBar(
      title: Text(widget.station.NameChi),
    ));
  }
}
