import 'package:shared_preferences/shared_preferences.dart';

import '../../../product/constants/enums/shared_keys_enums.dart';

class LocaleManager {
  static final LocaleManager _instance = LocaleManager._init();

  SharedPreferences? _preferences;

  static LocaleManager get instance => _instance;

  LocaleManager._init() {
    SharedPreferences.getInstance().then((value) => _preferences = value);
  }

  static preferencesInit() async {
    instance._preferences ??= await SharedPreferences.getInstance();
  }

  //* String methods.
  void setStringValue(SharedKeys key, String value) async {
    await _preferences?.setString(key.name, value);
  }

  String? getStringValue(SharedKeys key) {
    return _preferences?.getString(key.name);
  }

  Future<void> setStringItems(SharedKeys key, List<String> items) async {
    await _preferences?.setStringList(key.name, items);
  }

  List<String>? getStringItems(SharedKeys key) {
    return _preferences?.getStringList(key.name);
  }

  //* Boolean methods

  void setBoolValue(SharedKeys key, bool value) async {
    await _preferences?.setBool(key.name, value);
  }

  bool? getBoolValue(SharedKeys key) {
    return _preferences?.getBool(key.name);
  }

  //* Integer methods

  Future<void> setIntValue(SharedKeys key, int value) async {
    await _preferences?.setInt(key.name, value);
  }

  int? getIntValue(SharedKeys key) {
    return _preferences?.getInt(key.name);
  }

  //* Remove method
  void remove(SharedKeys key) async {
    await _preferences?.remove(key.name);
  }
}
