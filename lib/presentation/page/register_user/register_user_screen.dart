import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extention/context_extention.dart';
import '../../../di/injection_container.dart';
import '../../../domain/core/unions/failure.dart';
import '../../../domain/core/unions/result_state.dart';
import '../../../domain/model/user_role.dart';
import '../../bloc/register_user/register_user_bloc.dart';
import '../../core/style/size_wrapper_extension.dart';
import '../../core/widget/my_error_widget.dart';
import '../../core/widget/my_scaffold.dart';
import '../../core/widget/rounded_dropdown_menu.dart';
import '../../core/widget/rounded_elevated_button.dart';
import '../../core/widget/rounded_text_field.dart';
import '../../route/route_extension.dart';

class RegisterUserScreen extends StatelessWidget {
  const RegisterUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt.get<RegisterUserBloc>()..add(const RegisterUserEvent.started()),
      child: const _RegisterUserScreen(),
    );
  }
}

class _RegisterUserScreen extends StatelessWidget {
  const _RegisterUserScreen();

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: AppBar(
        title: const Text('Register User'),
      ),
      body: BlocListener<RegisterUserBloc, RegisterUserState>(
        listenWhen: (previous, current) =>
            previous.registerUserState != current.registerUserState,
        listener: (BuildContext context, state) {
          state.registerUserState.maybeWhen(
            failure: (failure) =>
                context.showSnackBar(message: failure.message),
            success: (data) {
              context.showSnackBar(message: 'Register Success!');
              context.pop();
            },
            orElse: () => null,
          );
        },
        child: BlocSelector<RegisterUserBloc, RegisterUserState,
            ResultState<List<UserRole>>>(
          selector: (state) {
            return state.getUserRolesState;
          },
          builder: (context, getUserRolesState) {
            return getUserRolesState.maybeWhen(
              success: (data) {
                return LayoutBuilder(builder: (context, constraint) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraint.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: EdgeInsets.all(20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Spacer(),
                              RoundedTextField(
                                onChanged: (value) {
                                  context.read<RegisterUserBloc>().add(
                                      RegisterUserEvent.emailFieldChanged(
                                          value));
                                },
                                labelText: 'Email',
                                keyboardType: TextInputType.emailAddress,
                              ),
                              SizedBox(height: 16.h),
                              RoundedTextField(
                                onChanged: (value) {
                                  context.read<RegisterUserBloc>().add(
                                      RegisterUserEvent.passwordFieldChanged(
                                          value));
                                },
                                isPasswordField: true,
                                labelText: 'Password',
                              ),
                              SizedBox(height: 16.h),
                              RoundedTextField(
                                onChanged: (value) {
                                  context.read<RegisterUserBloc>().add(
                                      RegisterUserEvent.nameFieldChanged(
                                          value));
                                },
                                labelText: 'Name',
                              ),
                              SizedBox(height: 16.h),
                              RoundedTextField(
                                onChanged: (value) {
                                  context.read<RegisterUserBloc>().add(
                                      RegisterUserEvent.phoneFieldChanged(
                                          value));
                                },
                                keyboardType: TextInputType.number,
                                labelText: 'Phone',
                              ),
                              SizedBox(height: 16.h),
                              RoundedDropdownMenu(
                                labelText: 'Role',
                                onSelected: (value) {
                                  if (value == null) return;

                                  context.read<RegisterUserBloc>().add(
                                      RegisterUserEvent.roleFieldChanged(
                                          value));
                                },
                                dropdownMenuEntries: data
                                    .map((e) => DropdownMenuEntry(
                                          value: e.id,
                                          label: e.name,
                                        ))
                                    .toList(),
                              ),
                              SizedBox(height: 32.h),
                              const Spacer(),
                              BlocSelector<RegisterUserBloc, RegisterUserState,
                                  ResultState<void>>(
                                selector: (state) {
                                  return state.registerUserState;
                                },
                                builder: (context, registerUserState) {
                                  return registerUserState.maybeWhen(
                                    loading: () => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    orElse: () {
                                      return RoundedElevatedButton(
                                        onPressed: () {
                                          context.read<RegisterUserBloc>().add(
                                              const RegisterUserEvent
                                                  .registerButtonClicked());
                                        },
                                        enabled: context.select(
                                            (RegisterUserBloc bloc) =>
                                                bloc.state.isFormValidated),
                                        text: 'Register',
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
              },
              failure: (failure) {
                return MyErrorWidget(
                  text: Failure.getErrorMessage(failure),
                  onTapRetry: () {
                    context
                        .read<RegisterUserBloc>()
                        .add(const RegisterUserEvent.retryButtonClicked());
                  },
                );
              },
              orElse: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
