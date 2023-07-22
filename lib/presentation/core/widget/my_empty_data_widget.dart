import 'package:flutter/material.dart';

import '../../../core/extention/context_extention.dart';

class MyEmptyDataWidget extends StatelessWidget {
  final String text;
  const MyEmptyDataWidget({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: context.textTheme.bodyMedium,
      ),
    );
  }
}
