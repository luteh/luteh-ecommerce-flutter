import 'package:flutter/material.dart';

import '../style/sizes.dart';

class DotIndicator extends StatelessWidget {
  final int length;
  final int currentIndex;
  final EdgeInsetsGeometry? padding;
  const DotIndicator({
    super.key,
    required this.length,
    required this.currentIndex,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: kThemeAnimationDuration,
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          length,
          (index) => Padding(
            padding: EdgeInsets.symmetric(
              horizontal: Sizes.width4,
            ),
            child: CircleAvatar(
              radius: index == currentIndex ? Sizes.radius5 : Sizes.radius3,
              backgroundColor:
                  index == currentIndex ? Colors.blue : Colors.grey[300],
            ),
          ),
        ),
      ),
    );
  }
}
