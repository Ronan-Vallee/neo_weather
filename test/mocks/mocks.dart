import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'package:neo_weather/api/open_weather_api_client.dart';

class MockHTTPClient extends Mock implements http.Client {}

class MockUri extends Mock implements Uri {}

class MockOpenWeatherApiClient extends Mock implements OpenWeatherAPIClient {}
