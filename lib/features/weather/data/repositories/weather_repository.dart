import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/interface_weather_repository.dart';
import '../../domain/usecases/get_weather.dart';
import '../datasources/weather_remote_data_source.dart';

class WeatherRepository implements IWeatherRepository {
  final IWeatherRemoteDataSource remoteDataSource;

  WeatherRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, Weather>> getWeather(
    double latitude,
    double longitude,
  ) async {
    try {
      final result = await remoteDataSource.get(latitude, longitude);
      return Right(result);
    } on InternetConnectionException {
      return const Left(InternetConnectionFailure());
    } catch (_) {
      return const Left(GetWeatherFailure());
    }
  }
}
