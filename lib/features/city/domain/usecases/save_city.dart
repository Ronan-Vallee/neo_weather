import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/interfaces/usecase.dart';
import '../entities/city.dart';
import '../repositories/interface_city_repository.dart';

class SaveCity implements UseCase<Unit, SaveCityParams> {
  final ICityRepository repository;

  SaveCity(this.repository);

  @override
  Future<Either<Failure, Unit>> call(SaveCityParams? params) async {
    return await repository.saveCity(params!.city);
  }
}

class SaveCityParams extends Equatable {
  final City city;

  const SaveCityParams({required this.city});

  @override
  List<Object> get props => [city];
}

class SaveCityFailure extends Failure {
  const SaveCityFailure(
      {String message = "Impossible d'ajouter la ville à la liste"})
      : super(errorMessage: message);
}
