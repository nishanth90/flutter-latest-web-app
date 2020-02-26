import 'package:flutter/material.dart';

class UserModel {
  final dynamic username;
  final dynamic accessToken;
  final dynamic emailId;
  final dynamic role;

  UserModel({
    @required this.accessToken,
    @required this.username,
    @required this.emailId,
    @required this.role
  });

  dynamic getUserName(){
    return this.username;
  }

  dynamic getAccessToken(){
    return this.accessToken;
  }

  dynamic getEmailId(){
    return this.emailId;
  }

  dynamic getRole(){
    return this.role;
  }
}