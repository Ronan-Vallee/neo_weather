import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neo_weather/features/city/data/datasources/city_local_data_source.dart';

import '../../mocks/city_mocks.dart';
import '../../test_models/city_models.dart';

void main() {
  late CityLocalDataSource dataSource;
  late MockCityBox mockCityBox;

  setUp(() {
    mockCityBox = MockCityBox();
    dataSource = CityLocalDataSource(cityBox: mockCityBox);
  });

  group('getSavedCities', () {
    test(
      'should return a list of city maps when there are saved cities.',
      () async {
        // arrange
        when(() => mockCityBox.values)
            .thenReturn([json.encode(tCityModelJSON)]);

        // act
        final result = await dataSource.getSavedCities();

        // assert
        expect(result, [tCityModelJSON]);
        verify(() => mockCityBox.values).called(1);
      },
    );

    test(
      'should return an empty list when there are no saved cities and return unit.',
      () async {
        // arrange
        when(() => mockCityBox.values).thenReturn([]);

        // act
        final result = await dataSource.getSavedCities();

        // assert
        expect(result, []);
        verify(() => mockCityBox.values).called(1);
      },
    );
  });

  group('saveCity', () {
    test(
      'should call put on the hive box to save the city and return unit.',
      () async {
        // arrange
        final cityData = {
          'name': 'Paris',
          'state': 'Ile-de-France',
          'lat': 48.8566,
          'lon': 2.3522,
        };
        final cityJson = json.encode(cityData);
        when(() => mockCityBox.put(any(), any())).thenAnswer((_) async {});

        // act
        final result = await dataSource.saveCity(cityData);

        // assert
        expect(result, unit);
        verify(() => mockCityBox.put('Paris,Ile-de-France', cityJson))
            .called(1);
      },
    );
  });

  group('removeCity', () {
    test(
      'should call delete on the hive box to remove the city.',
      () async {
        // arrange
        when(() => mockCityBox.delete(any())).thenAnswer((_) async {});

        // act
        final result = await dataSource.removeCity('Paris,Ile-de-France');

        // assert
        expect(result, unit);
        verify(() => mockCityBox.delete('Paris,Ile-de-France')).called(1);
      },
    );
  });
}
