import 'package:fpdart/fpdart.dart';

import '../core/unions/failure.dart';
import '../model/product.dart';
import '../model/product_detail.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> fetchProducts({
    required int offset,
    required String productName,
  });

  Future<Either<Failure, ProductDetail>> fetchProductDetail({
    required String id,
  });
}
