import 'package:dartz/dartz.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/city.dart';
import '../../domain/repositories/interface_city_repository.dart';
import '../../domain/usecases/search.dart';
import '../datasources/city_remote_data_source.dart';

class CityRepository implements ICityRepository {
  final ICityRemoteDataSource remoteDataSource;

  CityRepository({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<City>>> search(String cityToSearch) async {
    try {
      final result = await remoteDataSource.get(cityToSearch);
      return Right(result);
    } on ServerException {
      return const Left(SearchFailure());
    }
  }
}
