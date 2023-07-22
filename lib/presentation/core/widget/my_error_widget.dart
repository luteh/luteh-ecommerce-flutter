import 'package:flutter/material.dart';

import '../../../core/extention/context_extention.dart';
import '../style/sizes.dart';

class MyErrorWidget extends StatelessWidget {
  final String text;
  final Function() onTapRetry;
  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  const MyErrorWidget({
    super.key,
    required this.text,
    required this.onTapRetry,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: crossAxisAlignment,
        mainAxisAlignment: mainAxisAlignment,
        children: [
          Text(
            text,
            style: context.textTheme.bodyMedium,
          ),
          SizedBox(height: Sizes.height8),
          ElevatedButton(
            onPressed: () {
              onTapRetry();
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                vertical: Sizes.height16,
              ),
            ),
            child: Text(context.localization.retry),
          ),
        ],
      ),
    );
  }
}
