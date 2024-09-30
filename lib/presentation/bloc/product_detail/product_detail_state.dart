part of 'product_detail_bloc.dart';

@freezed
class ProductDetailState with _$ProductDetailState {
  const factory ProductDetailState({
    required ResultState<ProductDetail> fetchProductDetailState,
  }) = _Initial;
  factory ProductDetailState.initial() => const ProductDetailState(
        fetchProductDetailState: ResultState.initial(),
      );
}
