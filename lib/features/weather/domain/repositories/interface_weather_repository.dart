import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class IWeatherRepository {
  Future<Either<Failure, void>> getWeather();
}
