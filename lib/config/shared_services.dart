import 'package:shared_preferences/shared_preferences.dart';

class SharedService {
  static SharedPreferences _sharedPreferences;
  static const String _DOORBELL = 'doorBell',
      _WHATSAPP = 'whatsappNotification';

  static Future<SharedPreferences> get instance async =>
      await SharedPreferences.getInstance();

  static Future<bool> changeDoorBellSettings(bool val) async {
    _sharedPreferences = await instance;
    return _sharedPreferences.setBool(_DOORBELL, val);
  }

  static Future<bool> get doorBellSetting async {
    _sharedPreferences = await instance;
    return _sharedPreferences.getBool(_DOORBELL) ?? false;
  }

  static Future<bool> changeWhatsappNotificationSettings(bool val) async {
    _sharedPreferences = await instance;
    return _sharedPreferences.setBool(_WHATSAPP, val);
  }

  static Future<bool> get whatsappNotificationSettings async {
    _sharedPreferences = await instance;
    return _sharedPreferences.getBool(_WHATSAPP) ?? false;
  }
}
