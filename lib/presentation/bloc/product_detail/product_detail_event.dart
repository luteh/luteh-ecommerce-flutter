part of 'product_detail_bloc.dart';

@freezed
class ProductDetailEvent with _$ProductDetailEvent {
  const factory ProductDetailEvent.started(String productId) = _Started;
  const factory ProductDetailEvent.refreshButtonClicked() =
      _RefreshButtonClicked;
}
