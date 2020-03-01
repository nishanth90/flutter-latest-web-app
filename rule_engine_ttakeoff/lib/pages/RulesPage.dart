import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rule_engine_ttakeoff/bloc/login/AuthenticationBloc.dart';
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

class RulesPageState extends State<RulesPage> with SingleTickerProviderStateMixin {
 // Future<SharedPreferences> _instance;
//  JWTTokenHandler _jwtInstance;

  @override
  void initState() {
    print("Inside Rules Page");
    //_instance = SharedPreferences.getInstance();
   // _jwtInstance = JWTTokenHandler.instance;
       super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

   @override
 void dispose() {
   _tabController.dispose();
   super.dispose();
 }

 /*  Future<UserModel> getUser() async {
    String token = await _instance.then((value) => value.getString("token"));
    return _jwtInstance.getUserFromToken(token);
  } */
  
  TabController _tabController;

  final List<Tab> myTabs = <Tab>[
              Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "TRIP NOTIFICAITONS",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  icon: Icon(
                    Icons.airplanemode_active,
                  )),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("ADVERTISEMENT NOTIFICATIONS",
                      style: TextStyle(color: Colors.white)),
                ),
                icon: Icon(Icons.local_offer),
              ),
              Tab(
                child: Align(
                    alignment: Alignment.center,
                    child: Text("OFFERS NOTIFICATIONS",
                        style: TextStyle(color: Colors.white))),
                icon: Icon(Icons.album),
              ),
              Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "VENDOR NOTIFICATIONS",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  icon: Icon(
                    Icons.airport_shuttle,
                  )),
            ];

  @override
  Widget build(BuildContext context) {
    print("Inside Scaffold");
    return Scaffold(
        drawer: CustomDrawer(BlocProvider.of<AuthenticationBloc>(context)),
        appBar: AppBar(
          //Color.fromRGBO(93, 195, 232, 0.5)
          backgroundColor: Color(0xff00BCD4),
          centerTitle: true,
          title: Text(
            "RULE CATEGORIES",
            style: TextStyle(fontSize: 40, fontFamily: 'Righteous'),
          ),
          bottom: TabBar(
            labelColor: Colors.redAccent,
            unselectedLabelColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.label,
            controller: _tabController,
            indicator: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                color: Color(0xffFDD835)),
            tabs: myTabs,
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
          Tab1(),
          Tab2(),
          Tab3(),
          Tab3(),
        ]),
      );
  }
}
