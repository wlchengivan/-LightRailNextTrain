import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lightrailapp/carPage.dart';
import 'helper/constants.dart';
import 'homePage.dart';
import 'helper/station.dart';

class listPage extends StatefulWidget {
  @override
  _listPageState createState() {
    return _listPageState();
  }
}

class _listPageState extends State<listPage> {
  List<List<dynamic>> _data = [];
  

  void _loadCSV() async {
    final _rawData = await rootBundle.loadString("assets/data/NewStation.csv");
    List<List<dynamic>> _listData =
        const CsvToListConverter().convert(_rawData);
    setState(() {
      _listData.removeAt(0);
      _data = _listData;
      }
    );
  }



  @override
  Widget build(BuildContext context) {
    _loadCSV();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Station"),
      ),
      body: ListView.builder(
        itemCount: _data.length,
        itemBuilder: (_, index) {
          return Card(
            margin: const EdgeInsets.all(3),
            child: ListTile(
                leading: Text(_data[index][1].toString()),
                title: Text(_data[index][3].toString()),
                subtitle: Text(_data[index][2].toString()),
                dense: true,
                trailing: const Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  final station = new Station(_data[index][0].toString(),  _data[index][1].toString(), _data[index][2].toString(), _data[index][3].toString());
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => carPage(station: station),
                    ),
                  );
                }),
          );
        },
      ),
      // Display the contents from the CSV file
    );
  }

  
}
