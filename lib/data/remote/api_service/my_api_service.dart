import 'package:http/http.dart';
import 'package:injectable/injectable.dart';

import '../../../core/constant/dependency_name.dart';
import '../core/my_client.dart';
import '../model/request/login/login_request.dart';
import 'endpoint.dart';

@lazySingleton
class MyApiService {
  final MyClient _myClient;
  final String _baseUrl;

  MyApiService(this._myClient, @Named(DependencyName.baseUrl) this._baseUrl);

  Uri _getUrl({String endpoint = ''}) => Uri.parse('$_baseUrl$endpoint');

  Future<Response> login(LoginRequest request) {
    return _myClient.post(
      _getUrl(endpoint: Endpoint.login),
      body: request.toJson(),
    );
  }
}
