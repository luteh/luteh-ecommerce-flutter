import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

import '../graphql/auth.graphql.dart';
import 'auth_remote_data_source.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final GraphQLClient client;

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<Mutation$CreateUser$createUser> registerUser(
      Variables$Mutation$CreateUser request) async {
    final result = await client.mutate$CreateUser(Options$Mutation$CreateUser(
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
    final result = await client.query$GetRoles(null);
    if (result.hasException || result.parsedData?.getRoles == null) {
      throw Exception(result.exception.toString());
    }
    return result.parsedData!.getRoles!.map((e) => e!).toList();
  }
}
