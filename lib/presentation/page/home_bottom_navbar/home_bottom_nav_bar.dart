import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extention/context_extention.dart';
import '../../bloc/home_bottom_navbar/home_bottom_navbar_bloc.dart';
import '../../route/route_name.dart';
import 'home_bottom_nav_bar_item.dart';

class HomeBottomNavBar extends StatelessWidget {
  const HomeBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final navBarItems = [
      HomeBottomNavBarItem(
        icon: const Icon(Icons.home_rounded),
        label: context.localization.home,
        routeName: RouteName.home,
      ),
      HomeBottomNavBarItem(
        icon: const Icon(Icons.account_circle_rounded),
        label: context.localization.profile,
        routeName: RouteName.profile,
      ),
    ];

    return BlocListener<HomeBottomNavbarBloc, HomeBottomNavbarState>(
      listenWhen: (previous, current) =>
          previous.currentMenuIndex != current.currentMenuIndex,
      listener: (context, state) {
        context.go(navBarItems[state.currentMenuIndex].routeName);
      },
      child: BottomNavigationBar(
        currentIndex: context
            .select((HomeBottomNavbarBloc bloc) => bloc.state.currentMenuIndex),
        onTap: (value) {
          context
              .read<HomeBottomNavbarBloc>()
              .add(HomeBottomNavbarEvent.menuItemClicked(value));
        },
        items: navBarItems,
      ),
    );
  }
}
