import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../model/request/login/login_request.dart';
import 'endpoint.dart';

@lazySingleton
class MyApiService {
  final Dio _dio;

  MyApiService(this._dio);

  Future<Response> login(LoginRequest request) {
    return _dio.post(
      Endpoint.login,
      data: request.toJson(),
    );
  }
}
