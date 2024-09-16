part of 'register_user_bloc.dart';

@freezed
class RegisterUserState with _$RegisterUserState {
  const factory RegisterUserState({
    required ResultState<List<UserRole>> getUserRolesState,
    required ResultState<void> registerUserState,
    required bool isFormValidated,
  }) = _RegisterUserState;
  factory RegisterUserState.initial() => const RegisterUserState(
        getUserRolesState: ResultState.initial(),
        registerUserState: ResultState.initial(),
        isFormValidated: false,
      );
}
