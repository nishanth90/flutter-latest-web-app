import 'package:flutter/material.dart';
import 'package:rule_engine_ttakeoff/login/JWTTokenHandler.dart';
import 'package:vertical_tabs/vertical_tabs.dart';

import '../../../shared_preference/SharedPreferenceUtil.dart';

class Tab1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(60.0),
      elevation: 1.0,
      child: VerticalTabs(tabs: <Tab>[
        Tab(
          text: "Tab v1",
        ),
        Tab(
          text: "Tab v2",
        )
      ], contents: <Widget>[
        Container(
          color: Colors.orange,
          child: Text("Token Information: " +
              JWTTokenHandler.getInstance().then((value) => value.getUserFromToken(StorageUtil.getString("token")))
                  .toString()),
        ),
        Container(color: Colors.red)
      ]),
    );
  }
}
