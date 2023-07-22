import 'package:flutter/material.dart';

class MyScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? floatingActionButton;
  const MyScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: body,
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
