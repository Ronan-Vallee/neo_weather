import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dartz/dartz.dart';
import 'package:neo_weather/core/errors/exceptions.dart';
import 'package:neo_weather/core/errors/failures.dart';
import 'package:neo_weather/features/city/data/repositories/location_repository.dart';

import '../../mocks/city_mocks.dart';
import '../../test_models/city_models.dart';

void main() {
  late LocationRepository repository;
  late MockLocationDataSource mockLocationDataSource;

  setUp(() {
    mockLocationDataSource = MockLocationDataSource();
    repository = LocationRepository(locationDataSource: mockLocationDataSource);
  });

  group('getCurrentLocation', () {
    test(
      'should return Position when the call to locationDataSource is successful.',
      () async {
        // arrange
        when(() => mockLocationDataSource.getCurrentLocation())
            .thenAnswer((_) async => tPosition);

        // act
        final result = await repository.getCurrentLocation();

        // assert
        expect(result, Right(tPosition));
        verify(() => mockLocationDataSource.getCurrentLocation()).called(1);
      },
    );

    test(
      'should return LocationFailure when the call to '
      'locationDataSource throws RefusedLocationException.',
      () async {
        // arrange
        when(() => mockLocationDataSource.getCurrentLocation())
            .thenThrow(RefusedLocationException());

        // act
        final result = await repository.getCurrentLocation();

        // assert
        expect(
          result,
          const Left(
            LocationFailure(message: 'Permission de localisation refusée'),
          ),
        );
        verify(() => mockLocationDataSource.getCurrentLocation()).called(1);
      },
    );

    test(
      'should return LocationFailure when the call to '
      'locationDataSource throws LocationDisabledException.',
      () async {
        // arrange
        when(() => mockLocationDataSource.getCurrentLocation())
            .thenThrow(LocationDisabledException());

        // act
        final result = await repository.getCurrentLocation();

        // assert
        expect(
          result,
          const Left(
            LocationFailure(
              message: 'Le service de localisation est désactivé',
            ),
          ),
        );
        verify(() => mockLocationDataSource.getCurrentLocation()).called(1);
      },
    );

    test(
      'should return LocationFailure when the call to '
      'locationDataSource throws any other exception.',
      () async {
        // arrange
        when(() => mockLocationDataSource.getCurrentLocation())
            .thenThrow(Exception());

        // act
        final result = await repository.getCurrentLocation();

        // assert
        expect(result, const Left(LocationFailure()));
        verify(() => mockLocationDataSource.getCurrentLocation()).called(1);
      },
    );
  });
}
