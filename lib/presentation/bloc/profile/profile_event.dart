part of 'profile_bloc.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.logoutButtonClicked() = _LogoutButtonClicked;
}
