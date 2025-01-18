import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neo_weather/core/errors/failures.dart';
import 'package:neo_weather/features/weather/domain/entities/weather.dart';
import 'package:neo_weather/features/weather/domain/usecases/get_weather.dart';

import '../../mocks/weather_mocks.dart';
import '../../test_models/weather_models.dart';

void main() {
  late GetWeather usecase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetWeather(mockWeatherRepository);
  });

  const tLatitude = 132.0;
  const tLongitude = 1111.0;

  final Weather tWeather = tWeatherModel;

  test(
    'should get Weather from the repository.',
    () async {
      // arrange
      when(() => mockWeatherRepository.getWeather(any(), any()))
          .thenAnswer((_) async => Right(tWeather));

      // act
      final result = await usecase(
        const GetWeatherParams(latitude: tLatitude, longitude: tLongitude),
      );

      // assert
      expect(result, Right(tWeather));
      verify(() => mockWeatherRepository.getWeather(tLatitude, tLongitude));
      verifyNoMoreInteractions(mockWeatherRepository);
    },
  );

  test(
    'should return a Failure when when the repository returns one as Left.',
    () async {
      // arrange
      when(() => mockWeatherRepository.getWeather(any(), any()))
          .thenAnswer((_) async => const Left(InternetConnectionFailure()));

      // act
      final result = await usecase(
        const GetWeatherParams(latitude: tLatitude, longitude: tLongitude),
      );

      // assert
      expect(result, const Left(InternetConnectionFailure()));
      verify(() => mockWeatherRepository.getWeather(tLatitude, tLongitude));
      verifyNoMoreInteractions(mockWeatherRepository);
    },
  );
}
