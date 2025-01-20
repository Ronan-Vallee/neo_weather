import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/interfaces/usecase.dart';
import '../entities/city.dart';
import '../repositories/interface_city_repository.dart';

class GetSavedCities implements UseCase<List<City>, NoParams> {
  final ICityRepository repository;

  GetSavedCities(this.repository);

  @override
  Future<Either<Failure, List<City>>> call(NoParams params) async {
    return await repository.getSavedCities();
  }
}

class GetSavedCitiesFailure extends Failure {
  const GetSavedCitiesFailure({
    String message = "Impossible de récupérer la liste des villes sauvegardées",
  }) : super(errorMessage: message);
}
