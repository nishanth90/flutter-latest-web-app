import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rule_engine_ttakeoff/bloc/login/AuthenticationBloc.dart';
import 'package:rule_engine_ttakeoff/bloc/login/AuthenticationEvents.dart';
import 'package:rule_engine_ttakeoff/login/JWTTokenHandler.dart';
import 'package:rule_engine_ttakeoff/models/UserModel.dart';
import 'package:rule_engine_ttakeoff/pages/rules/Drawer.dart';
import 'package:rule_engine_ttakeoff/pages/rules/tabs/Tab1.dart';
import 'package:rule_engine_ttakeoff/pages/rules/tabs/Tab2.dart';
import 'package:rule_engine_ttakeoff/pages/rules/tabs/Tab3.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RulesPage extends StatefulWidget {
  final String data;
  RulesPage({this.data});
  @override
  RulesPageState createState() => RulesPageState();
}

class RulesPageState extends State<RulesPage> {
  Future<SharedPreferences> _instance;
  JWTTokenHandler _jwtInstance;

  @override
  void initState() {
    _instance = SharedPreferences.getInstance();
    _jwtInstance = JWTTokenHandler.instance;
    super.initState();
  }

  Future<UserModel> getUser() async {
    String token = await _instance.then((value) => value.getString("token"));
    return _jwtInstance.getUserFromToken(token);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 7,
      child: Scaffold(
        drawer: CustomDrawer(BlocProvider.of<AuthenticationBloc>(context)),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(93, 195, 232, 0.5),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.power_settings_new),
                onPressed: () {
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                })
          ],
          title: Text("Rule Categories"),
          bottom: TabBar(
            labelColor: Colors.redAccent,
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Colors.orange),
            tabs: <Widget>[
              Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Tab 1",
                      style: TextStyle(color: Colors.indigo),
                    ),
                  ),
                  icon: Icon(
                    Icons.airport_shuttle,
                    color: Colors.indigo,
                  )),
              Tab(
                child: Align(alignment: Alignment.center, child: Text("Tab 2")),
                icon: Icon(Icons.local_offer),
              ),
              Tab(
                child: Align(alignment: Alignment.center, child: Text("Tab 3")),
                icon: Icon(Icons.publish),
              ),
              Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Tab 4",
                      style: TextStyle(color: Colors.indigo),
                    ),
                  ),
                  icon: Icon(
                    Icons.airport_shuttle,
                    color: Colors.indigo,
                  )),
              Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Tab 5",
                      style: TextStyle(color: Colors.indigo),
                    ),
                  ),
                  icon: Icon(
                    Icons.airport_shuttle,
                    color: Colors.indigo,
                  )),
              Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Tab 6",
                      style: TextStyle(color: Colors.indigo),
                    ),
                  ),
                  icon: Icon(
                    Icons.airport_shuttle,
                    color: Colors.indigo,
                  )),
              Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Tab 7",
                      style: TextStyle(color: Colors.indigo),
                    ),
                  ),
                  icon: Icon(
                    Icons.airport_shuttle,
                    color: Colors.indigo,
                  )),
            ],
          ),
        ),
        body: TabBarView(children: [
          Tab1(),
          Tab2(),
          Tab3(),
          Tab3(),
          Tab3(),
          Tab3(),
          Tab3(),
        ]),
      ),
    );
  }
}
