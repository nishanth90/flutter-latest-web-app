import 'package:flutter/material.dart';
import 'package:vertical_tabs/vertical_tabs.dart';

class Tab1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
  return Card(
    margin: EdgeInsets.all(60.0),
    elevation: 1.0,
      child: VerticalTabs(tabs: <Tab>[
        Tab(text: "Tab v1",),
        Tab(text: "Tab v2",)
      ], contents: <Widget> [
        Container(
          color: Colors.orange,
        ),
        Container(
          color: Colors.red
        )
      ]),
      );
  }
  
}