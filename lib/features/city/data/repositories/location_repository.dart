import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/repositories/interface_location_repository.dart';
import '../datasources/location_data_source.dart';

class LocationRepository implements ILocationRepository {
  final ILocationDataSource locationDataSource;

  LocationRepository({required this.locationDataSource});

  @override
  Future<Either<Failure, Position>> getCurrentLocation() async {
    try {
      final position = await locationDataSource.getCurrentLocation();
      return Right(position);
    } on RefusedLocationException {
      return const Left(
        LocationFailure(message: 'Permission de localisation refusée'),
      );
    } on LocationDisabledException {
      return const Left(
        LocationFailure(message: 'Le service de localisation est désactivé'),
      );
    } catch (_) {
      return const Left(LocationFailure());
    }
  }
}
