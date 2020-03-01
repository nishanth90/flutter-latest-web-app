import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rule_engine_ttakeoff/bloc/login/AuthenticationBloc.dart';
import 'package:rule_engine_ttakeoff/bloc/login/AuthenticationEvents.dart';
import 'package:rule_engine_ttakeoff/login/JWTTokenHandler.dart';
import 'package:rule_engine_ttakeoff/models/UserModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomDrawer extends StatefulWidget {
  final AuthenticationBloc authBloc;
  CustomDrawer(this.authBloc);
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
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
    final AuthenticationBloc _authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return BlocProvider(
      create: (context) {
        return widget.authBloc;
      },
      child: Drawer(
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: getUser(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: Color(0xff00BCD4)),
                    accountName: Text(
                      snapshot.data.getUserName(),
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    accountEmail: Text(snapshot.data.getEmailId(),
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold)),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Text(
                        "T",
                        style: TextStyle(fontSize: 40),
                      ),
                    ),
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
            Column(
              children: <Widget>[
                ListTile(
                  title: Text("Notification Dashboard",
                      style: TextStyle(fontSize: 16)),
                  trailing: Icon(
                    Icons.dashboard,
                    size: 30.0,
                    color: Colors.blue,
                  ),
                  selected: true,
                  onTap: () {
                    Navigator.of(context).pop();
                    //Navigator.push(
                    //    context,
                    //    MaterialPageRoute(
                    //        builder: (_) =>
                    //          NotificationGraphs(widget.authBloc)));
                    BlocProvider.of<AuthenticationBloc>(context)
                        .add(NotificationDashBoardNavEvent());
                  },
                ),
                ListTile(
                  title: Text("Rules View", style: TextStyle(fontSize: 16)),
                  trailing: Icon(
                    Icons.public,
                    size: 30.0,
                    color: Colors.teal,
                  ),
                  selected: true,
                  onTap: () {
                    SchedulerBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).pop();
                      _authenticationBloc.add(RulesPageNavEvent());
                    });
                  },
                ),
                ListTile(
                    title: Text("Logout", style: TextStyle(fontSize: 16)),
                    trailing: Icon(
                      Icons.power_settings_new,
                      size: 30.0,
                      color: Colors.red,
                    ),
                    selected: true,
                    onTap: () {
                      SchedulerBinding.instance.addPostFrameCallback((_) {
                        Navigator.of(context).pop();
                        _authenticationBloc.add(LoggedOut());
                      });
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
