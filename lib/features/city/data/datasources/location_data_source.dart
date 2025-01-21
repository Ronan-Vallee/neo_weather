import 'package:geolocator/geolocator.dart';
import 'package:neo_weather/core/services/location_service.dart';

abstract class ILocationDataSource {
  Future<Position> getCurrentLocation();
}

class LocationDataSource implements ILocationDataSource {
  final LocationService locationService;

  LocationDataSource({required this.locationService});

  @override
  Future<Position> getCurrentLocation() async {
    return await locationService.getCurrentLocation();
  }
}
