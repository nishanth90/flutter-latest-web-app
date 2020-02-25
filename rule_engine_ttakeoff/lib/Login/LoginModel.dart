import 'package:flutter/foundation.dart';

class LoginModel {
  final Token token;
  final User user;

  LoginModel({
    @required this.token,
    @required this.user,
  });
  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(token: Token.fromJson(json['token']), user: User.fromJson(json['user']));
  }
  
  User getUser(){
    return user;
  }

  Token getToken(){
    return token;
  }

}

class User {
  final String id;
  final bool registered;
  final String email;
  final String mobile;

  User({
    @required this.id,
    @required this.registered,
    @required this.email,
    @required this.mobile,
  });

   factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'] as String, 
    registered: json['registered'] as bool, 
    email: json['email'] as String, 
    mobile: json['mobile'] as String);
  }
}

class Token{
  final String tokenType;
  final String accessToken;
  final String expiresIn;
  final String dateNow;

  Token({
    @required this.tokenType,
    @required this.accessToken,
    @required this.expiresIn,
    @required this.dateNow,
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(tokenType: json['tokenType'], 
    accessToken: json['accessToken'], 
    expiresIn: json['expiresIn'], 
    dateNow: json['dateNow']);
  }
}