part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.started() = _Started;
  const factory HomeEvent.refreshProductsIndicatorDragged() =
      _RefreshProductsIndicatorDragged;
  const factory HomeEvent.retryFetchProductsButtonClicked() =
      _RetryFetchProductsButtonClicked;
  const factory HomeEvent.retryFetchMoreProductsButtonClicked() =
      _RetryFetchMoreProductsButtonClicked;
  const factory HomeEvent.fetchMoreProduct() = _FetchMoreProduct;
  const factory HomeEvent.searchFieldChanged(String value) =
      _SearchFieldChanged;
}
