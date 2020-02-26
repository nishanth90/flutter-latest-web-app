import 'package:global_configuration/global_configuration.dart';
import 'package:jaguar_jwt/jaguar_jwt.dart';
import 'package:rule_engine_ttakeoff/models/UserModel.dart';

class JWTTokenHandler {
  static JWTTokenHandler _jwtTokenHandler;
  final String secretKey = "jwtSecret";
  JWTTokenHandler._();

  static Future getInstance() async {
    if (_jwtTokenHandler == null) {
      var jwtTokenHandlerInternal = JWTTokenHandler._();
      await jwtTokenHandlerInternal.init();
      _jwtTokenHandler = jwtTokenHandlerInternal;
    }
    return _jwtTokenHandler;
  }

  Future<void> init() async {
    await GlobalConfiguration().loadFromPath("cfg/app-config.json");
  }

  static UserModel getUserFromToken(String token) {
    print("In the token");
    if(_jwtTokenHandler == null) return null;
    final decClaimSet =verifyJwtHS256Signature(token, GlobalConfiguration().getString(_jwtTokenHandler.secretKey));
    decClaimSet.validate(currentTime: DateTime.now());
    print("+++>>>>>"+ decClaimSet.subject);
    return new UserModel(accessToken: decClaimSet.subject, username: "", emailId: "", role: "");
  }
}
