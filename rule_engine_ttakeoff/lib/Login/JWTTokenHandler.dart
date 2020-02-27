
import 'package:flutter/services.dart';
import 'package:rule_engine_ttakeoff/models/UserModel.dart';

class JWTTokenHandler {
  static final JWTTokenHandler _instance = JWTTokenHandler._internal();
  var jsonData;
  factory JWTTokenHandler() {
    return _instance;
  }
  static JWTTokenHandler get instance => _instance;
  
  JWTTokenHandler._internal() {
    _init();
  }

  void _init() async {
    jsonData = await rootBundle.loadString("assets/cfg/app-config.json");
    //  contents = jsonDecode(jsonData)['jwtSecret'];
  }

  UserModel getUserFromToken(String token) {
    print("In the token");
 // final decClaimSet =
     //  verifyJwtHS256Signature(token, "TkJUVWt6endqaDVUM05memE5dDBmYVRXbm9WbDRFNlZaTUxFV2tGdExLZGp5UnJSakNiWDlSSGZKQ084WERSeg");
 //   decClaimSet.validate(currentTime: DateTime.now());
 //   print("+++>>>>>" + decClaimSet.subject);
    return new UserModel(
        accessToken: "Token", username: "Nishanth", emailId: "nishanth.techit@gmail.com", role: "TTakeoff admin");
  }
}
