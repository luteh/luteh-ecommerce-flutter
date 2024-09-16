import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../di/injection_container.dart';
import '../bloc/home_bottom_navbar/home_bottom_navbar_bloc.dart';
import '../bloc/login/login_bloc.dart';
import '../bloc/onboarding/onboarding_bloc.dart';
import '../bloc/profile/profile_bloc.dart';
import '../bloc/splash/splash_bloc.dart';
import '../page/home/home_page.dart';
import '../page/home_bottom_navbar/home_bottom_navbar_scaffold.dart';
import '../page/login/login_page.dart';
import '../page/onboarding/onboarding_page.dart';
import '../page/profile/profile_page.dart';
import '../page/register_user/register_user_screen.dart';
import '../page/splash/splash_page.dart';
import 'route_name.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routers = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RouteName.splashPage,
  routes: [
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: RouteName.splashPage,
      builder: (context, state) => BlocProvider(
        create: (context) =>
            getIt.get<SplashBloc>()..add(const SplashEvent.started()),
        child: const SplashPage(),
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: RouteName.onboarding,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt.get<OnboardingBloc>(),
        child: const OnboardingPage(),
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: RouteName.login,
      builder: (context, state) => BlocProvider(
        create: (context) => getIt.get<LoginBloc>(),
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      parentNavigatorKey: _rootNavigatorKey,
      path: RouteName.registerUser,
      builder: (context, state) => const RegisterUserScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return BlocProvider(
          create: (context) => getIt.get<HomeBottomNavbarBloc>(),
          child: HomeBottomNavBarScaffold(child: child),
        );
      },
      routes: [
        GoRoute(
          path: RouteName.home,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: HomePage(),
          ),
        ),
        GoRoute(
          path: RouteName.profile,
          pageBuilder: (context, state) => NoTransitionPage(
            child: BlocProvider(
              create: (context) => getIt.get<ProfileBloc>(),
              child: const ProfilePage(),
            ),
          ),
        ),
      ],
    ),
  ],
  debugLogDiagnostics: true,
);
