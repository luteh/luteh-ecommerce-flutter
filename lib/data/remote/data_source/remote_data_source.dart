import '../model/request/login/login_request.dart';
import '../model/response/base_response.dart';

abstract class RemoteDataSource {
  Future<BaseResponse> login(LoginRequest request);
}
