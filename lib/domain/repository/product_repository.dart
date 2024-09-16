import 'package:fpdart/fpdart.dart';

import '../core/unions/failure.dart';
import '../model/product.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<Product>>> fetchProducts({
    required int offset,
    required String productName,
  });
}
