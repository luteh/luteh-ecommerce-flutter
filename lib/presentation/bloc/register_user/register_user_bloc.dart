import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/core/unions/result_state.dart';
import '../../../domain/model/register_user.dart';
import '../../../domain/model/user_role.dart';
import '../../../domain/repository/auth_repository.dart';
import '../../../domain/usecase/validate_register_user_form_uc.dart';

part 'register_user_bloc.freezed.dart';
part 'register_user_event.dart';
part 'register_user_state.dart';

@injectable
class RegisterUserBloc extends Bloc<RegisterUserEvent, RegisterUserState> {
  final AuthRepository _authRepository;
  final ValidateRegisterUserFormUc _validateRegisterUserFormUc;

  String _email = '';
  String _name = '';
  String _password = '';
  String _phone = '';
  String _roleId = '';

  RegisterUserBloc(this._authRepository, this._validateRegisterUserFormUc)
      : super(RegisterUserState.initial()) {
    on<_Started>(_onStarted);
    on<_RetryButtonClicked>((event, emit) => _fetchUserRoles(emit));
    on<_EmailFieldChanged>(_onEmailFieldChanged);
    on<_NameFieldChanged>(_onNameFieldChanged);
    on<_PasswordFieldChanged>(_onPasswordFieldChanged);
    on<_PhoneFieldChanged>(_onPhoneFieldChanged);
    on<_RoleFieldChanged>(_onRoleFieldChanged);
    on<_RegisterButtonClicked>(_registerUser);
  }

  void _onStarted(_Started event, Emitter<RegisterUserState> emit) async {
    await _fetchUserRoles(emit);
  }

  Future<void> _fetchUserRoles(Emitter<RegisterUserState> emit) async {
    emit(state.copyWith(getUserRolesState: const ResultState.loading()));
    final result = await _authRepository.fetchUserRoles();
    result.fold(
      (l) {
        emit(
            state.copyWith(getUserRolesState: ResultState.failure(failure: l)));
      },
      (r) {
        emit(state.copyWith(getUserRolesState: ResultState.success(data: r)));
      },
    );
  }

  void _registerUser(
      _RegisterButtonClicked event, Emitter<RegisterUserState> emit) async {
    emit(state.copyWith(registerUserState: const ResultState.loading()));
    final result = await _authRepository.registerUser(RegisterUser(
      email: _email,
      name: _name,
      password: _password,
      phone: _phone,
      roleId: int.tryParse(_roleId) ?? 0,
    ));
    result.fold(
      (l) {
        emit(
            state.copyWith(registerUserState: ResultState.failure(failure: l)));
      },
      (r) {
        emit(state.copyWith(
            registerUserState: const ResultState.success(data: null)));
      },
    );
  }

  void _onEmailFieldChanged(
      _EmailFieldChanged event, Emitter<RegisterUserState> emit) {
    _email = event.value;
    _validateForm(emit);
  }

  void _onNameFieldChanged(
      _NameFieldChanged event, Emitter<RegisterUserState> emit) {
    _name = event.value;
    _validateForm(emit);
  }

  void _onPasswordFieldChanged(
      _PasswordFieldChanged event, Emitter<RegisterUserState> emit) {
    _password = event.value;
    _validateForm(emit);
  }

  void _onPhoneFieldChanged(
      _PhoneFieldChanged event, Emitter<RegisterUserState> emit) {
    _phone = event.value;
    _validateForm(emit);
  }

  void _onRoleFieldChanged(
      _RoleFieldChanged event, Emitter<RegisterUserState> emit) {
    _roleId = event.value;
    _validateForm(emit);
  }

  void _validateForm(Emitter<RegisterUserState> emit) {
    final result = _validateRegisterUserFormUc.execute(RegisterUser(
      email: _email,
      name: _name,
      password: _password,
      phone: _phone,
      roleId: int.tryParse(_roleId) ?? 0,
    ));
    emit(state.copyWith(isFormValidated: result.getOrElse((l) => false)));
  }
}
