part of 'splash_bloc.dart';

@freezed
class SplashState with _$SplashState {
  const factory SplashState({required ResultState<bool> getLoginSessionState}) =
      _SplashState;
  factory SplashState.initial() => const SplashState(
        getLoginSessionState: ResultState.initial(),
      );
}
