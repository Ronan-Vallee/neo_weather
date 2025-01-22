import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../domain/entities/city.dart';
import '../../domain/repositories/interface_city_repository.dart';
import '../../domain/usecases/get_saved_cities_weather.dart';
import '../../domain/usecases/remove_city.dart';
import '../../domain/usecases/save_city.dart';
import '../../domain/usecases/search.dart';
import '../../domain/usecases/search_from_location.dart';
import '../datasources/city_local_data_source.dart';
import '../datasources/city_remote_data_source.dart';
import '../models/city_model.dart';

class CityRepository implements ICityRepository {
  final ICityRemoteDataSource remoteDataSource;
  final ICityLocalDataSource localDataSource;

  CityRepository({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<City>>> search(String cityToSearch) async {
    try {
      final result = await remoteDataSource.get(cityToSearch);
      return Right(result);
    } catch (_) {
      return const Left(SearchFailure());
    }
  }

  @override
  Future<Either<Failure, List<City>>> searchFromLocation(
    double latitude,
    double longitude,
  ) async {
    try {
      final result =
          await remoteDataSource.getFromLocation(latitude, longitude);
      return Right(result);
    } catch (_) {
      return const Left(SearchFromLocationFailure());
    }
  }

  @override
  Future<Either<Failure, List<City>>> getSavedCities() async {
    try {
      final cachedCities = await localDataSource.getSavedCities();
      final entityList =
          cachedCities.map((cityJson) => CityModel.fromJson(cityJson)).toList();
      return Right(entityList);
    } catch (_) {
      return const Left(GetSavedCitiesFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> saveCity(City city) async {
    try {
      final cityModel = city as CityModel;
      await localDataSource.saveCity(cityModel.toJson());
      return const Right(unit);
    } catch (_) {
      return const Left(SaveCityFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> removeCity(City city) async {
    try {
      localDataSource.removeCity("${city.name},${city.state}");
      return const Right(unit);
    } catch (_) {
      return const Left(RemoveCityFailure());
    }
  }
}
