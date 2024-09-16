import '../graphql/auth.graphql.dart';

abstract class AuthRemoteDataSource {
  Future<Mutation$CreateUser$createUser> registerUser(
      Variables$Mutation$CreateUser request);
  Future<List<Query$GetRoles$getRoles>> fetchUserRoles();
}
