import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class PrefsManager {
  final SharedPreferences _preferences;

  PrefsManager(this._preferences);

  static const keyLanguageCode = 'keyLanguageCode';
  static const keyAccessToken = 'keyAccessToken';

  Future<void> saveLanguageCode(String languageCode) async {
    await _preferences.setString(keyLanguageCode, languageCode);
  }

  String getLanguageCode() {
    return _preferences.getString(keyLanguageCode) ?? 'en';
  }

  Future<void> saveAccessToken(String accessToken) async {
    await _preferences.setString(keyAccessToken, accessToken);
  }

  String getAccessToken() {
    return _preferences.getString(keyAccessToken) ?? '';
  }
}
