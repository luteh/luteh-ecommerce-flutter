import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class PrefsManager {
  final SharedPreferences _preferences;

  PrefsManager(this._preferences);

  static const keyLanguageCode = 'keyLanguageCode';

  Future<void> saveLanguageCode(String languageCode) async {
    await _preferences.setString(keyLanguageCode, languageCode);
  }

  String getLanguageCode() {
    return _preferences.getString(keyLanguageCode) ?? 'en';
  }
}
