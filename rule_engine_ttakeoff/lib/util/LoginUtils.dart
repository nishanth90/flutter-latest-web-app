import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:rule_engine_ttakeoff/Login/LoginModel.dart';
import '../constants/ApplicationConstants.dart';

class LoginUtils {
    Future<LoginModel>  login(String username, String password) async {
      final response = await http.post(AppConstants.loginURL, body: {'email': username, 'password': password});
      if (response.statusCode == 200) { 
        LoginModel model = LoginModel.fromJson(json.decode(response.body));
        return model;
      } else {
        return null;
      }
    }
    
}