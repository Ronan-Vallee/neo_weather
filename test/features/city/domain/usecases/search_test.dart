import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:neo_weather/features/city/domain/usecases/search.dart';

import '../../mocks/city_mocks.dart';
import '../../test_models/city_models.dart';

void main() {
  late Search usecase;
  late MockCityRepository mockCityRepository;

  setUp(() {
    mockCityRepository = MockCityRepository();
    usecase = Search(mockCityRepository);
  });

  const tCityToSearch = 'Paris';

  test(
    'should return a list of City when the call to repository is successful.',
    () async {
      // arrange
      when(() => mockCityRepository.search(any()))
          .thenAnswer((_) async => const Right(tCityList));

      // act
      final result =
          await usecase(const SearchParams(cityToSearch: tCityToSearch));

      // assert
      expect(result, const Right(tCityList));
      verify(() => mockCityRepository.search(tCityToSearch)).called(1);
      verifyNoMoreInteractions(mockCityRepository);
    },
  );

  test(
    'should return a SearchFailure when the call to repository is unsuccessful.',
    () async {
      // arrange
      when(() => mockCityRepository.search(any()))
          .thenAnswer((_) async => const Left(SearchFailure()));

      // act
      final result =
          await usecase(const SearchParams(cityToSearch: tCityToSearch));

      // assert
      expect(result, const Left(SearchFailure()));
      verify(() => mockCityRepository.search(tCityToSearch)).called(1);
      verifyNoMoreInteractions(mockCityRepository);
    },
  );
}
