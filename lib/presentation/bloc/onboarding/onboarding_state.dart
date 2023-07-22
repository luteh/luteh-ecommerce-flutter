part of 'onboarding_bloc.dart';

@freezed
class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    required int currentIndex,
    required int itemCount,
  }) = _OnboardingState;
  factory OnboardingState.initial() => const OnboardingState(
        currentIndex: 0,
        itemCount: 3,
      );
}
