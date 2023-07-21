import '../page/home/home_page.dart';
import '../page/login/login_page.dart';
import 'package:go_router/go_router.dart';
import '../page/onboarding/onboarding_page.dart';
import '../page/splash/splash_page.dart';
import 'route_name.dart';

final routers = GoRouter(
  initialLocation: RouteName.splashPage,
  routes: [
    GoRoute(
      path: RouteName.splashPage,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: RouteName.onboarding,
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: RouteName.login,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: RouteName.home,
      builder: (context, state) => const HomePage(),
    ),
  ],
  debugLogDiagnostics: true,
);