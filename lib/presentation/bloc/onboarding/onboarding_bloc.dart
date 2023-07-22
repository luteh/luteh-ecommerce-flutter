import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'onboarding_bloc.freezed.dart';
part 'onboarding_event.dart';
part 'onboarding_state.dart';

@injectable
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(OnboardingState.initial()) {
    on<_NextButtonClicked>(_onNextButtonClicked);
    on<_PreviousButtonClicked>(_onPreviousButtonClicked);
    on<_SkipButtonClicked>(_onSkipButtonClicked);
    on<_ItemChanged>(_onItemChanged);
  }
  void _onNextButtonClicked(
      _NextButtonClicked event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(currentIndex: state.currentIndex + 1));
  }

  void _onPreviousButtonClicked(
      _PreviousButtonClicked event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(currentIndex: state.currentIndex - 1));
  }

  void _onSkipButtonClicked(
      _SkipButtonClicked event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(currentIndex: state.itemCount));
  }

  void _onItemChanged(_ItemChanged event, Emitter<OnboardingState> emit) {
    emit(state.copyWith(currentIndex: event.page));
  }
}
