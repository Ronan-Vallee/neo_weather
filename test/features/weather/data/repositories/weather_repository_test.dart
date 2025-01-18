import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neo_weather/core/errors/exceptions.dart';
import 'package:neo_weather/core/errors/failures.dart';
import 'package:neo_weather/features/weather/data/repositories/weather_repository.dart';
import 'package:neo_weather/features/weather/domain/entities/weather.dart';
import 'package:neo_weather/features/weather/domain/usecases/get_weather.dart';

import '../../mocks/weather_mocks.dart';
import '../../test_models/weather_models.dart';

void main() {
  late WeatherRepository repository;
  late MockWeatherRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockWeatherRemoteDataSource();
    repository = WeatherRepository(remoteDataSource: mockRemoteDataSource);
  });

  group('getWeather', () {
    const double tLatitude = 1.0;
    const double tLongitude = 1.0;

    final Weather tWeather = tWeatherModel;

    test(
      'should return a Weather entity as Right when '
      'the call to remote data source is successful.',
      () async {
        // arrange
        when(() => mockRemoteDataSource.get(any(), any()))
            .thenAnswer((_) async => tWeatherModel);

        // act
        final result = await repository.getWeather(tLatitude, tLongitude);

        // assert
        verify(() => mockRemoteDataSource.get(tLatitude, tLongitude));
        expect(result, equals(Right(tWeather)));
      },
    );

    test(
      'should return an InternetConnectionFailure as Left when '
      'there is no internet connection.',
      () async {
        // arrange
        when(() => mockRemoteDataSource.get(any(), any()))
            .thenThrow(InternetConnectionException());

        // act
        final result = await repository.getWeather(tLatitude, tLongitude);

        // assert
        verify(() => mockRemoteDataSource.get(tLatitude, tLongitude));
        expect(result, equals(const Left(InternetConnectionFailure())));
      },
    );

    test(
      'should return a GetWeatherFailure as Left when '
      'the call to remote data source is unsuccessful.',
      () async {
        // arrange
        when(() => mockRemoteDataSource.get(any(), any()))
            .thenThrow(ServerException());

        // act
        final result = await repository.getWeather(tLatitude, tLongitude);

        // assert
        verify(() => mockRemoteDataSource.get(tLatitude, tLongitude));
        expect(result, equals(const Left(GetWeatherFailure())));
      },
    );
  });
}
