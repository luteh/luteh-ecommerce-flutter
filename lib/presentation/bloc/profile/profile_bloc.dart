import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/core/unions/result_state.dart';
import '../../../domain/usecase/logout_uc.dart';

part 'profile_bloc.freezed.dart';
part 'profile_event.dart';
part 'profile_state.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final LogoutUC _logoutUC;
  ProfileBloc(this._logoutUC) : super(ProfileState.initial()) {
    on<_LogoutButtonClicked>(_onLogoutButtonClicked);
  }
  void _onLogoutButtonClicked(
      _LogoutButtonClicked event, Emitter<ProfileState> emit) async {
    emit(state.copyWith(doLogoutState: const ResultState.loading()));

    final result = await _logoutUC();
    result.fold(
      (l) =>
          emit(state.copyWith(doLogoutState: ResultState.failure(failure: l))),
      (r) => emit(state.copyWith(doLogoutState: const ResultState.success(data: null))),
    );
  }
}
