import 'package:shared_preferences/shared_preferences.dart';

class StorageUtil {
  static final StorageUtil _instance = StorageUtil._internal();

  static Future<SharedPreferences> _preferences;

  factory StorageUtil() {
    return _instance;
  }

  static StorageUtil get instance => _instance;

  StorageUtil._internal(){
    _init();
  }

  _init()  {
    _preferences = SharedPreferences.getInstance();
  }

   // get string
   String getString(String key, {String defValue = '123'}) {
    return _instance.getString(key);
  }

  

  // put string
   Future putString(String key, String value) {
    if (_preferences == null) return null;
    return _preferences.then((values) => values.setString(key, value));
  }

   Future<bool> deleteToken(String key) {
    if (_preferences == null) return null;
    return _preferences.then((values) => values.remove(key));
  }

}