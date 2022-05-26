import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static final SharedPrefs _instance = SharedPrefs._();

  factory SharedPrefs() {
    return _instance;
  }

  SharedPrefs._();

  static late SharedPreferences _prefs;

  static SharedPreferences get prefs => _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }
}
