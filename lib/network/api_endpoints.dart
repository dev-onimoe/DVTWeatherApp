import 'package:flutter_assessment/network/constants.dart';

enum ApiEndpoint {
  forecast;

  String get path {
    switch (this) {
      case ApiEndpoint.forecast:
        return '/data/2.5/forecast';
    }
  }

  Uri buildUri({
    required String baseUrl,
    Map<String, String>? queryParams,
  }) {
    return Uri.parse(Constants.BASE_URL + path).replace(queryParameters: queryParams);
  }
}