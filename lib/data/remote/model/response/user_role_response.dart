import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/model/user_role.dart';

part 'user_role_response.freezed.dart';
part 'user_role_response.g.dart';

@freezed
class UserRoleResponse with _$UserRoleResponse {
  const UserRoleResponse._();
  const factory UserRoleResponse({
    @JsonKey(name: 'id') String? id,
    @JsonKey(name: 'name') String? name,
  }) = _UserRoleResponse;

  factory UserRoleResponse.fromJson(Map<String, dynamic> json) =>
      _$UserRoleResponseFromJson(json);

  UserRole toDomain() => UserRole(
        id: id ?? '',
        name: name ?? '',
      );
}
