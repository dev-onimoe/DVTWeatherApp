import 'dart:convert';
import 'dart:io';

import 'api_endpoints.dart';

class ApiService {
  final String baseUrl;

  ApiService(this.baseUrl);

  Future<Map<String, dynamic>> get(
      ApiEndpoint endpoint, {
        Map<String, String>? params,
      }) async {
    final client = HttpClient();

    try {
      final uri = endpoint.buildUri(
        baseUrl: baseUrl,
        queryParams: params,
      );

      final request = await client.getUrl(uri);
      final response = await request.close();

      final responseBody = await response.transform(utf8.decoder).join();

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