import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/core/unions/result_state.dart';
import '../../../domain/model/product_detail.dart';
import '../../../domain/repository/product_repository.dart';

part 'product_detail_bloc.freezed.dart';
part 'product_detail_event.dart';
part 'product_detail_state.dart';

@injectable
class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductRepository _productRepository;

  String _productId = '';

  ProductDetailBloc(this._productRepository)
      : super(ProductDetailState.initial()) {
    on<ProductDetailEvent>((event, emit) async {
      await event.when(
        started: (productId) async => await _onStarted(emit, productId),
        refreshButtonClicked: () async =>
            await _fetchProductDetail(emit, _productId),
      );
    });
  }

  Future<void> _onStarted(
      Emitter<ProductDetailState> emit, String productId) async {
    _productId = productId;
    await _fetchProductDetail(emit, productId);
  }

  Future<void> _fetchProductDetail(
      Emitter<ProductDetailState> emit, String productId) async {
    emit(state.copyWith(fetchProductDetailState: const ResultState.loading()));
    final result = await _productRepository.fetchProductDetail(id: productId);
    result.fold(
      (l) {
        emit(state.copyWith(
            fetchProductDetailState: ResultState.failure(failure: l)));
      },
      (r) {
        emit(state.copyWith(
            fetchProductDetailState: ResultState.success(data: r)));
      },
    );
  }
}
