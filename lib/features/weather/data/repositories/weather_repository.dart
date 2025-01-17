import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/repositories/interface_weather_repository.dart';
import '../../domain/usecases/get_weather.dart';
import '../datasources/weather_remote_data_source.dart';

class WeatherRepository implements IWeatherRepository {
  final IWeatherRemoteDataSource remoteDataSource;

  WeatherRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> getWeather() async {
    try {
      final result = await remoteDataSource.get();
      return Right(result);
    } catch (e) {
      return const Left(GetWeatherFailure());
    }
  }
}
