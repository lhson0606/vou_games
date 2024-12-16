import 'package:shared_preferences/shared_preferences.dart';
import 'package:vou_games/core/services/contract/shared_preferences_service_contract.dart';

class SharedPreferencesService extends SharedPreferencesServiceContract {
  late final SharedPreferences _sharedPreferences;

  SharedPreferencesService() {
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  @override
  bool? getBool(String key) {
    return _sharedPreferences.getBool(key);
  }

  @override
  int? getInt(String key) {
    return _sharedPreferences.getInt(key);
  }

  @override
  String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  @override
  Future<void> removeBool(String key) async {
    await _sharedPreferences.remove(key);
  }

  @override
  Future<void> removeInt(String key) async {
    await _sharedPreferences.remove(key);
  }

  @override
  Future<void> removeString(String key) async {
    await _sharedPreferences.remove(key);
  }

  @override
  Future<void> saveBool(String key, bool value) async {
    await _sharedPreferences.setBool(key, value);
  }

  @override
  Future<void> saveInt(String key, int value) async {
    await _sharedPreferences.setInt(key, value);
  }

  @override
  Future<void> saveString(String key, String value) async {
    await _sharedPreferences.setString(key, value);
  }
}