import 'package:flutter/material.dart';

import 'route_extension.dart';
import 'route_name.dart';

class RouteUtils {
  const RouteUtils._();

  static void goToOnboardingPage(BuildContext context) =>
      context.go(RouteName.onboarding);
  static void goToLoginPage(BuildContext context) =>
      context.go(RouteName.login);
  static void goToHomePage(BuildContext context) => context.go(RouteName.home);
}
