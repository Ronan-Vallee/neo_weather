import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:neo_weather/core/errors/exceptions.dart';
import 'package:neo_weather/core/errors/failures.dart';
import 'package:neo_weather/features/city/data/repositories/city_repository.dart';
import 'package:neo_weather/features/city/domain/entities/city.dart';
import 'package:neo_weather/features/city/domain/usecases/get_saved_cities.dart';
import 'package:neo_weather/features/city/domain/usecases/remove_city.dart';
import 'package:neo_weather/features/city/domain/usecases/save_city.dart';
import 'package:neo_weather/features/city/domain/usecases/search.dart';

import '../../mocks/city_mocks.dart';
import '../../test_models/city_models.dart';

void main() {
  late CityRepository repository;
  late MockCityRemoteDataSource mockRemoteDataSource;
  late MockCityLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockCityRemoteDataSource();
    mockLocalDataSource = MockCityLocalDataSource();
    repository = CityRepository(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('search', () {
    const tCityToSearch = 'Paris';
    final tCityModelList = [tCityModel];

    test(
      'should return a list of City when the call to remote data source is successful.',
      () async {
        // arrange
        when(() => mockRemoteDataSource.get(any()))
            .thenAnswer((_) async => tCityModelList);

        // act
        final result = await repository.search(tCityToSearch);

        // asset
        expect(result, Right(tCityModelList));
        verify(() => mockRemoteDataSource.get(tCityToSearch)).called(1);
      },
    );

    test(
      'should return a SearchFailure when the call to remote data source is unsuccessful.',
      () async {
        // arrange
        when(() => mockRemoteDataSource.get(any()))
            .thenThrow(ServerException());

        // act
        final result = await repository.search(tCityToSearch);

        // assert
        expect(result, const Left(SearchFailure()));
        verify(() => mockRemoteDataSource.get(tCityToSearch)).called(1);
      },
    );
  });

  group('getSavedCities', () {
    test(
      'should return a list of City when the call to local data source is successful.',
      () async {
        // arrange
        when(() => mockLocalDataSource.getSavedCities())
            .thenAnswer((_) async => [tCityModelJSON]);

        // act
        final result = await repository.getSavedCities();

        // assert
        expect(
          result,
          isA<Right<Failure, List<City>>>().having(
            (r) => r.getOrElse(() => []),
            'cityList',
            [tCity],
          ),
        );
        verify(() => mockLocalDataSource.getSavedCities()).called(1);
      },
    );

    test(
      'should return a GetSavedCitiesFailure when the call to local data source is unsuccessful.',
      () async {
        // arrange
        when(() => mockLocalDataSource.getSavedCities())
            .thenThrow(CacheException());

        // act
        final result = await repository.getSavedCities();

        // assert
        expect(result, const Left(GetSavedCitiesFailure()));
        verify(() => mockLocalDataSource.getSavedCities()).called(1);
      },
    );
  });

  group('saveCity', () {
    test(
      'should return unit when the call to local data source is successful.',
      () async {
        // arrange
        when(() => mockLocalDataSource.saveCity(any()))
            .thenAnswer((_) async => unit);

        // act
        final result = await repository.saveCity(tCity);

        // assert
        expect(result, const Right(unit));
        verify(() => mockLocalDataSource.saveCity(tCityModel.toJson()))
            .called(1);
      },
    );

    test(
      'should return a SaveCityFailure when the call to local data source is unsuccessful.',
      () async {
        // arrange
        when(() => mockLocalDataSource.saveCity(any()))
            .thenThrow(CacheException());

        // act
        final result = await repository.saveCity(tCity);

        // assert
        expect(result, const Left(SaveCityFailure()));
        verify(() => mockLocalDataSource.saveCity(tCityModel.toJson()))
            .called(1);
      },
    );
  });

  group('removeCity', () {
    test(
      'should return unit when the call to local data source is successful.',
      () async {
        // arrange
        when(() => mockLocalDataSource.removeCity(any()))
            .thenAnswer((_) async => unit);

        // act
        final result = await repository.removeCity(tCity);

        // assert
        expect(result, const Right(unit));
        verify(() =>
                mockLocalDataSource.removeCity("${tCity.name},${tCity.state}"))
            .called(1);
      },
    );

    test(
      'should return a RemoveCityFailure when the call to local data source is unsuccessful.',
      () async {
        // arrange
        when(() => mockLocalDataSource.removeCity(any()))
            .thenThrow(CacheException());

        // act
        final result = await repository.removeCity(tCity);

        // assert
        expect(result, const Left(RemoveCityFailure()));
        verify(() =>
                mockLocalDataSource.removeCity("${tCity.name},${tCity.state}"))
            .called(1);
      },
    );
  });
}
