import 'package:http/http.dart' as http;

class NetworkClient extends http.BaseClient {
  static const scheme = "https";
  static const host = "api.behance.net";
  static const apiKeyParameterName = "api_key";
  static const apiKey = "sli5bnTgZa61bnjiTDkk2lAJjJiA6G92";

  final http.Client _inner = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    final uri = request.url;
    final Map<String, dynamic> queryParameters =
        Map.from(request.url.queryParameters);
    queryParameters[apiKeyParameterName] = apiKey;
    final decoratedUri = Uri(
      scheme: scheme,
      host: host,
      path: uri.path,
      queryParameters: queryParameters,
    );
    final decoratedRequest = http.Request(request.method, decoratedUri);
    print(decoratedUri.toString()); //TODO remove
    return _inner.send(decoratedRequest);
  }
}
