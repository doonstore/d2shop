import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  static SharedPreferences _sharedPreferences;
  static const String FIRST = 'first';

  static Future<SharedPreferences> get instance async =>
      await SharedPreferences.getInstance();

  static Future<bool> get isOldUser async {
    _sharedPreferences = await instance;
    return _sharedPreferences.getBool(FIRST) ?? false;
  }

  static Future<bool> setUserLoggedIn() async {
    _sharedPreferences = await instance;
    return _sharedPreferences.setBool(FIRST, true);
  }
}
