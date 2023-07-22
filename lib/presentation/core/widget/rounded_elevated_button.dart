import 'package:flutter/material.dart';

import '../style/sizes.dart';

class RoundedElevatedButton extends StatelessWidget {
  final Function() onPressed;
  final String text;
  final bool enabled;
  const RoundedElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: enabled
          ? () {
              onPressed();
            }
          : null,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Sizes.radius50),
        ),
        padding: EdgeInsets.symmetric(
          vertical: Sizes.height16,
        ),
      ),
      child: Text(text),
    );
  }
}
