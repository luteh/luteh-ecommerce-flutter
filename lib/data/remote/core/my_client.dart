import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

@lazySingleton
class MyClient extends http.BaseClient {
  final http.Client _client;

  MyClient(this._client);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    // TODO: intercept request here
    // if (request.headers['authorization'] == null) {
    //   // add authorization header if it isn't exists
    //   final accessToken = await getAccessToken();
    //   if (accessToken != null) {
    //     request.headers['authorization'] = 'Bearer $accessToken';
    //   }
    // }

    return _client.send(request);
  }

  @override
  void close() {
    _client.close();

    super.close();
  }
}
