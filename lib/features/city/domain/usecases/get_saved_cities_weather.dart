import 'package:dartz/dartz.dart';

import '../../../../core/entities/city_weather.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/interfaces/usecase.dart';
import '../../../weather/domain/repositories/interface_weather_repository.dart';
import '../entities/city.dart';
import '../repositories/interface_city_repository.dart';

class GetSavedCitiesWeather implements UseCase<List<CityWeather>, NoParams> {
  final ICityRepository cityRepository;
  final IWeatherRepository weatherRepository;

  GetSavedCitiesWeather({
    required this.cityRepository,
    required this.weatherRepository,
  });

  @override
  Future<Either<Failure, List<CityWeather>>> call(NoParams params) async {
    final citiesResult = await cityRepository.getSavedCities();

    return citiesResult.fold(
      (failure) => Left(failure),
      (savedCities) async {
        final citiesWithWeather = await _getWeatherForCities(savedCities);
        return Right(citiesWithWeather);
      },
    );
  }

  Future<List<CityWeather>> _getWeatherForCities(
    List<City> cities,
  ) async {
    final futures = cities.map((city) async {
      final weatherResult = await weatherRepository.getWeather(
        city.latitude,
        city.longitude,
      );

      return weatherResult.fold(
        (failure) => null, // To remove the item from the list
        (weather) => CityWeather(
          city: city,
          weather: weather,
        ),
      );
    });

    final results = await Future.wait(futures);
    return results.whereType<CityWeather>().toList();
  }
}

class GetSavedCitiesFailure extends Failure {
  const GetSavedCitiesFailure({
    String message = "Impossible de récupérer la liste des villes sauvegardées",
  }) : super(errorMessage: message);
}
