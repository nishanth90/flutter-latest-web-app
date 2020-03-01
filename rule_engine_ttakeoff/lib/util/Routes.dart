import 'package:flutter/material.dart';
import 'package:rule_engine_ttakeoff/login/UserRepository.dart';
import 'package:rule_engine_ttakeoff/pages/LoginPage.dart';
import 'package:rule_engine_ttakeoff/pages/RulesPage.dart';

class RouteGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;
    final userRepository = UserRepository();

    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => LoginPage(userRepository: userRepository));
      case '/rules':
        // Validation of correct data type
        if (args is String) {
          return MaterialPageRoute(
            builder: (_) => RulesPage(
                  data: args,
                ),
          );
        }
        // If args is not of the correct type, return an error page.
        // You can also throw an exception while in development.
        return _errorRoute();
      case '/notification':
         return MaterialPageRoute(builder: (_) => LoginPage());
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}