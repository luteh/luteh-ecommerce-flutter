import 'dart:io';

import 'package:dio/dio.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/constant/dependency_name.dart';
import 'injection_container.dart';

@module
abstract class RegisterModule {
  @Named(DependencyName.baseUrl)
  @lazySingleton
  @prod
  String get baseUrlProd => Platform.isAndroid
      ? 'http://10.0.2.2:4000/graphql'
      : 'http://localhost:4000/graphql';

  @Named(DependencyName.baseUrl)
  @lazySingleton
  @dev
  String get baseUrlDev => Platform.isAndroid
      ? 'http://10.0.2.2:4000/graphql'
      : 'http://localhost:4000/graphql';

  @Named(DependencyName.baseUrl)
  @lazySingleton
  @stg
  String get baseUrlStg => Platform.isAndroid
      ? 'http://10.0.2.2:4000/graphql'
      : 'http://localhost:4000/graphql';

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

  @lazySingleton
  GraphQLClient getGraphQLClient(
          @Named(DependencyName.baseUrl) String baseUrl) =>
      GraphQLClient(
        link: HttpLink(baseUrl),
        // The default store is the InMemoryStore, which does NOT persist to disk
        cache: GraphQLCache(store: null),
      );
}
