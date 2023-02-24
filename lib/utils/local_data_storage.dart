import 'package:shared_preferences/shared_preferences.dart';

class LocalDataStorage {
  static SharedPreferences? _preferences;

  static const _keyTitle = 'title';

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setTitle(String title) async {
    await _preferences!.setString(_keyTitle, title);
  }

  static getTitle() async {
    _preferences!.getString(_keyTitle);
  }
}
