import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:neo_weather/api/api_keys.dart';
import 'package:neo_weather/api/open_weather_api_client.dart';
import 'package:neo_weather/core/errors/exceptions.dart';

import '../mocks/mocks.dart';

void main() {
  late OpenWeatherAPIClient apiClient;
  late MockHTTPClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHTTPClient();
    apiClient = OpenWeatherAPIClient(client: mockHttpClient);

    registerFallbackValue(MockUri());
  });

  group('get', () {
    const tEndpoint = '/data/3.0/onecall';
    final tQueryParameters = {'lat': '10.0', 'lon': '12.0'};
    final tURI = Uri.https(
      OpenWeatherAPIClient.baseUrl,
      tEndpoint,
      {
        ...tQueryParameters,
        'appid': APIKeys.openWeatherAPIKey,
        'lang': 'fr',
        'units': 'metric',
      },
    );

    test(
      'should return data when the http call completes successfully.',
      () async {
        final response = json.encode({'key': 'value'});
        when(() => mockHttpClient.get(tURI)).thenAnswer(
          (_) async => http.Response(response, 200),
        );

        final result = await apiClient.get(
          endpoint: tEndpoint,
          queryParameters: tQueryParameters,
        );

        expect(result, json.decode(response));
      },
    );

    test(
      'should throw an InternetConnectionException when the http call '
      'throws a SocketException.',
      () async {
        when(() => mockHttpClient.get(tURI)).thenThrow(
          const SocketException('No internet'),
        );

        expect(
          () => apiClient.get(
            endpoint: tEndpoint,
            queryParameters: tQueryParameters,
          ),
          throwsA(isA<InternetConnectionException>()),
        );
      },
    );

    test(
      'should throw a ServerException when the http call throws an error.',
      () async {
        when(() => mockHttpClient.get(tURI)).thenAnswer(
          (_) async => http.Response('', 429),
        );

        expect(
          () => apiClient.get(
            endpoint: tEndpoint,
            queryParameters: tQueryParameters,
          ),
          throwsA(isA<ServerException>()),
        );
      },
    );
  });

  group('getWeatherData', () {
    test(
      'should call get with correct parameters',
      () async {
        final response = json.encode({'key': 'value'});
        when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => http.Response(response, 200),
        );

        final result = await apiClient.getWeatherData(
          latitude: 10.0,
          longitude: 10.0,
        );

        expect(result, json.decode(response));
        verify(() => mockHttpClient.get(any())).called(1);
      },
    );
  });

  group('searchCities', () {
    const tQuery = 'Paris';
    final tQueryParameters = {'q': tQuery, 'limit': '10'};
    final tURI = Uri.https(
      OpenWeatherAPIClient.baseUrl,
      '/geo/1.0/direct',
      {
        ...tQueryParameters,
        'appid': APIKeys.openWeatherAPIKey,
        'lang': 'fr',
        'units': 'metric',
      },
    );

    test(
      'should return a list of cities when the http call completes successfully.',
      () async {
        // arrange
        final response = json.encode([
          {
            'name': 'Paris',
            'state': 'Ile-de-France',
            'country': 'FR',
            'lat': 48.8566,
            'lon': 2.3522,
          },
          {
            'name': 'Paris',
            'state': 'Ile-de-France',
            'country': 'FR',
            'lat': 48.4526,
            'lon': 2.1522,
          },
        ]);
        when(() => mockHttpClient.get(tURI)).thenAnswer(
          (_) async => http.Response(response, 200),
        );

        // act
        final result = await apiClient.searchCities(tQuery);

        // assert
        expect(result, json.decode(response));
        expect(result, isA<List>());
      },
    );
  });

  group('searchCitiesFromLocation', () {
    const tLatitude = 48.8566;
    const tLongitude = 2.3522;
    final tQueryParameters = {
      'lat': tLatitude.toString(),
      'lon': tLongitude.toString(),
      'limit': '5',
    };
    final tURI = Uri.https(
      OpenWeatherAPIClient.baseUrl,
      '/geo/1.0/reverse',
      {
        ...tQueryParameters,
        'appid': APIKeys.openWeatherAPIKey,
        'lang': 'fr',
        'units': 'metric',
      },
    );

    test(
      'should return a list of cities when the http call completes successfully.',
      () async {
        // arrange
        final response = json.encode([
          {
            'name': 'Paris',
            'state': 'Ile-de-France',
            'country': 'FR',
            'lat': 48.8566,
            'lon': 2.3522,
          },
          {
            'name': 'Paris',
            'state': 'Ile-de-France',
            'country': 'FR',
            'lat': 48.4526,
            'lon': 2.1522,
          },
        ]);
        when(() => mockHttpClient.get(tURI)).thenAnswer(
          (_) async => http.Response(response, 200),
        );

        // act
        final result =
            await apiClient.searchCitiesFromLocation(tLatitude, tLongitude);

        // assert
        expect(result, json.decode(response));
        expect(result, isA<List>());
      },
    );

    test(
      'should throw an InternetConnectionException when '
      'the http call throws a SocketException.',
      () async {
        when(() => mockHttpClient.get(tURI)).thenThrow(
          const SocketException('No internet'),
        );

        expect(
          () => apiClient.searchCitiesFromLocation(tLatitude, tLongitude),
          throwsA(isA<InternetConnectionException>()),
        );
      },
    );

    test(
      'should throw a ServerException when the http call throws an error.',
      () async {
        when(() => mockHttpClient.get(tURI)).thenAnswer(
          (_) async => http.Response('', 429),
        );

        expect(
          () => apiClient.searchCitiesFromLocation(tLatitude, tLongitude),
          throwsA(isA<ServerException>()),
        );
      },
    );
  });
}
