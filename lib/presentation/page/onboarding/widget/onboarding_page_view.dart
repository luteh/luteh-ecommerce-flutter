import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/onboarding/onboarding_bloc.dart';
import '../../../core/style/sizes.dart';
import '../../../core/widget/dot_indicator.dart';
import '../../../route/route_utils.dart';

class OnboardingPageView extends StatefulWidget {
  const OnboardingPageView({super.key});

  @override
  State<OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<OnboardingPageView> {
  final pageController = PageController();

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingBloc, OnboardingState>(
      listenWhen: (previous, current) =>
          previous.currentIndex != current.currentIndex,
      listener: (context, state) {
        if (state.currentIndex == state.itemCount) {
          RouteUtils.goToLoginPage(context);
          return;
        }
        pageController.animateToPage(
          state.currentIndex,
          duration: kThemeAnimationDuration,
          curve: Curves.ease,
        );
      },
      child: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: context.read<OnboardingBloc>().state.itemCount,
            onPageChanged: (value) {
              context
                  .read<OnboardingBloc>()
                  .add(OnboardingEvent.itemChanged(value));
            },
            itemBuilder: (context, index) {
              return Container(
                color: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                    .withOpacity(1.0),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: BlocSelector<OnboardingBloc, OnboardingState, int>(
              selector: (state) {
                return state.currentIndex;
              },
              builder: (context, currentIndex) {
                return DotIndicator(
                  length: context.read<OnboardingBloc>().state.itemCount,
                  currentIndex: currentIndex,
                  padding: EdgeInsets.only(
                    bottom: Sizes.height8,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
