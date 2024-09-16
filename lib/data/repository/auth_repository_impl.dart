import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/unions/failure.dart';
import '../../domain/model/register_user.dart';
import '../../domain/model/user_role.dart';
import '../../domain/repository/auth_repository.dart';
import '../remote/data_source/auth_remote_data_source.dart';
import '../remote/graphql/auth.graphql.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _authRemoteDataSource;

  AuthRepositoryImpl(this._authRemoteDataSource);
  @override
  Future<Either<Failure, List<UserRole>>> fetchUserRoles() async {
    try {
      final roles = await _authRemoteDataSource.fetchUserRoles();
      return right(roles
          .map((e) => UserRole(
                id: e.id,
                name: e.name,
              ))
          .toList());
    } on Exception catch (e) {
      return left(Failure.defaultError(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> registerUser(RegisterUser user) async {
    try {
      await _authRemoteDataSource.registerUser(Variables$Mutation$CreateUser(
        email: user.email,
        name: user.name,
        password: user.password,
        phone: user.phone,
        role_id: user.roleId,
      ));
      return right(null);
    } on Exception catch (e) {
      return left(Failure.defaultError(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> login(
      {required String email, required String password}) async {
    try {
      await _authRemoteDataSource
          .login(Variables$Mutation$Login(password: password, email: email));
      return right(null);
    } on Exception catch (e) {
      return left(Failure.defaultError(error: e.toString()));
    }
  }
}
