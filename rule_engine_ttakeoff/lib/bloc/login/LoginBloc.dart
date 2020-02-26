import 'dart:async';

import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:rule_engine_ttakeoff/Login/UserRepository.dart';
import 'package:rule_engine_ttakeoff/bloc/login/AuthenticationBloc.dart';
import 'package:rule_engine_ttakeoff/bloc/login/AuthenticationEvents.dart';
import 'package:rule_engine_ttakeoff/bloc/login/LoginEvent.dart';
import 'package:rule_engine_ttakeoff/bloc/login/LoginState.dart';

import 'AuthenticationEvents.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null);

  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await userRepository.authenticate(
          username: event.username,
          password: event.password,
        );
        if(token != '') {
          authenticationBloc.add(LoggedIn(token: token));
          yield LoginInitial();
        } else {
        authenticationBloc.add(LoggedOut());
        yield LoginFailure(error: 'Login Failed. Please Try again');
        }

      } catch (error) {
        authenticationBloc.add(LoggedOut());
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
