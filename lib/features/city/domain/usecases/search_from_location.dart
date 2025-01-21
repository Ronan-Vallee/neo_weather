import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/interfaces/usecase.dart';
import '../entities/city.dart';
import '../repositories/interface_city_repository.dart';
import '../repositories/interface_location_repository.dart';

class SearchFromLocation implements UseCase<List<City>, NoParams> {
  final ICityRepository cityRepository;
  final ILocationRepository locationRepository;

  SearchFromLocation({
    required this.cityRepository,
    required this.locationRepository,
  });

  @override
  Future<Either<Failure, List<City>>> call(
    NoParams params,
  ) async {
    final position = await locationRepository.getCurrentLocation();
    return position.fold(
      (failure) => Left(failure),
      (position) async => await cityRepository.searchFromLocation(
        position.latitude,
        position.longitude,
      ),
    );
  }
}

class SearchFromLocationFailure extends Failure {
  const SearchFromLocationFailure({
    String message =
        "Impossible de récupérer la ville depuis la géolocalisation",
  }) : super(errorMessage: message);
}
