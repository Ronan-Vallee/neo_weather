import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:neo_weather/core/errors/failures.dart';
import 'package:neo_weather/core/interfaces/usecase.dart';
import 'package:neo_weather/features/city/domain/usecases/search_from_location.dart';

import '../../mocks/city_mocks.dart';
import '../../test_models/city_models.dart';

void main() {
  late SearchFromLocation usecase;
  late MockCityRepository mockCityRepository;
  late MockLocationRepository mockLocationRepository;

  setUp(() {
    mockCityRepository = MockCityRepository();
    mockLocationRepository = MockLocationRepository();
    usecase = SearchFromLocation(
      cityRepository: mockCityRepository,
      locationRepository: mockLocationRepository,
    );
  });

  test(
    'should return a list of City when the call to '
    'locationRepository and cityRepository is successful.',
    () async {
      // arrange
      when(() => mockLocationRepository.getCurrentLocation())
          .thenAnswer((_) async => Right(tPosition));
      when(() => mockCityRepository.searchFromLocation(any(), any()))
          .thenAnswer((_) async => const Right(tCityList));

      // act
      final result = await usecase(NoParams());

      // assert
      expect(result, const Right(tCityList));
      verify(() => mockLocationRepository.getCurrentLocation()).called(1);
      verify(() => mockCityRepository.searchFromLocation(
            tPosition.latitude,
            tPosition.longitude,
          )).called(1);
    },
  );

  test(
    'should return a Failure when the call to locationRepository is unsuccessful.',
    () async {
      // arrange
      when(() => mockLocationRepository.getCurrentLocation())
          .thenAnswer((_) async => const Left(LocationFailure()));

      // act
      final result = await usecase(NoParams());

      // assert
      expect(result, const Left(LocationFailure()));
      verify(() => mockLocationRepository.getCurrentLocation()).called(1);
      verifyNever(() => mockCityRepository.searchFromLocation(any(), any()));
    },
  );

  test(
    'should return a Failure when the call to cityRepository is unsuccessful.',
    () async {
      // arrange
      when(() => mockLocationRepository.getCurrentLocation())
          .thenAnswer((_) async => Right(tPosition));
      when(() => mockCityRepository.searchFromLocation(any(), any()))
          .thenAnswer((_) async => const Left(SearchFromLocationFailure()));

      // act
      final result = await usecase(NoParams());

      // assert
      expect(result, const Left(SearchFromLocationFailure()));
      verify(() => mockLocationRepository.getCurrentLocation()).called(1);
      verify(() => mockCityRepository.searchFromLocation(
            tPosition.latitude,
            tPosition.longitude,
          )).called(1);
    },
  );
}
