import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rule_engine_ttakeoff/Login/LoginModel.dart';
import 'package:rule_engine_ttakeoff/Login/UserRepository.dart';
import 'package:rule_engine_ttakeoff/bloc/login/AuthenticationBloc.dart';
import 'package:rule_engine_ttakeoff/bloc/login/LoginBloc.dart';
import 'package:rule_engine_ttakeoff/pages/LoginForm.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
    final UserRepository userRepository;
  LoginPage({this.userRepository});

}

class _LoginState extends State<LoginPage> {
  String username;
  String password;
  Future<LoginModel> loginModel;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only(top: 60.0, bottom: 60.0, left: 120.0, right: 120.0),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40.0)),
          elevation: 5.0,
          child: Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 3.3,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.lightBlue[600],
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 85.0, right: 50.0, left: 50.0),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 60.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                            child: Text(
                              "TTakeoff Rule Engine",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30.0,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 140.0,
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                            child: Text(
                              "Login to Configure the notification rules",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 50.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                BlocProvider(
                  create: (context) {
                    return LoginBloc(userRepository: widget.userRepository, 
                    authenticationBloc: BlocProvider.of<AuthenticationBloc>(context));
                  },
                    child: Container(
                    padding: EdgeInsets.only(
                        top: 15.0, right: 40.0, left: 150.0, bottom: 10.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                            height: 200,
                            width: 300,
                            child: Image.asset("logo-takeoff.png")),
                        const SizedBox(height: 21.0),

                        //InputField Widget from the widgets folder
                        LoginForm()
                       ,
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginCallback (String username){
      return FutureBuilder<LoginModel>(
        future: loginModel,
        builder: (context, snapshot) {
          print(snapshot.hasData);
          if(snapshot.hasData) {
            Navigator.of(context).pushNamed("/rules", arguments: username);
          } else {
            return Text("Login Error");
          }
          return CircularProgressIndicator();
        },
      );
  }
}
