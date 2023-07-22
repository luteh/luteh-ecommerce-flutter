import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/extention/context_extention.dart';
import '../../../bloc/onboarding/onboarding_bloc.dart';

class OnboardingFooter extends StatelessWidget {
  const OnboardingFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Visibility(
          visible: context
              .select((OnboardingBloc bloc) => bloc.state.currentIndex > 0),
          maintainAnimation: true,
          maintainSize: true,
          maintainState: true,
          child: TextButton(
            onPressed: () {
              context
                  .read<OnboardingBloc>()
                  .add(const OnboardingEvent.previousButtonClicked());
            },
            child: Text(
              context.localization.previous,
            ),
          ),
        ),
        TextButton(
          onPressed: () {
            context
                .read<OnboardingBloc>()
                .add(const OnboardingEvent.nextButtonClicked());
          },
          child: Text(
            context.localization.next,
          ),
        ),
      ],
    );
  }
}
