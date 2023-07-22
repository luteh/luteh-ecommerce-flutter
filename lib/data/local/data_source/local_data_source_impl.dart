import 'package:injectable/injectable.dart';

import '../prefs/prefs_manager.dart';
import 'local_data_source.dart';

@LazySingleton(as: LocalDataSource)
class LocalDataSourceImpl implements LocalDataSource {
  final PrefsManager _prefsManager;

  LocalDataSourceImpl(this._prefsManager);
  @override
  String getLanguageCode() {
    return _prefsManager.getLanguageCode();
  }

  @override
  Future<void> saveLanguageCode(String languageCode) async {
    await _prefsManager.saveLanguageCode(languageCode);
  }

  @override
  String getAccessToken() {
    return _prefsManager.getAccessToken();
  }

  @override
  Future<void> saveAccessToken(String accessToken) async {
    await _prefsManager.saveAccessToken(accessToken);
  }
}
