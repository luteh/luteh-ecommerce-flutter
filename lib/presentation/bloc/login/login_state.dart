part of 'login_bloc.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    required ResultState<void> doLoginState,
    required String username,
    required String password,
    required bool isFormValidated,
  }) = _LoginState;
  factory LoginState.initial() => const LoginState(
        doLoginState: ResultState.initial(),
        username: '',
        password: '',
        isFormValidated: false,
      );
}
