import 'package:flutter/material.dart';

import 'home_bottom_nav_bar.dart';

class HomeBottomNavBarScaffold extends StatelessWidget {
  final Widget child;
  const HomeBottomNavBarScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: const HomeBottomNavBar(),
    );
  }
}
