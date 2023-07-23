part of 'home_bottom_navbar_bloc.dart';

@freezed
class HomeBottomNavbarState with _$HomeBottomNavbarState {
  const factory HomeBottomNavbarState({
    required int currentMenuIndex,
  }) = _HomeBottomNavbarState;
  factory HomeBottomNavbarState.initial() => const HomeBottomNavbarState(
        currentMenuIndex: 0,
      );
}
