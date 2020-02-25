import 'package:flutter/material.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 90,
                ),
                Container(
                  child: Text(
                    "TTakeoff Rule Engine is loading....",
                    style: TextStyle(color: Colors.blue, fontSize: 30),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Container(
                  width: MediaQuery.of(context).size.width*0.2,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
      ),
    );
  }
}
