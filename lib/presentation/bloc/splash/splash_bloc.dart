import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/core/unions/result_state.dart';
import '../../../domain/usecase/get_login_session_uc.dart';

part 'splash_bloc.freezed.dart';
part 'splash_event.dart';
part 'splash_state.dart';

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final GetLoginSessionUC _getLoginSessionUC;
  SplashBloc(this._getLoginSessionUC) : super(SplashState.initial()) {
    on<_Started>(_onStarted);
  }
  void _onStarted(_Started event, Emitter<SplashState> emit) async {
    emit(state.copyWith(getLoginSessionState: const ResultState.loading()));

    final result = await _getLoginSessionUC();
    result.fold(
      (l) => emit(state.copyWith(
          getLoginSessionState: ResultState.failure(failure: l))),
      (r) => emit(
          state.copyWith(getLoginSessionState: ResultState.success(data: r))),
    );
  }
}
