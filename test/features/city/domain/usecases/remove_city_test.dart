import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neo_weather/features/city/domain/usecases/remove_city.dart';

import '../../mocks/city_mocks.dart';
import '../../test_models/city_models.dart';

void main() {
  late RemoveCity usecase;
  late MockCityRepository mockCityRepository;

  setUp(() {
    mockCityRepository = MockCityRepository();
    usecase = RemoveCity(mockCityRepository);

    registerFallbackValue(tCity);
  });

  test(
    'should return unit as Right when the remove call to repository is successful.',
    () async {
      // arrange
      when(() => mockCityRepository.removeCity(any()))
          .thenAnswer((_) async => const Right(unit));

      // act
      final result = await usecase(const RemoveCityParams(city: tCity));

      // assert
      expect(result, const Right(unit));
      verify(() => mockCityRepository.removeCity(tCity)).called(1);
      verifyNoMoreInteractions(mockCityRepository);
    },
  );

  test(
    'should return a Failure as Left when the remove call to '
    'repository is unsuccessful.',
    () async {
      // arrange
      when(() => mockCityRepository.removeCity(any()))
          .thenAnswer((_) async => const Left(RemoveCityFailure()));

      // act
      final result = await usecase(const RemoveCityParams(city: tCity));

      // assert
      expect(result, const Left(RemoveCityFailure()));
      verify(() => mockCityRepository.removeCity(tCity)).called(1);
      verifyNoMoreInteractions(mockCityRepository);
    },
  );
}
