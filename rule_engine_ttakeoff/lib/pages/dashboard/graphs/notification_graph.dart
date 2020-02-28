import 'dart:math';

import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rule_engine_ttakeoff/bloc/login/AuthenticationBloc.dart';
import 'package:rule_engine_ttakeoff/pages/rules/Drawer.dart';

class NotificationGraphs extends StatefulWidget{
  @override
  _NotificationGraphState createState() => _NotificationGraphState();
}

class _NotificationGraphState extends State<NotificationGraphs> {
  @override
  Widget build(BuildContext context) {
    List<charts.Series> seriesList = _createSampleData();
    bool animate = true;
    return Scaffold(
      drawer: CustomDrawer(BlocProvider.of<AuthenticationBloc>(context)),
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(
          "Notification Monitoring Dashboard",
          style: TextStyle(fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: MediaQuery.of(context).size.height * 0.30,
                  child: charts.PieChart(seriesList,
                      animate: animate,
                      // Configure the width of the pie slices to 30px. The remaining space in
                      // the chart will be left as a hole in the center. Adjust the start
                      // angle and the arc length of the pie so it resembles a gauge.
                      defaultRenderer: new charts.ArcRendererConfig(
                          arcWidth: 30,
                          startAngle: 4 / 5 * pi,
                          arcLength: 7 / 5 * pi)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: MediaQuery.of(context).size.height * 0.30,
                  child: charts.PieChart(seriesList,
                      animate: animate,
                      // Configure the width of the pie slices to 30px. The remaining space in
                      // the chart will be left as a hole in the center. Adjust the start
                      // angle and the arc length of the pie so it resembles a gauge.
                      defaultRenderer: new charts.ArcRendererConfig(
                          arcWidth: 30,
                          startAngle: 4 / 5 * pi,
                          arcLength: 7 / 5 * pi)),
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: MediaQuery.of(context).size.height * 0.30,
                  child: charts.PieChart(seriesList,
                      animate: animate,

                      // Configure the width of the pie slices to 30px. The remaining space in
                      // the chart will be left as a hole in the center. Adjust the start
                      // angle and the arc length of the pie so it resembles a gauge.
                      defaultRenderer: new charts.ArcRendererConfig(
                          arcWidth: 30,
                          startAngle: 4 / 5 * pi,
                          arcLength: 7 / 5 * pi)),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.30,
                  height: MediaQuery.of(context).size.height * 0.30,
                  child: charts.PieChart(seriesList,
                      animate: animate,
                      // Configure the width of the pie slices to 30px. The remaining space in
                      // the chart will be left as a hole in the center. Adjust the start
                      // angle and the arc length of the pie so it resembles a gauge.
                      defaultRenderer: new charts.ArcRendererConfig(
                          arcWidth: 30,
                          startAngle: 4 / 5 * pi,
                          arcLength: 7 / 5 * pi)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<GaugeSegment, String>> _createSampleData() {
    final data = [
      new GaugeSegment('Low', 75),
      new GaugeSegment('Acceptable', 100),
      new GaugeSegment('High', 50),
      new GaugeSegment('Highly Unusual', 5),
    ];

    return [
      new charts.Series<GaugeSegment, String>(
        id: 'Segments',
        displayName: "Trip Notifications",
        domainFn: (GaugeSegment segment, _) => segment.segment,
        measureFn: (GaugeSegment segment, _) => segment.size,
        data: data,
      )
    ];
  }
}

/// Sample data type.
class GaugeSegment {
  final String segment;
  final int size;

  GaugeSegment(this.segment, this.size);
}
