abstract class LocalDataSource {
  Future<void> saveLanguageCode(String languageCode);

  String getLanguageCode();
}
