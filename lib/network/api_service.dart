import 'dart:convert';
import 'dart:io';

import 'api_endpoints.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<Map<String, dynamic>> get(
      ApiEndpoint endpoint, {
        Map<String, String>? params,
        Duration timeout = const Duration(seconds: 60),
      }) async {
    final client = HttpClient();
    client.connectionTimeout = timeout;

    try {
      final uri = endpoint.buildUri(
        baseUrl: baseUrl,
        queryParams: params,
      );

      final request = await client.getUrl(uri).timeout(timeout);
      final response = await request.close().timeout(timeout);

      final responseBody = await response.transform(utf8.decoder).join().timeout(timeout);

      if (response.statusCode != 200) {
        throw HttpException(
          'Request failed: ${response.statusCode}',
          uri: uri,
        );
      }

      return jsonDecode(responseBody);
    } finally {
      client.close();
    }
  }
}