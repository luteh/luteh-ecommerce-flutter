import 'package:flutter/material.dart';

import '../../../core/extention/context_extention.dart';
import '../../core/widget/my_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      appBar: AppBar(
        title: Text(context.localization.home),
      ),
      body: const Placeholder(),
    );
  }
}
