import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/city.dart';

abstract class ICityRepository {
  Future<Either<Failure, List<City>>> search(String cityToSearch);
  Future<Either<Failure, List<City>>> searchFromLocation(
    double latitude,
    double longitude,
  );
  Future<Either<Failure, List<City>>> getSavedCities();
  Future<Either<Failure, Unit>> saveCity(City city);
  Future<Either<Failure, Unit>> removeCity(City city);
}
