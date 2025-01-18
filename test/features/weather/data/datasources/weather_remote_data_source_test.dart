import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neo_weather/core/errors/exceptions.dart';
import 'package:neo_weather/features/weather/data/datasources/weather_remote_data_source.dart';
import '../../../../mocks/mocks.dart';
import '../../test_models/weather_models.dart';

void main() {
  late WeatherRemoteDataSource dataSource;
  late MockOpenWeatherApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockOpenWeatherApiClient();
    dataSource = WeatherRemoteDataSource(apiClient: mockApiClient);
  });

  group('get', () {
    const double tLatitude = 1.0;
    const double tLongitude = 32.0;

    test(
      'should return a WeatherModel when the call to '
      'OpenWeatherApiClient is successful.',
      () async {
        // arrange
        when(
          () => mockApiClient.getWeatherData(
            latitude: tLatitude,
            longitude: tLongitude,
          ),
        ).thenAnswer((_) async => tWeatherModelJSON);

        // act
        final result = await dataSource.get(tLatitude, tLongitude);

        // assert
        verify(
          () => mockApiClient.getWeatherData(
            latitude: tLatitude,
            longitude: tLongitude,
          ),
        );
        expect(result, tWeatherModel);
      },
    );

    test(
      'should throw an exception when the call to '
      'OpenWeatherApiClient is unsuccessful.',
      () async {
        // arrange
        when(
          () => mockApiClient.getWeatherData(
            latitude: tLatitude,
            longitude: tLongitude,
          ),
        ).thenThrow(ServerException());

        // act
        final call = dataSource.get(tLatitude, tLongitude);

        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      },
    );
  });
}
