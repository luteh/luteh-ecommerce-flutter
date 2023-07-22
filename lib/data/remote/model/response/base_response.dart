import 'package:freezed_annotation/freezed_annotation.dart';

import 'login/login_response.dart';

part 'base_response.freezed.dart';
part 'base_response.g.dart';

@freezed
class BaseResponse with _$BaseResponse {
  const factory BaseResponse({
    bool? success,
    String? message,
    LoginResponse? data,
    String? token,
    String? refresh,
  }) = _BaseResponse;

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);
}
