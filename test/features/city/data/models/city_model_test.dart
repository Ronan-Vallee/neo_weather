import 'package:flutter_test/flutter_test.dart';
import 'package:neo_weather/features/city/data/models/city_model.dart';

import '../../test_models/city_models.dart';

void main() {
  group('CityModel', () {
    test(
      'should return a valid model when the JSON contains local names.',
      () {
        // act
        final result = CityModel.fromJson(tCityModelJSON);

        // assert
        expect(result, tCityModel);
      },
    );

    test(
      'should return a valid model when the JSON does not contain local names.',
      () {
        // arrange
        final tCityModelJSON = {
          'name': 'Paris',
          'lat': 48.8566,
          'lon': 2.3522,
          'country': 'FR',
          'state': 'Ile-de-France',
        };

        // act
        final result = CityModel.fromJson(tCityModelJSON);

        // assert
        expect(result, tCityModel);
      },
    );
  });
}
