import 'package:injectable/injectable.dart';

import '../../../core/constant/dependency_name.dart';
import '../core/my_client.dart';

@lazySingleton
class MyApiService {
  final MyClient _myClient;
  final String _baseUrl;

  MyApiService(this._myClient, @Named(DependencyName.baseUrl) this._baseUrl);

  void login() {}
}
