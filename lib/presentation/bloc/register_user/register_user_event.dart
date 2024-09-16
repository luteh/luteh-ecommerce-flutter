part of 'register_user_bloc.dart';

@freezed
class RegisterUserEvent with _$RegisterUserEvent {
  const factory RegisterUserEvent.started() = _Started;
  const factory RegisterUserEvent.retryButtonClicked() = _RetryButtonClicked;
  const factory RegisterUserEvent.emailFieldChanged(String value) =
      _EmailFieldChanged;
  const factory RegisterUserEvent.nameFieldChanged(String value) =
      _NameFieldChanged;
  const factory RegisterUserEvent.passwordFieldChanged(String value) =
      _PasswordFieldChanged;
  const factory RegisterUserEvent.phoneFieldChanged(String value) =
      _PhoneFieldChanged;
  const factory RegisterUserEvent.roleFieldChanged(String value) =
      _RoleFieldChanged;
  const factory RegisterUserEvent.registerButtonClicked() =
      _RegisterButtonClicked;
}
