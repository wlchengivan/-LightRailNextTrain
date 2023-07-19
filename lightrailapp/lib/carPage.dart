import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'helper/constants.dart';
import 'helper/station.dart';
import 'homePage.dart';
import 'listPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/src/widgets/framework.dart';

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
  Future<String> getJson() async {
    var url = Uri.parse(
        "https://rt.data.gov.hk/v1/transport/mtr/lrt/getSchedule?station_id=" +
            widget.station.StationID);
    http.Response response = await http.get(url);

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)['status'] == 1) {
        return response.body;
      } else {
        return "暫停服務";
      }
    } else {
      return "暫停服務";
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
        style: Theme.of(context).textTheme.displayMedium!,
        textAlign: TextAlign.center,
        child: FutureBuilder<String>(
            future: getJson(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              List<Widget> children;
              if (snapshot.hasData) {
                var platformList = jsonDecode(snapshot.data.toString());
                String datail = "";
                for (int x = 0; x < platformList['platform_list'].length; x++) {
                  datail += (platformList['platform_list'][x]['platform_id'].toString() + "號月台\n");
                  for (int y = 0; y < platformList['platform_list'][x]['route_list'].length; y++){
                    var carList = platformList['platform_list'][x]['route_list'][y];
                    String to = " 往 ";
                    if(carList['dest_ch'].length > 4){
                      to = " ";
                    }

                    if(carList['time_ch'] == "即將抵達" && carList['time_ch'] == "正在離開"){
                      datail += ("路線 " + carList['route_no'] + to + carList['dest_ch'] + " " + carList['time_ch'] + "\n");
                    }else if(carList['time_ch'] =="-"){
                      datail += ("路線 " + carList['route_no'] + to + carList['dest_ch'] + " 已到站\n");
                    }else
                    {
                      datail += ("路線 " + carList['route_no'] + to + carList['dest_ch'] + " 將於 " + carList['time_ch'] + " 到達\n");
                    }
                  }
                }
                return Scaffold(
                  appBar: AppBar(
                    title: Text(widget.station.NameChi),
                  ),
                  body: Center(
                    child: Text(
                      datail,
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    
                  ),
                  floatingActionButton: FloatingActionButton(
                    onPressed: (){
                      setState(() {});
                      
                    },
                    child: const Icon(Icons.refresh),
                  ),
                );
              } else if (snapshot.hasError) {
                children = <Widget>[
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text('Error: ${snapshot.error}'),
                  ),
                ];
              } else {
                children = const <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 16),
                    child: Text('連接中'),
                  ),
                ];
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: children,
                ),
              );
            }
          )
        );
  }
}
