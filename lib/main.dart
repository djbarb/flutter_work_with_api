import 'package:flutter/material.dart';
import 'package:flutter_work_with_api/ApiList.dart';

void main() => runApp(ApiTracker());

class ApiTracker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Api test Tracker',
        theme: ThemeData(primarySwatch: Colors.green),
        home: ApiList());
  }
}
