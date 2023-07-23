part of 'profile_bloc.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    required ResultState<void> doLogoutState,
  }) = _ProfileState;
  factory ProfileState.initial() => const ProfileState(
        doLogoutState: ResultState.initial(),
      );
}
