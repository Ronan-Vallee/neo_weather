import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/interfaces/usecase.dart';
import '../entities/city.dart';
import '../repositories/interface_city_repository.dart';

class Search implements UseCase<List<City>, SearchParams> {
  final ICityRepository repository;

  Search(this.repository);

  @override
  Future<Either<Failure, List<City>>> call(SearchParams? params) async {
    return await repository.search(params!.cityToSearch);
  }
}

class SearchParams extends Equatable {
  final String cityToSearch;

  const SearchParams({required this.cityToSearch});

  @override
  List<Object> get props => [cityToSearch];
}

class SearchFailure extends Failure {
  const SearchFailure(
      {String message = "Impossible de trouver la ville demandée"})
      : super(errorMessage: message);
}
