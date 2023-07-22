part of 'onboarding_bloc.dart';

@freezed
class OnboardingEvent with _$OnboardingEvent {
  const factory OnboardingEvent.nextButtonClicked() = _NextButtonClicked;
  const factory OnboardingEvent.previousButtonClicked() =
      _PreviousButtonClicked;
  const factory OnboardingEvent.skipButtonClicked() = _SkipButtonClicked;
  const factory OnboardingEvent.itemChanged(int page) = _ItemChanged;
}
