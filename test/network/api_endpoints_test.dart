import 'package:flutter_assessment/network/api_endpoints.dart';
import 'package:flutter_assessment/network/constants.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiEndpoint', () {
    test('path returns correct string', () {
      expect(ApiEndpoint.forecast.path, '/data/2.5/forecast');
    });

    test('buildUri returns correct Uri', () {
      final uri = ApiEndpoint.forecast.buildUri(
        baseUrl: Constants.baseUrl,
        queryParams: {'q': 'Lagos'},
      );

      expect(uri.toString(), contains(Constants.baseUrl));
      expect(uri.toString(), contains('/data/2.5/forecast'));
      expect(uri.queryParameters['q'], 'Lagos');
    });
  });
}
