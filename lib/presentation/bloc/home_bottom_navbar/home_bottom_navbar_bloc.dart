import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'home_bottom_navbar_bloc.freezed.dart';
part 'home_bottom_navbar_event.dart';
part 'home_bottom_navbar_state.dart';

@injectable
class HomeBottomNavbarBloc
    extends Bloc<HomeBottomNavbarEvent, HomeBottomNavbarState> {
  HomeBottomNavbarBloc() : super(HomeBottomNavbarState.initial()) {
    on<_MenuItemClicked>(_onMenuItemClicked);
  }
  void _onMenuItemClicked(
      _MenuItemClicked event, Emitter<HomeBottomNavbarState> emit) {
    emit(state.copyWith(
      currentMenuIndex: event.index,
    ));
  }
}
