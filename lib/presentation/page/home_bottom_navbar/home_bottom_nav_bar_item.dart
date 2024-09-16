import 'package:flutter/material.dart';

class HomeBottomNavBarItem extends BottomNavigationBarItem {
  const HomeBottomNavBarItem(
      {required this.routeName, required super.icon, super.label});

  final String routeName;
}
