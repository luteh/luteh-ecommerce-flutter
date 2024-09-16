import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_role.freezed.dart';

@freezed
class UserRole with _$UserRole {
  const factory UserRole({
    required String id,
    required String name,
  }) = _UserRole;
}
