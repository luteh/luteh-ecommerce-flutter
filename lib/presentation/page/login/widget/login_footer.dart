import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extention/context_extention.dart';
import '../../../../domain/core/unions/failure.dart';
import '../../../bloc/login/login_bloc.dart';
import '../../../core/style/sizes.dart';
import '../../../core/widget/rounded_elevated_button.dart';
import '../../../route/route_utils.dart';

class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listenWhen: (previous, current) =>
          previous.doLoginState != current.doLoginState,
      listener: (context, state) {
        state.doLoginState.maybeWhen(
          failure: (failure) => context.showSnackBar(message: failure.message),
          success: (data) => RouteUtils.goToHomePage(context),
          orElse: () => null,
        );
      },
      buildWhen: (previous, current) =>
          previous.doLoginState != current.doLoginState,
      builder: (context, state) {
        return state.doLoginState.maybeWhen(
          loading: () => const Center(child: CircularProgressIndicator()),
          orElse: () {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                BlocSelector<LoginBloc, LoginState, bool>(
                  selector: (state) {
                    return state.isFormValidated;
                  },
                  builder: (context, isFormValidated) {
                    return RoundedElevatedButton(
                      enabled: isFormValidated,
                      onPressed: () {
                        context
                            .read<LoginBloc>()
                            .add(const LoginEvent.loginButtonClicked());
                      },
                      text: context.localization.login,
                    );
                  },
                ),
                SizedBox(height: Sizes.height16),
                RoundedElevatedButton(
                  onPressed: () {
                    context.showSnackBar(
                      message: context.localization.comingSoon,
                    );
                  },
                  text: context.localization.register,
                ),
              ],
            );
          },
        );
      },
    );
  }
}
