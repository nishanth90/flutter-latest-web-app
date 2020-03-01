import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rule_engine_ttakeoff/login/LoginIndicator.dart';
import 'package:rule_engine_ttakeoff/login/UserRepository.dart';
import 'package:rule_engine_ttakeoff/bloc/login/AuthenticationBloc.dart';
import 'package:rule_engine_ttakeoff/bloc/login/AuthenticationEvents.dart';
import 'package:rule_engine_ttakeoff/bloc/login/AuthenticationStates.dart';
import 'package:rule_engine_ttakeoff/pages/LoginPage.dart';
import 'package:rule_engine_ttakeoff/pages/RulesPage.dart';
import 'package:rule_engine_ttakeoff/pages/WelcomePage.dart';
import 'package:rule_engine_ttakeoff/pages/dashboard/graphs/notification_graph.dart';
import 'package:rule_engine_ttakeoff/util/Routes.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final userRepository = UserRepository();
  runApp(MyApp(userRepository: userRepository));
}

class MyApp extends StatefulWidget {
  final UserRepository userRepository;

  MyApp({Key key, @required this.userRepository}) : super(key: key);

  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  AuthenticationBloc _authenticationBloc;
  UserRepository get _userRepository => widget.userRepository;

  @override
  void initState() {
    super.initState();
    _authenticationBloc = AuthenticationBloc(userRepository: _userRepository);
    _authenticationBloc.add(AppStarted());
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) {
        return _authenticationBloc..add(AppStarted());
      },
      child: MaterialApp(
        title: 'TTakeoff Rule Engine',
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        theme: ThemeData.light(),
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationUninitialized) {
              return WelcomePage();
            } else if (state is AuthenticationAuthenticated) {
              return RulesPage(
                data: "Test",
              );
            } else if (state is AuthenticationUnauthenticated) {
              return LoginPage(userRepository: widget.userRepository);
            } else if (state is AuthenticationLoading) {
              return LoadingIndicator();
            } else if (state is Navigation) {
              return NotificationGraphs(_authenticationBloc);
            } else if (state is RulesPageNavigation) {
              print("Inside Rules Page event call");
              return RulesPage(
                data: "Test",
              );
            } else
              return WelcomePage();
          },
        ),
      ),
    );
  }
}
