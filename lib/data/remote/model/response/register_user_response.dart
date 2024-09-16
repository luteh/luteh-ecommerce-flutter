import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_user_response.freezed.dart';
part 'register_user_response.g.dart';

@freezed
class RegisterUserResponse with _$RegisterUserResponse {
  const RegisterUserResponse._();
  const factory RegisterUserResponse({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'email') String? email,
  }) = _RegisterUserResponse;

  factory RegisterUserResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterUserResponseFromJson(json);
}
