abstract class LocalDataSource {
  Future<void> saveLanguageCode(String languageCode);

  String getLanguageCode();
  Future<void> saveAccessToken(String accessToken);
  String getAccessToken();
  Future<void> removeAccessToken();
}
