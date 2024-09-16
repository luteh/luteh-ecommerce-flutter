import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_user.freezed.dart';

@freezed
class RegisterUser with _$RegisterUser {
  const factory RegisterUser({
    required String email,
    required String name,
    required String password,
    required String phone,
    required int roleId,
  }) = _RegisterUser;
}
