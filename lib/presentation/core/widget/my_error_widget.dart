import 'package:flutter/material.dart';
import 'package:flutter_starter_boilerplate/common.dart';
import 'package:flutter_starter_boilerplate/core/extention/context_extention.dart';

import '../../../domain/core/unions/failure.dart';
import '../style/sizes.dart';

class MyErrorWidget extends StatelessWidget {
  final Failure failure;
  final Function() onPressRetry;
  const MyErrorWidget({
    Key? key,
    required this.failure,
    required this.onPressRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final message = Failure.getErrorMessage(failure);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          SizedBox(
            height: Sizes.height16,
          ),
          ElevatedButton(
            onPressed: () {
              onPressRetry.call();
            },
            child: Text(context.localization.retry),
          ),
        ],
      ),
    );
  }
}
