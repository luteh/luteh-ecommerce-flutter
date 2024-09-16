import 'package:flutter_starter_boilerplate/data/remote/data_source/auth_remote_data_source.dart';
import 'package:flutter_starter_boilerplate/data/remote/data_source/auth_remote_data_source_impl.dart';
import 'package:flutter_starter_boilerplate/data/remote/graphql/auth.graphql.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_remote_data_source_impl_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<GraphQLClient>(),
  MockSpec<QueryResult<Query$GetRoles>>(),
  MockSpec<QueryResult<Mutation$CreateUser>>(
    as: Symbol('MockMutationCreateUserResult'),
  ),
])
void main() {
  late AuthRemoteDataSource dataSource;
  late MockGraphQLClient mockGraphQLClient;
  late MockQueryResult mockQueryResult;
  late MockMutationCreateUserResult mockMutationCreateUserResult;

  setUp(() {
    mockGraphQLClient = MockGraphQLClient();
    mockQueryResult = MockQueryResult();
    mockMutationCreateUserResult = MockMutationCreateUserResult();
    dataSource = AuthRemoteDataSourceImpl(mockGraphQLClient);
  });

  group('fetchUserRoles', () {
    test('should fetch user roles successfully', () async {
      // Arrange
      when(mockQueryResult.hasException).thenReturn(false);
      when(mockQueryResult.parsedData).thenReturn(Query$GetRoles(
        getRoles: [
          Query$GetRoles$getRoles(id: '1', name: 'Admin'),
          Query$GetRoles$getRoles(id: '2', name: 'User'),
        ],
      ));
      when(mockGraphQLClient.query$GetRoles(null))
          .thenAnswer((_) async => mockQueryResult);

      // Act
      final result = await dataSource.fetchUserRoles();

      // Assert
      expect(result, isNotEmpty);

      verify(mockGraphQLClient.query$GetRoles(null)).called(1);
    });

    test('should throw an exception when query has exception', () async {
      // Arrange
      when(mockQueryResult.hasException).thenReturn(true);
      when(mockGraphQLClient.query$GetRoles(null))
          .thenAnswer((_) async => mockQueryResult);

      // Act & Assert
      expect(
        () => dataSource.fetchUserRoles(),
        throwsA(isA<Exception>()),
      );
      verify(mockGraphQLClient.query$GetRoles(null)).called(1);
    });

    test('should throw an exception when response is null', () async {
      // Arrange
      when(mockQueryResult.hasException).thenReturn(false);
      when(mockQueryResult.parsedData).thenReturn(null);
      when(mockGraphQLClient.query$GetRoles(null)).thenAnswer(
        (_) async => mockQueryResult,
      );

      // Act & Assert
      expect(
        () => dataSource.fetchUserRoles(),
        throwsA(isA<Exception>()),
      );
      verify(mockGraphQLClient.query$GetRoles(null)).called(1);
    });
  });
  group('registerUser', () {
    final variables = Variables$Mutation$CreateUser(
      email: 'email',
      password: 'password',
      name: 'name',
      phone: 'phone',
      role_id: 1,
    );
    final options = Options$Mutation$CreateUser(variables: variables);

    test('should register user successfully', () async {
      // Arrange
      when(mockMutationCreateUserResult.hasException).thenReturn(false);
      when(mockMutationCreateUserResult.parsedData)
          .thenReturn(Mutation$CreateUser(
              createUser: Mutation$CreateUser$createUser(
        id: 'id',
        email: 'email',
        name: 'name',
        phone: 'phone',
        role_id: 1,
      )));
      when(mockGraphQLClient.mutate$CreateUser(options))
          .thenAnswer((_) async => mockMutationCreateUserResult);

      // Act
      final result = await dataSource.registerUser(variables);

      // Assert
      expect(result.id, 'id');

      verify(mockGraphQLClient.mutate$CreateUser(options)).called(1);
    });

    test('should throw an exception when mutation has exception', () async {
      // Arrange
      when(mockMutationCreateUserResult.hasException).thenReturn(true);
      when(mockGraphQLClient.mutate$CreateUser(options))
          .thenAnswer((_) async => mockMutationCreateUserResult);

      // Act & Assert
      expect(
        () => dataSource.registerUser(variables),
        throwsA(isA<Exception>()),
      );
      verify(mockGraphQLClient.mutate$CreateUser(options)).called(1);
    });

    test('should throw an exception when response is null', () async {
      // Arrange
      when(mockMutationCreateUserResult.hasException).thenReturn(false);
      when(mockMutationCreateUserResult.parsedData).thenReturn(null);
      when(mockGraphQLClient.mutate$CreateUser(options)).thenAnswer(
        (_) async => mockMutationCreateUserResult,
      );

      // Act & Assert
      expect(
        () => dataSource.registerUser(variables),
        throwsA(isA<Exception>()),
      );
      verify(mockGraphQLClient.mutate$CreateUser(options)).called(1);
    });
  });
}
