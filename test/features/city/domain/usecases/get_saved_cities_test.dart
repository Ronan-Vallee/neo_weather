import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neo_weather/core/interfaces/usecase.dart';
import 'package:neo_weather/features/city/domain/usecases/get_saved_cities.dart';

import '../../mocks/city_mocks.dart';
import '../../test_models/city_models.dart';

void main() {
  late GetSavedCities usecase;
  late MockCityRepository mockCityRepository;

  setUp(() {
    mockCityRepository = MockCityRepository();
    usecase = GetSavedCities(mockCityRepository);
  });

  test(
    'should return a list of saved cities as Right from the repository.',
    () async {
      // arrange
      when(() => mockCityRepository.getSavedCities())
          .thenAnswer((_) async => const Right(tCityList));

      // act
      final result = await usecase(NoParams());

      // assert
      expect(result, const Right(tCityList));
      verify(() => mockCityRepository.getSavedCities()).called(1);
      verifyNoMoreInteractions(mockCityRepository);
    },
  );

  test(
    'should return a failure as Left when the repository returns one.',
    () async {
      // arrange
      when(() => mockCityRepository.getSavedCities())
          .thenAnswer((_) async => const Left(GetSavedCitiesFailure()));

      // act
      final result = await usecase(NoParams());

      // assert
      expect(result, const Left(GetSavedCitiesFailure()));
      verify(() => mockCityRepository.getSavedCities()).called(1);
      verifyNoMoreInteractions(mockCityRepository);
    },
  );
}
