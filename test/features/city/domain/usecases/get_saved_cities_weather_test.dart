import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neo_weather/core/entities/city_weather.dart';
import 'package:neo_weather/core/errors/failures.dart';
import 'package:neo_weather/core/interfaces/usecase.dart';
import 'package:neo_weather/features/city/domain/entities/city.dart';
import 'package:neo_weather/features/city/domain/usecases/get_saved_cities_weather.dart';

import '../../../weather/mocks/weather_mocks.dart';
import '../../../weather/test_models/weather_models.dart';
import '../../mocks/city_mocks.dart';
import '../../test_models/city_models.dart';

void main() {
  late GetSavedCitiesWeather usecase;
  late MockCityRepository mockCityRepository;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockCityRepository = MockCityRepository();
    mockWeatherRepository = MockWeatherRepository();
    usecase = GetSavedCitiesWeather(
      cityRepository: mockCityRepository,
      weatherRepository: mockWeatherRepository,
    );
  });

  test(
    'should return a list of saved cities with their weither (CityWeather) as '
    'Right when the calls to cityRepository and weatherRepository are successful.',
    () async {
      // arrange
      when(() => mockCityRepository.getSavedCities())
          .thenAnswer((_) async => const Right(tCityList));
      when(() => mockWeatherRepository.getWeather(any(), any()))
          .thenAnswer((_) async => Right(tWeather));

      // act
      final result = await usecase(NoParams());

      // assert
      expect(
          result,
          isA<Right<Failure, List<CityWeather>>>().having(
            (r) => r.getOrElse(() => []),
            'cityWeatherList',
            tCityWeatherList,
          ));
      verify(() => mockCityRepository.getSavedCities()).called(1);
      verify(() =>
              mockWeatherRepository.getWeather(tCity.latitude, tCity.longitude))
          .called(1);
    },
  );

  test(
    'should return a failure as Left when the call to cityRepository returns one.',
    () async {
      // arrange
      when(() => mockCityRepository.getSavedCities())
          .thenAnswer((_) async => const Left(GetSavedCitiesFailure()));

      // act
      final result = await usecase(NoParams());

      // assert
      expect(result, const Left(GetSavedCitiesFailure()));
      verify(() => mockCityRepository.getSavedCities()).called(1);
      verifyNoMoreInteractions(mockWeatherRepository);
    },
  );

  test(
    'should return a list of CityWeather with null weather when '
    'the call to weatherRepository is unsuccessful',
    () async {
      // arrange
      const tCityToFail = City(
        name: 'name',
        latitude: 1,
        longitude: 1,
        country: 'country',
        state: 'state',
      );
      final tCityListWithAFail = [...tCityList, tCityToFail];
      when(() => mockCityRepository.getSavedCities())
          .thenAnswer((_) async => Right(tCityListWithAFail));
      when(() => mockWeatherRepository.getWeather(1, 1))
          .thenAnswer((_) async => const Left(ServerFailure()));
      when(() =>
              mockWeatherRepository.getWeather(tCity.latitude, tCity.longitude))
          .thenAnswer((_) async => Right(tWeather));

      // act
      final result = await usecase(NoParams());

      // assert
      expect(result.getOrElse(() => []).length, 1);
      expect(result.getOrElse(() => []).first, tCityWeather);
      verify(() => mockCityRepository.getSavedCities()).called(1);
      verify(() =>
              mockWeatherRepository.getWeather(tCity.latitude, tCity.longitude))
          .called(1);
      verify(() => mockWeatherRepository.getWeather(
          tCityToFail.latitude, tCityToFail.longitude)).called(1);
      verifyNoMoreInteractions(mockWeatherRepository);
    },
  );
}
