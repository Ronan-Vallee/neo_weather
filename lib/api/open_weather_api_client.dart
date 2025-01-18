import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:neo_weather/api/api_keys.dart';
import '../../../core/errors/exceptions.dart';

class OpenWeatherAPIClient {
  final http.Client client;
  static const String baseUrl = 'api.openweathermap.org';

  OpenWeatherAPIClient({required this.client});

  Future<T> get<T>({
    required String endpoint,
    required Map<String, String> queryParameters,
  }) async {
    try {
      final uri = Uri.https(
        baseUrl,
        endpoint,
        {
          ...queryParameters,
          'appid': APIKeys.openWeatherAPIKey,
          'lang': 'fr',
          'units': 'metric',
        },
      );

      final response = await client.get(uri);

      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw ServerException();
      }
    } on SocketException {
      throw InternetConnectionException();
    } catch (_) {
      throw ServerException();
    }
  }

  Future<Map<String, dynamic>> getWeatherData({
    required double latitude,
    required double longitude,
  }) async {
    return get(
      endpoint: '/data/3.0/onecall',
      queryParameters: {
        'lat': latitude.toString(),
        'lon': longitude.toString(),
      },
    );
  }
}
