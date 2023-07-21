part of 'localization_bloc.dart';

@freezed
class LocalizationState with _$LocalizationState {
  const factory LocalizationState({
    required Locale locale,
    required ResultState<void> changeLocaleResult,
  }) = _LocalizationState;

  factory LocalizationState.initial() => const LocalizationState(
        locale: Locale('en'),
        changeLocaleResult: ResultState.initial(),
      );
}
