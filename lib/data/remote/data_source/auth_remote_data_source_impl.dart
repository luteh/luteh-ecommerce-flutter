import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

import '../graphql/auth.graphql.dart';
import 'auth_remote_data_source.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final GraphQLClient graphQlClient;

  AuthRemoteDataSourceImpl(this.graphQlClient);

  @override
  Future<Mutation$CreateUser$createUser> registerUser(
      Variables$Mutation$CreateUser request) async {
    final result =
        await graphQlClient.mutate$CreateUser(Options$Mutation$CreateUser(
      variables: request,
    ));

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    if (result.parsedData?.createUser == null) {
      throw Exception('Failed to create user');
    }

    return result.parsedData!.createUser!;
  }

  @override
  Future<List<Query$GetRoles$getRoles>> fetchUserRoles() async {
    final result = await graphQlClient.query$GetRoles(null);
    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    if (result.parsedData?.getRoles == null ||
        result.parsedData!.getRoles!.isEmpty) {
      throw Exception('Failed to get user roles');
    }

    return result.parsedData!.getRoles!.map((e) => e!).toList();
  }
}
