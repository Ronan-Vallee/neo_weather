import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/city.dart';

abstract class ICityRepository {
  Future<Either<Failure, List<City>>> search(String cityToSearch);
}
