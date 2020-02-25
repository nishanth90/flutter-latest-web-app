import 'package:flutter/foundation.dart';
import 'package:rule_engine_ttakeoff/shared_preference/SharedPreferenceUtil.dart';
import 'package:rule_engine_ttakeoff/util/LoginUtils.dart';

class UserRepository {
  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    return LoginUtils().login(username, password).then((value) => value.getToken().accessToken);
  }

  Future<void> deleteToken() async {
    /// delete from keystore/keychain
    StorageUtil.deleteToken("token");
    return;
  }

  Future<void> persistToken(String token) async {
    /// write to keystore/keychain
    StorageUtil.putString("token", token);
    return;
  }

  Future<bool> hasToken() async {
    /// read from keystore/keychain
    await Future.delayed(Duration(seconds: 1));
    return false;
  }
}
