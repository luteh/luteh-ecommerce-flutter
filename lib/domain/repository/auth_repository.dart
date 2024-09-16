import 'package:fpdart/fpdart.dart';

import '../core/unions/failure.dart';
import '../model/register_user.dart';
import '../model/user_role.dart';

abstract class AuthRepository {
  Future<Either<Failure, List<UserRole>>> fetchUserRoles();
  Future<Either<Failure, void>> registerUser(RegisterUser user);
}
