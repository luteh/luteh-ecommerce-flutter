import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extention/context_extention.dart';
import '../../../domain/core/unions/failure.dart';
import '../../bloc/profile/profile_bloc.dart';
import '../../core/widget/my_scaffold.dart';
import '../../core/widget/rounded_elevated_button.dart';
import '../../route/route_utils.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listenWhen: (previous, current) =>
          previous.doLogoutState != current.doLogoutState,
      listener: (context, state) {
        state.doLogoutState.maybeWhen(
          failure: (failure) => context.showSnackBar(message: failure.message),
          success: (data) => _onSuccessLogout(context),
          orElse: () => null,
        );
      },
      child: MyScaffold(
        appBar: AppBar(
          title: Text(context.localization.profile),
        ),
        body: Center(
            child: BlocBuilder<ProfileBloc, ProfileState>(
          buildWhen: (previous, current) =>
              previous.doLogoutState != current.doLogoutState,
          builder: (context, state) {
            return state.doLogoutState.maybeWhen(
              loading: () => const CircularProgressIndicator(),
              orElse: () => RoundedElevatedButton(
                onPressed: () => context
                    .read<ProfileBloc>()
                    .add(const ProfileEvent.logoutButtonClicked()),
                text: context.localization.logout,
              ),
            );
          },
        )),
      ),
    );
  }

  void _onSuccessLogout(BuildContext context) {
    RouteUtils.goToLoginPage(context);
  }
}
