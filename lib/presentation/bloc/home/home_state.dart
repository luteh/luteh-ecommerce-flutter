part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    required ResultState<List<Product>> fetchProductsState,
    required ResultState<List<Product>> fetchMoreProductsState,
    required bool hasReachedEnd,
  }) = _HomeState;
  factory HomeState.initial() => const HomeState(
        fetchProductsState: ResultState.initial(),
        fetchMoreProductsState: ResultState.initial(),
        hasReachedEnd: false,
      );
}
