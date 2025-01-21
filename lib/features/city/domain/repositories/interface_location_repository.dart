import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/errors/failures.dart';

abstract class ILocationRepository {
  Future<Either<Failure, Position>> getCurrentLocation();
}
