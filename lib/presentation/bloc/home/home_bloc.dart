import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

import '../../../domain/core/unions/result_state.dart';
import '../../../domain/model/product.dart';
import '../../../domain/repository/product_repository.dart';

part 'home_bloc.freezed.dart';
part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ProductRepository _productRepository;

  int _offset = 0;
  String _productName = '';

  HomeBloc(this._productRepository) : super(HomeState.initial()) {
    on<_Started>(_onStarted);
    on<_RetryFetchProductsButtonClicked>((event, emit) => _fetchProducts(emit));
    on<_RetryFetchMoreProductsButtonClicked>(
        (event, emit) => _fetchMoreProducts(emit));
    on<_FetchMoreProduct>((event, emit) => _fetchMoreProducts(emit));
    on<_SearchFieldChanged>(_changeSearchValue,
        transformer: debounce(const Duration(milliseconds: 500)));
    on<_RefreshProductsIndicatorDragged>(_onRefreshProductsIndicatorDragged);
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  void _onStarted(_Started event, Emitter<HomeState> emit) async {
    await _fetchProducts(emit);
  }

  Future<void> _fetchProducts(Emitter<HomeState> emit) async {
    emit(state.copyWith(fetchProductsState: const ResultState.loading()));

    final result = await _productRepository.fetchProducts(
      offset: _offset,
      productName: _productName,
    );
    result.fold(
      (l) => emit(
          state.copyWith(fetchProductsState: ResultState.failure(failure: l))),
      (r) {
        emit(state.copyWith(
          fetchProductsState: ResultState.success(data: r),
          hasReachedEnd: r.length < 20,
        ));
        _offset += r.length;
      },
    );
  }

  Future<void> _fetchMoreProducts(Emitter<HomeState> emit) async {
    if (state.hasReachedEnd || state.fetchMoreProductsState.isLoading) return;

    emit(state.copyWith(fetchMoreProductsState: const ResultState.loading()));

    final result = await _productRepository.fetchProducts(
      offset: _offset,
      productName: _productName,
    );
    result.fold(
      (l) => emit(state.copyWith(
          fetchMoreProductsState: ResultState.failure(failure: l))),
      (r) {
        emit(state.copyWith(
          fetchMoreProductsState: ResultState.success(data: r),
          fetchProductsState: ResultState.success(
              data: state.fetchProductsState.getOrNull()! + r),
          hasReachedEnd: r.length < 20,
        ));
        _offset += r.length;
      },
    );
  }

  void _changeSearchValue(
      _SearchFieldChanged event, Emitter<HomeState> emit) async {
    _productName = event.value;
    _offset = 0;
    await _fetchProducts(emit);
  }

  void _onRefreshProductsIndicatorDragged(
      _RefreshProductsIndicatorDragged event, Emitter<HomeState> emit) async {
    _offset = 0;
    await _fetchProducts(emit);
  }
}
