part of 'home_bottom_navbar_bloc.dart';

@freezed
class HomeBottomNavbarEvent with _$HomeBottomNavbarEvent {
  const factory HomeBottomNavbarEvent.menuItemClicked(int index) =
      _MenuItemClicked;
}
