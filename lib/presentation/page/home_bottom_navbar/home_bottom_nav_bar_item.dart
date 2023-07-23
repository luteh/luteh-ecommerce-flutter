import 'package:flutter/material.dart';

class HomeBottomNavBarItem extends BottomNavigationBarItem {
  const HomeBottomNavBarItem(
      {required this.routeName, required Widget icon, String? label})
      : super(icon: icon, label: label);

  final String routeName;
}
