import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rule_engine_ttakeoff/bloc/login/LoginBloc.dart';
import 'package:rule_engine_ttakeoff/bloc/login/LoginEvent.dart';
import 'package:rule_engine_ttakeoff/bloc/login/LoginState.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(
        LoginButtonPressed(
          username: _emailController.text,
          password: _passwordController.text,
        ),
      );
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              action: SnackBarAction(label: "RETRY", onPressed: () {}),
              duration: Duration(seconds: 3),
              content: Text(
                '${state.error}',
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.red[300],
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Column(
            children: <Widget>[
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Row(
                    children: <Widget>[
                      Container(
                        width: 80.0,
                        child: Text(
                          "Email",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Color(0xff00BCD4)),
                        ),
                      ),
                      SizedBox(
                        width: 40.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3.7,
                        color: Color(0xff4DD0E1),
                        child: TextField(
                          controller: _emailController,
                          obscureText: false,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff4DD0E1),
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff4DD0E1),
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            hintText: "abc@example.com",
                            fillColor: Color(0xff4DD0E1),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 20.0),
              //email field
              LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return Row(
                    children: <Widget>[
                      Container(
                        width: 80.0,
                        child: Text(
                          "password",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Color(0xff00BCD4)),
                        ),
                      ),
                      SizedBox(
                        width: 40.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3.7,
                        color: Color(0xff4DD0E1),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: true,
                          style: TextStyle(
                            fontSize: 15.0,
                          ),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff4DD0E1),
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xff4DD0E1),
                              ),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            hintText: "Password",
                            fillColor: Color(0xff4DD0E1),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

              SizedBox(height: 70.0),

              Row(
                children: <Widget>[
                  SizedBox(
                    width: 5.0,
                  ),
                  FlatButton(
                    color: Color(0xffFDD835),
                    onPressed:
                        state is! LoginLoading ? _onLoginButtonPressed : null,
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Container(
                    child: state is LoginLoading
                        ? CircularProgressIndicator()
                        : null,
                  ),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}
