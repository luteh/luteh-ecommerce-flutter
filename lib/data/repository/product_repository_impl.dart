import 'dart:math';

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';

import '../../domain/core/unions/failure.dart';
import '../../domain/model/product.dart';
import '../../domain/model/product_detail.dart';
import '../../domain/model/product_review.dart';
import '../../domain/repository/product_repository.dart';
import '../remote/data_source/product_remote_data_source.dart';

@LazySingleton(as: ProductRepository)
class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource _productRemoteDataSource;

  ProductRepositoryImpl(this._productRemoteDataSource);

  @override
  Future<Either<Failure, List<Product>>> fetchProducts({
    required int offset,
    required String productName,
  }) async {
    try {
      final data = await _productRemoteDataSource.fetchProducts(
        offset: offset,
        productName: productName,
      );
      return right(data
          .map((e) => Product(
                id: e.id,
                name: e.name,
                price: e.price,
                shopName: e.shopName,
                thumbnailImageUrl: e.thumbnailImageUrl,
                rating: e.rating ?? 0,
                ratingCount: e.ratingCount ?? 0,
              ))
          .toList(growable: false));
    } on Exception catch (e) {
      return left(Failure.defaultError(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProductDetail>> fetchProductDetail(
      {required String id}) async {
    try {
      final data = await _productRemoteDataSource.fetchProductDetail(
        id: id,
      );
      return right(ProductDetail(
        id: data.id,
        name: data.name,
        price: data.price,
        shopName: data.shopName,
        rating: data.rating ?? 0,
        ratingCount: data.ratingCount ?? 0,
        description: data.description,
        productImageUrls: data.productImageUrls?.map((e) => e!).toList() ?? [],
        reviews: List.generate(
            Random().nextInt(4) + 1, (index) => ProductReview.dummy),
      ));
    } on Exception catch (e) {
      return left(Failure.defaultError(error: e.toString()));
    }
  }
}
