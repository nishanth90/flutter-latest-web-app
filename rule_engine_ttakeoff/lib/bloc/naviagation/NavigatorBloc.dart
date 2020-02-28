import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:rule_engine_ttakeoff/bloc/naviagation/NavigationEvent.dart';

class NavigatorBloc extends Bloc<NotificationDashBoardNavEvent, dynamic> {
  final GlobalKey<NavigatorState> navigatorKey;
  NavigatorBloc({this.navigatorKey});

  @override
  dynamic get initialState => 0;

  @override
  Stream<dynamic> mapEventToState(NotificationDashBoardNavEvent event) async* {
    if (event is NotificationDashBoardNavEvent) {
      navigatorKey.currentState.pushNamed('/notificationDashboard');
    }
  }
}
