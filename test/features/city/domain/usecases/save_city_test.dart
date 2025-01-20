import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neo_weather/features/city/domain/usecases/save_city.dart';

import '../../mocks/city_mocks.dart';
import '../../test_models/city_models.dart';

void main() {
  late SaveCity usecase;
  late MockCityRepository mockCityRepository;

  setUp(() {
    mockCityRepository = MockCityRepository();
    usecase = SaveCity(mockCityRepository);
  });

  test(
    'should return unit as Right when the saveCity call to repository is successful.',
    () async {
      // arrange
      when(() => mockCityRepository.saveCity(any()))
          .thenAnswer((_) async => const Right(unit));

      // act
      final result = await usecase(const SaveCityParams(city: tCity));

      // assert
      expect(result, const Right(unit));
      verify(() => mockCityRepository.saveCity(tCity)).called(1);
      verifyNoMoreInteractions(mockCityRepository);
    },
  );

  test(
    'should return a Failure as Left when the saveCity call to '
    'repository is unsuccessful.',
    () async {
      // arrange
      when(() => mockCityRepository.saveCity(any()))
          .thenAnswer((_) async => const Left(SaveCityFailure()));

      // act
      final result = await usecase(const SaveCityParams(city: tCity));

      // assert
      expect(result, const Left(SaveCityFailure()));
      verify(() => mockCityRepository.saveCity(tCity)).called(1);
      verifyNoMoreInteractions(mockCityRepository);
    },
  );
}
