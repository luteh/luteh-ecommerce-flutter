import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_starter_boilerplate/domain/core/unions/failure.dart';
import 'package:flutter_starter_boilerplate/domain/core/unions/result_state.dart';
import 'package:flutter_starter_boilerplate/domain/model/user_role.dart';
import 'package:flutter_starter_boilerplate/domain/repository/auth_repository.dart';
import 'package:flutter_starter_boilerplate/domain/usecase/validate_register_user_form_uc.dart';
import 'package:flutter_starter_boilerplate/presentation/bloc/register_user/register_user_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'register_user_bloc_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthRepository>(),
  MockSpec<ValidateRegisterUserFormUc>(),
])
void main() {
  late MockAuthRepository authRepository;
  late MockValidateRegisterUserFormUc validateRegisterUserFormUc;
  late RegisterUserBloc registerUserBloc;

  setUp(() {
    authRepository = MockAuthRepository();
    validateRegisterUserFormUc = MockValidateRegisterUserFormUc();
    registerUserBloc =
        RegisterUserBloc(authRepository, validateRegisterUserFormUc);
  });

  group('RegisterUserBloc', () {
    final userRoles = [
      const UserRole(
        id: '1',
        name: 'Admin',
      ),
    ];
    const failure = Failure.defaultError();

    provideDummy<Either<Failure, bool>>(const Right(true));
    provideDummy<Either<Failure, List<UserRole>>>(Right(userRoles));
    provideDummy<Either<Failure, void>>(const Right(null));

    blocTest<RegisterUserBloc, RegisterUserState>(
      'emits [loading, success] when user roles are fetched successfully',
      build: () {
        when(authRepository.fetchUserRoles())
            .thenAnswer((_) async => Right(userRoles));
        return registerUserBloc;
      },
      act: (bloc) => bloc.add(const RegisterUserEvent.started()),
      expect: () => [
        RegisterUserState.initial()
            .copyWith(getUserRolesState: const ResultState.loading()),
        RegisterUserState.initial()
            .copyWith(getUserRolesState: ResultState.success(data: userRoles)),
      ],
      verify: (bloc) {
        verify(authRepository.fetchUserRoles()).called(1);
      },
    );

    blocTest<RegisterUserBloc, RegisterUserState>(
      'emits [loading, failure] when fetching user roles failed',
      build: () {
        when(authRepository.fetchUserRoles())
            .thenAnswer((_) async => const Left(failure));
        return registerUserBloc;
      },
      act: (bloc) => bloc.add(const RegisterUserEvent.started()),
      expect: () => [
        RegisterUserState.initial()
            .copyWith(getUserRolesState: const ResultState.loading()),
        RegisterUserState.initial().copyWith(
            getUserRolesState: const ResultState.failure(failure: failure)),
      ],
      verify: (bloc) {
        verify(authRepository.fetchUserRoles()).called(1);
      },
    );

    blocTest<RegisterUserBloc, RegisterUserState>(
      'emits [loading, success] when user registered successfully',
      build: () {
        when(authRepository.registerUser(any))
            .thenAnswer((_) async => const Right(null));
        return registerUserBloc;
      },
      act: (bloc) => bloc.add(const RegisterUserEvent.registerButtonClicked()),
      expect: () => [
        RegisterUserState.initial()
            .copyWith(registerUserState: const ResultState.loading()),
        RegisterUserState.initial()
            .copyWith(registerUserState: const ResultState.success(data: null)),
      ],
      verify: (bloc) {
        verify(authRepository.registerUser(any)).called(1);
      },
    );

    blocTest<RegisterUserBloc, RegisterUserState>(
      'emits form validation result when fields are changed',
      build: () {
        when(validateRegisterUserFormUc.execute(any))
            .thenReturn(const Right(false));
        return registerUserBloc;
      },
      act: (bloc) {
        bloc.add(const RegisterUserEvent.emailFieldChanged('test@test.com'));
      },
      expect: () => [
        RegisterUserState.initial().copyWith(isFormValidated: false),
      ],
      verify: (bloc) {
        verify(validateRegisterUserFormUc.execute(any)).called(1);
      },
    );
  });
}
