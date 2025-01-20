import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/interfaces/usecase.dart';
import '../entities/city.dart';
import '../repositories/interface_city_repository.dart';

class RemoveCity implements UseCase<Unit, RemoveCityParams> {
  final ICityRepository repository;

  RemoveCity(this.repository);

  @override
  Future<Either<Failure, Unit>> call(RemoveCityParams? params) async {
    return await repository.removeCity(params!.city);
  }
}

class RemoveCityParams extends Equatable {
  final City city;

  const RemoveCityParams({required this.city});

  @override
  List<Object> get props => [city];
}

class RemoveCityFailure extends Failure {
  const RemoveCityFailure({
    String message = "Impossible de supprimer la ville de la liste",
  }) : super(errorMessage: message);
}
