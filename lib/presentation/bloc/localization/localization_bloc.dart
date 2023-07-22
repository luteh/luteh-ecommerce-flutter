import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/core/unions/result_state.dart';
import '../../../domain/usecase/get_language_code_uc.dart';
import '../../../domain/usecase/save_language_code_uc.dart';

part 'localization_bloc.freezed.dart';
part 'localization_event.dart';
part 'localization_state.dart';

@injectable
class LocalizationBloc extends Bloc<LocalizationEvent, LocalizationState> {
  final GetLanguageCodeUC _getLanguageCodeUC;
  final SaveLanguageCodeUC _saveLanguageCodeUC;
  
  LocalizationBloc(this._getLanguageCodeUC, this._saveLanguageCodeUC)
      : super(LocalizationState.initial()) {
    on<_LocaleChanged>(_onLocaleChanged);
    on<_Started>(_onStarted);
  }

  void _onLocaleChanged(
      _LocaleChanged event, Emitter<LocalizationState> emit) async {
    emit(state.copyWith(changeLocaleResult: const ResultState.loading()));
    final result = await _saveLanguageCodeUC(
        SaveLanguageCodeUCParam(event.locale.languageCode));
    result.fold(
      (l) => emit(
          state.copyWith(changeLocaleResult: ResultState.failure(failure: l))),
      (r) => emit(state.copyWith(
        locale: event.locale,
        changeLocaleResult: const ResultState.success(data: null),
      )),
    );
  }

  void _onStarted(_Started event, Emitter<LocalizationState> emit) {
    _getLanguageCode(emit);
  }

  void _getLanguageCode(Emitter<LocalizationState> emit) {
    final result = _getLanguageCodeUC();
    result.fold(
      (l) => null,
      (r) => emit(state.copyWith(locale: Locale(r))),
    );
  }
}
