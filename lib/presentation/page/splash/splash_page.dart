import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extention/context_extention.dart';
import '../../bloc/splash/splash_bloc.dart';
import '../../core/style/sizes.dart';
import '../../core/widget/my_scaffold.dart';
import '../../route/route_utils.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listenWhen: (previous, current) =>
          previous.getLoginSessionState != current.getLoginSessionState,
      listener: (context, state) {
        state.getLoginSessionState.maybeWhen(
          success: (isLoggedIn) {
            _onSuccessGetLoginSession(context, isLoggedIn);
          },
          failure: (failure) => RouteUtils.goToOnboardingPage(context),
          orElse: () => null,
        );
      },
      child: MyScaffold(
        body: Center(
          child: Icon(
            Icons.flutter_dash_rounded,
            color: context.colorScheme.primary,
            size: Sizes.width100,
          ),
        ),
      ),
    );
  }

  void _onSuccessGetLoginSession(BuildContext context, bool isLoggedIn) {
    if (isLoggedIn) {
      RouteUtils.goToHomePage(context);
    } else {
      RouteUtils.goToOnboardingPage(context);
    }
  }
}
