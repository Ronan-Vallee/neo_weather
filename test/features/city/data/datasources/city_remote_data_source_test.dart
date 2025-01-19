import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neo_weather/core/errors/exceptions.dart';
import 'package:neo_weather/features/city/data/datasources/city_remote_data_source.dart';

import '../../../../mocks/mocks.dart';
import '../../test_models/city_models.dart';

void main() {
  late CityRemoteDataSource dataSource;
  late MockOpenWeatherApiClient mockAPIClient;

  setUp(() {
    mockAPIClient = MockOpenWeatherApiClient();
    dataSource = CityRemoteDataSource(apiClient: mockAPIClient);
  });

  group('get', () {
    const tCityToSearch = 'Paris';

    test(
      'should return a list of CityModel when the call to apiClient is successful.',
      () async {
        // arrange
        when(() => mockAPIClient.searchCities(any())).thenAnswer(
          (_) async => [
            {
              'name': 'Paris',
              'country': 'FR',
              'state': 'Ile-de-France',
              'lat': 48.8566,
              'lon': 2.3522,
            }
          ],
        );

        // act
        final result = await dataSource.get(tCityToSearch);

        // assert
        expect(result, [tCityModel]);
        verify(() => mockAPIClient.searchCities(tCityToSearch)).called(1);
      },
    );

    test(
      'should throw an exception when the call to apiClient is unsuccessful.',
      () async {
        // arrange
        when(() => mockAPIClient.searchCities(any()))
            .thenThrow(ServerException());

        // assert
        expect(() => dataSource.get(tCityToSearch),
            throwsA(isA<ServerException>()));
        verify(() => mockAPIClient.searchCities(tCityToSearch)).called(1);
      },
    );
  });
}
