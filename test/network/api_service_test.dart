import 'dart:async';
import 'package:flutter_assessment/network/api_service.dart';
import 'package:flutter_assessment/network/api_endpoints.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ApiService Timeout', () {
    test('get request throws TimeoutException when timeout is exceeded', () async {
      final apiService = ApiService('https://example.com'); // Using unreachable host to test timeout logic

      expect(
        apiService.get(
          ApiEndpoint.forecast, 
          timeout: const Duration(milliseconds: 1),
        ),
        throwsA(isA<TimeoutException>()),
      );
    });
  });
}
