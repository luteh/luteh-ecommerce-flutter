import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_user_request.freezed.dart';
part 'register_user_request.g.dart';

@freezed
class RegisterUserRequest with _$RegisterUserRequest {
  const factory RegisterUserRequest({
    required String email,
    required String name,
    required String password,
    required String phone,
    @JsonKey(name: 'role_id') required int roleId,
  }) = _RegisterUserRequest;

  factory RegisterUserRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterUserRequestFromJson(json);
}
