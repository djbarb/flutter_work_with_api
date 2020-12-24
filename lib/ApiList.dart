import 'package:flutter/material.dart';
import 'package:flutter_work_with_api/ApiData.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ApiListState();
  }
}

class ApiListState extends State<ApiList> {
  List<ApiData> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api test Tracker'),
      ),
      body: Container(
          child: ListView(
        children: _buildList(),
      )),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () => _loadApi(),
      ),
    );
  }

  _loadApi() async {
    final response =
        await http.get('https://api.coincap.io/v2/assets?limit=10');

    if (response.statusCode == 200) {
      var allData = (json.decode(response.body) as Map)['data'];
      var ApiDataList = List<ApiData>();
      allData.forEach((val) {
        var record = ApiData(
            name: val['name'],
            symbol: val['symbol'],
            price: double.parse(val['priceUsd']),
            rank: int.parse(val['rank']));

        ApiDataList.add(record);
      });

      setState(() {
        data = ApiDataList;
      });
    }
  }

  List<Widget> _buildList() {
    return data
        .map((ApiData f) => ListTile(
              subtitle: Text(f.symbol),
              title: Text(f.name),
              leading: CircleAvatar(child: Text(f.rank.toString())),
              trailing: Text('${f.price.toStringAsFixed(2)}'),
            ))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _loadApi();
  }
}
