import "package:shared_preferences/shared_preferences.dart";

class SharedPrefsService {
  SharedPrefsService._();
  static final instance = SharedPrefsService._();
  SharedPreferences? _prefs;
  Future<bool> addToStringList(String key, String newValue) async {
    final originalList = readStringList(key);
    if (originalList == null) {
      return setStringList(key, [newValue]);
    }
    if (originalList.contains(newValue)) {
      return true;
    }
    return setStringList(key, [...originalList, newValue]);
  }

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  bool isInStringList(String key, String value) =>
      _prefs!.getStringList(key)?.contains(value) ?? false;

  List<String>? readStringList(String key) => _prefs!.getStringList(key);
  Future<bool> removeFromStringList(String key, String removedValue) async {
    final originalList = readStringList(key);
    if (originalList == null) {
      throw "List not founded";
    }
    if (!originalList.contains(removedValue)) {
      throw "Element not founded in the list";
    }
    originalList.remove(removedValue);
    return setStringList(key, originalList);
  }

  Future<bool> setStringList(String key, List<String> values) async =>
      _prefs!.setStringList(key, values);
}
