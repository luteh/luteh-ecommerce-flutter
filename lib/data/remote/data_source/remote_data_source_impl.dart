import 'package:injectable/injectable.dart';

import '../api_service/my_api_service.dart';
import '../model/request/login/login_request.dart';
import '../model/response/base_response.dart';
import '../model/response/login/login_response.dart';
import 'remote_data_source.dart';

@LazySingleton(as: RemoteDataSource)
class RemoteDataSourceImpl implements RemoteDataSource {
  final MyApiService _myApiService;

  RemoteDataSourceImpl(this._myApiService);
  @override
  Future<BaseResponse<LoginResponse>> login(LoginRequest request) async {
    final response = await _myApiService.login(request);

    return BaseResponse.fromJson(
      response.data,
      (json) => LoginResponse.fromJson(json as dynamic),
    );
  }
}
