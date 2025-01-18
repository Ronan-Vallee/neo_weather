import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/interfaces/usecase.dart';
import '../entities/weather.dart';
import '../repositories/interface_weather_repository.dart';

class GetWeather implements UseCase<Weather, GetWeatherParams> {
  final IWeatherRepository repository;

  GetWeather(this.repository);

  @override
  Future<Either<Failure, Weather>> call([GetWeatherParams? params]) async {
    return await repository.getWeather(params!.latitude, params.longitude);
  }
}

class GetWeatherParams {
  final double latitude;
  final double longitude;

  const GetWeatherParams({required this.latitude, required this.longitude});
}

class GetWeatherFailure extends Failure {
  const GetWeatherFailure(
      {String message = "Impossible d'obtenir les prévisions météo"})
      : super(errorMessage: message);
}
