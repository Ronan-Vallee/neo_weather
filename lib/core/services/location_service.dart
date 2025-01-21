import 'package:geolocator/geolocator.dart';

import '../errors/exceptions.dart';

abstract class ILocationService {
  Future<Position> getCurrentLocation();
}

class LocationService implements ILocationService {
  @override
  Future<Position> getCurrentLocation() async {
    try {
      final isLocationEnabled = await Geolocator.isLocationServiceEnabled();
      if (!isLocationEnabled) {
        throw LocationDisabledException();
      }

      final permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        final requestPermission = await Geolocator.requestPermission();
        if (requestPermission == LocationPermission.denied) {
          throw RefusedLocationException();
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw RefusedLocationException();
      }

      final position = await Geolocator.getCurrentPosition();

      return position;
    } catch (e) {
      throw LocationException();
    }
  }
}
