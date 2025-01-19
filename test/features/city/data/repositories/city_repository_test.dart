import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:neo_weather/core/errors/exceptions.dart';
import 'package:neo_weather/features/city/data/repositories/city_repository.dart';
import 'package:neo_weather/features/city/domain/usecases/search.dart';

import '../../mocks/city_mocks.dart';
import '../../test_models/city_models.dart';

void main() {
  late CityRepository repository;
  late MockCityRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockCityRemoteDataSource();
    repository = CityRepository(remoteDataSource: mockRemoteDataSource);
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
}
