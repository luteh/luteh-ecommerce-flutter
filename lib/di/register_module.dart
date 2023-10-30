import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constant/dependency_name.dart';
import 'injection_container.dart';

@module
abstract class RegisterModule {
  @Named(DependencyName.baseUrl)
  @lazySingleton
  @prod
  String get baseUrlProd => 'https://bowindo.servehttp.com';

  @Named(DependencyName.baseUrl)
  @lazySingleton
  @dev
  String get baseUrlDev => 'https://bowindo.servehttp.com/dev';

  @Named(DependencyName.baseUrl)
  @lazySingleton
  @stg
  String get baseUrlStg => 'https://bowindo.servehttp.com/stg';

  @lazySingleton
  @dev
  Environment get envDev => dev;

  @lazySingleton
  @stg
  Environment get envStg => stg;

  @lazySingleton
  @prod
  Environment get envProd => prod;

  @preResolve
  @lazySingleton
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  Dio getDio(@Named(DependencyName.baseUrl) String baseUrl) => Dio(
        BaseOptions(
          baseUrl: baseUrl,
        ),
      );
}
