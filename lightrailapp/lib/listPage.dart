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
  List<List<dynamic>> _listData = [];

  void _loadCSV() async {
    final _rawData = await rootBundle.loadString("assets/data/NewStation.csv");
    _listData = const CsvToListConverter().convert(_rawData);

    _listData.removeAt(0);
    _data = _listData;
  }

  @override
  void initState() {
    super.initState();
    allResults();
  }

  void filterSearchResults(String query) {
    final duplicateItems = _data;

    if(query.isEmpty){
      _data = _listData;
    }else{
      _data = duplicateItems.where((item) => item[3].contains(query.toLowerCase())).toList();
    }
    setState(() {
      _data;
    });
  }

  void allResults() async{
    await Future.delayed(Duration(seconds: 0));
    setState(() {
      _data;
    });
  }



  @override
  Widget build(BuildContext context) {
    TextEditingController editingController = TextEditingController();
    _loadCSV();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Station"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  filterSearchResults(value);
                },
                keyboardType: TextInputType.text,
                autofocus: false,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _data.length,
                itemBuilder: (context, index) {
                  var stationIndex = _data[index][0].toString();
                  var stationID = _data[index][1].toString();
                  var engName = _data[index][2].toString();
                  var chiName = _data[index][3].toString();
                  return Card(
                    margin: const EdgeInsets.all(3),
                    child: ListTile(
                        //leading: Text(_data[index][1].toString()),
                        title: Text(chiName),
                        subtitle: Text(engName),
                        dense: true,
                        trailing: const Icon(Icons.keyboard_arrow_right),
                        onTap: () {
                          final station = new Station(stationIndex,  stationID, engName, chiName);
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
            ),
          ],
        ),
      ),
    );
  }
}

      /*
      ListView.builder(
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
      ),*/
