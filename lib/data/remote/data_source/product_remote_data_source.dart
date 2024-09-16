import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';

import '../graphql/product.graphql.dart';

@lazySingleton
class ProductRemoteDataSource {
  final GraphQLClient graphQlClient;

  ProductRemoteDataSource(this.graphQlClient);

  Future<List<Query$GetProducts$getProducts$products>> fetchProducts({
    required int offset,
    required String productName,
  }) async {
    final result =
        await graphQlClient.query$GetProducts(Options$Query$GetProducts(
            variables: Variables$Query$GetProducts(
      limit: 20,
      offset: offset,
      productName: productName,
    )));

    if (result.hasException) {
      throw Exception(result.exception.toString());
    }

    if (result.parsedData?.getProducts?.products == null) {
      throw Exception('Failed to get products');
    }

    return result.parsedData!.getProducts!.products!
        .map((e) => e!)
        .toList(growable: false);
  }
}
