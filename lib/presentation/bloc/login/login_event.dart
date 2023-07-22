part of 'login_bloc.dart';

@freezed
class LoginEvent with _$LoginEvent {
  const factory LoginEvent.usernameTextChanged(String value) =
      _UsernameTextChanged;
  const factory LoginEvent.passwordTextChanged(String value) =
      _PasswordTextChanged;
  const factory LoginEvent.loginButtonClicked() = _LoginButtonClicked;
}
