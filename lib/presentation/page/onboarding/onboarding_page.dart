import 'package:flutter/material.dart';

import '../../core/widget/my_scaffold.dart';
import 'widget/onboarding_footer.dart';
import 'widget/onboarding_page_view.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MyScaffold(
      body: Column(
        children: [
          Expanded(
            child: OnboardingPageView(),
          ),
          OnboardingFooter(),
        ],
      ),
    );
  }
}
