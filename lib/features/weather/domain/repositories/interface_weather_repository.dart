import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/weather.dart';

abstract class IWeatherRepository {
  Future<Either<Failure, Weather>> getWeather(
    double latitude,
    double longitude,
  );
}
