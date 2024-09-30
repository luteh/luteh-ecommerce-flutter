import 'package:freezed_annotation/freezed_annotation.dart';

import 'product_review.dart';

part 'product_detail.freezed.dart';

@freezed
class ProductDetail with _$ProductDetail {
  const factory ProductDetail({
    required String id,
    required String name,
    required double price,
    required String shopName,
    required double rating,
    required int ratingCount,
    required String description,
    required List<String> productImageUrls,
    required List<ProductReview> reviews,
  }) = _ProductDetail;
}
