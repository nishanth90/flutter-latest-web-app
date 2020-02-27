import 'package:flutter/material.dart';
import 'package:rule_engine_ttakeoff/models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vertical_tabs/vertical_tabs.dart';
import 'package:rule_engine_ttakeoff/login/JWTTokenHandler.dart';


class Tab1 extends StatefulWidget{
  _Tab1State createState() => _Tab1State();
}

class _Tab1State extends State<Tab1> with AutomaticKeepAliveClientMixin{

  Future<SharedPreferences> _instance;
  JWTTokenHandler _jwtInstance;
  @override
  void initState(){
      _instance = SharedPreferences.getInstance();
      _jwtInstance = JWTTokenHandler.instance;
      super.initState();
  }

  Future<UserModel> getUser() async{
    String token = await _instance.then((value) => value.getString("token"));
    return _jwtInstance.getUserFromToken(token);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
        FutureBuilder(
          future: getUser(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if(snapshot.connectionState == ConnectionState.done){
            return  Container(color: Colors.orange, child: Text("Token Information:" + snapshot.data.getAccessToken()));
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
         Container(color: Colors.red)
      ]
    ));
  }

  @override
  bool get wantKeepAlive => true;
}
