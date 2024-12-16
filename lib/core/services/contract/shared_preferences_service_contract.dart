abstract class SharedPreferencesServiceContract {
  // string
  Future<void> saveString(String key, String value);
  String? getString(String key);
  Future<void> removeString(String key);
  // bool
  Future<void> saveBool(String key, bool value);
  bool? getBool(String key);
  Future<void> removeBool(String key);
  // int
  Future<void> saveInt(String key, int value);
  int? getInt(String key);
  Future<void> removeInt(String key);
}