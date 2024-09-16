import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/core/unions/result_state.dart';
import '../../../domain/repository/auth_repository.dart';
import '../../../domain/usecase/validate_login_form_uc.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ValidateLoginFormUc _validateLoginFormUc;
  final AuthRepository _authRepository;
  LoginBloc(this._validateLoginFormUc, this._authRepository)
      : super(LoginState.initial()) {
    on<_UsernameTextChanged>(_onUsernameTextChanged);
    on<_PasswordTextChanged>(_onPasswordTextChanged);
    on<_LoginButtonClicked>(_onLoginButtonClicked);
  }
  void _onUsernameTextChanged(
      _UsernameTextChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(username: event.value));
    _validateForm(emit);
  }

  void _onPasswordTextChanged(
      _PasswordTextChanged event, Emitter<LoginState> emit) {
    emit(state.copyWith(password: event.value));
    _validateForm(emit);
  }

  void _onLoginButtonClicked(
      _LoginButtonClicked event, Emitter<LoginState> emit) async {
    emit(state.copyWith(doLoginState: const ResultState.loading()));

    final result = await _authRepository.login(
      email: state.username,
      password: state.password,
    );
    result.fold(
      (l) =>
          emit(state.copyWith(doLoginState: ResultState.failure(failure: l))),
      (r) => emit(
          state.copyWith(doLoginState: const ResultState.success(data: null))),
    );
  }

  void _validateForm(Emitter<LoginState> emit) {
    final result = _validateLoginFormUc(ValidateLoginFormUcParam(
      email: state.username,
      password: state.password,
    ));
    emit(state.copyWith(
      isFormValidated: result.getOrElse((l) => false),
    ));
  }
}
