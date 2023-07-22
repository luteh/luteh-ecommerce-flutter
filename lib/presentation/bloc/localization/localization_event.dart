part of 'localization_bloc.dart';

@freezed
class LocalizationEvent with _$LocalizationEvent {
  const factory LocalizationEvent.localeChanged(Locale locale) = _LocaleChanged;
  const factory LocalizationEvent.started() = _Started;
}
