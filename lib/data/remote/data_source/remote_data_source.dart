import '../model/request/login/login_request.dart';
import '../model/response/base_response.dart';
import '../model/response/login/login_response.dart';

abstract class RemoteDataSource {
  Future<BaseResponse<LoginResponse>> login(LoginRequest request);
}
