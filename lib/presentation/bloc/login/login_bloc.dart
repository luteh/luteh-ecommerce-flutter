import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/core/unions/result_state.dart';
import '../../../domain/model/login/login_entity.dart';
import '../../../domain/usecase/login_uc.dart';

part 'login_bloc.freezed.dart';
part 'login_event.dart';
part 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUC _loginUC;
  LoginBloc(this._loginUC) : super(LoginState.initial()) {
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

    final result = await _loginUC(LoginUCParam(
      username: state.username,
      password: state.password,
    ));
    result.fold(
      (l) =>
          emit(state.copyWith(doLoginState: ResultState.failure(failure: l))),
      (r) => emit(state.copyWith(doLoginState: ResultState.success(data: r))),
    );
  }

  void _validateForm(Emitter<LoginState> emit) {
    emit(state.copyWith(
      isFormValidated: state.username.isNotEmpty && state.password.isNotEmpty,
    ));
  }
}
