import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import '../../local/data_source/local_data_source.dart';

@lazySingleton
class MyClient extends http.BaseClient {
  final http.Client _client;
  final LocalDataSource _localDataSource;

  MyClient(this._client, this._localDataSource);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    final accessToken = _localDataSource.getAccessToken();
    if (accessToken.isNotEmpty) {
      request.headers['token'] = accessToken;
    }

    return _client.send(request);
  }

  @override
  void close() {
    _client.close();

    super.close();
  }
}
