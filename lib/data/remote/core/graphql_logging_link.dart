import 'dart:developer';

import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlLoggingLink extends Link {
  @override
  Stream<Response> request(Request request, [NextLink? forward]) {
    log('GraphQL Request: ${request.variables}');
    // log('GraphQL Request Body: ${operation.toKey()}');

    // Forward the request to the next link
    final response = forward?.call(request).asBroadcastStream();

    response?.listen((result) {
      if (result.errors?.isNotEmpty == true) {
        log('GraphQL Response Error: ${result.errors.toString()}');
      } else {
        log('GraphQL Response Data: ${result.data.toString()}');
      }
    });
    return response!;
  }
}
