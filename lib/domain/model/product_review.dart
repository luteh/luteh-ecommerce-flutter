import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';

import '../../core/dummy_generator.dart';

part 'product_review.freezed.dart';

@freezed
class ProductReview with _$ProductReview {
  const ProductReview._();
  const factory ProductReview({
    required String id,
    required String userName,
    required String userProfileUrl,
    required String comment,
    required double rating,
    required List<String> reviewImageUrls,
    required String createdAt,
  }) = _ProductReview;

  double get formattedRating {
    final formatter = NumberFormat('#.#');
    return double.parse(formatter.format(rating));
  }

  static ProductReview get dummy => ProductReview(
        id: '1',
        userProfileUrl: 'https://placehold.co/50.jpg',
        userName: DummyGenerator.generateLoremIpsum(2),
        comment: DummyGenerator.generateLoremIpsum(Random().nextInt(20) + 10),
        rating: Random(1).nextDouble() * 6,
        createdAt: DummyGenerator.generateRandomDate(),
        reviewImageUrls: List.generate(Random().nextInt(10) + 1,
            (index) => 'https://placehold.co/100.jpg'),
      );
}
