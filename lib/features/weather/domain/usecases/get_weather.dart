import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/interfaces/usecase.dart';
import '../repositories/interface_weather_repository.dart';

class GetWeather implements UseCase<void, GetWeatherParams> {
  final IWeatherRepository repository;

  GetWeather(this.repository);

  @override
  Future<Either<Failure, void>> call([GetWeatherParams? params]) async {
    return await repository.getWeather();
  }
}

class GetWeatherParams {
  const GetWeatherParams();
}

class GetWeatherFailure extends Failure {
  const GetWeatherFailure(
      {String message = "Impossible d'obtenir les prévisions météo"})
      : super(errorMessage: message);
}
