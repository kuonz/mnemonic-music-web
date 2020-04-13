import 'package:shared_preferences/shared_preferences.dart';

class Storage {

  static SharedPreferences _instance;

  static Map<String, dynamic> datas = Map<String, dynamic>();

  static Future<bool> init() async {
    _instance = await SharedPreferences.getInstance();

    if (!Storage.containsKey("volume")) {
      await Storage.setInt("volume", 5);
      datas["volume"] = 5;
    } else {
      datas["volume"] = Storage.getInt("volume");
    }

    if (!Storage.containsKey("modeIndex")) {
      await Storage.setInt("modeIndex", 0);
      datas["modeIndex"] = 0;
    } else {
      datas["modeIndex"] = Storage.getInt("modeIndex");
    }

    if (!Storage.containsKey("playlist")) {
      await Storage.setString("playlist", "[]");
      datas["playlist"] = "[]";
    } else {
      datas["playlist"] = Storage.getString("playlist");
    }

    if (!Storage.containsKey("jwt")) {
      await Storage.setString("jwt", "empty");
      datas["jwt"] = "empty";
    } else {
      datas["jwt"] = Storage.getString("jwt");
    }

    if (!Storage.containsKey("theme")) {
      await Storage.setInt("theme", 2);
      datas["theme"] = 2;
    } else {
      datas["theme"] = Storage.getInt("theme");
    }

    return true;
  }

  static bool containsKey(String key) {
    return _instance.containsKey(key);
  }

  static String getString(String key) {
    return _instance.getString(key);
  }

  static setString(String key, String value) async {
    await _instance.setString(key, value);
  }

  static int getInt(String key) {
    return _instance.getInt(key);
  }

  static setInt(String key, int value) async {
    await _instance.setInt(key, value);
  }
}