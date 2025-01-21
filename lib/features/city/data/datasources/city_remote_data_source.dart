import '../../../../api/open_weather_api_client.dart';
import '../models/city_model.dart';

abstract class ICityRemoteDataSource {
  Future<List<CityModel>> get(String cityToSearch);
  Future<List<CityModel>> getFromLocation(double latitude, double longitude);
}

class CityRemoteDataSource implements ICityRemoteDataSource {
  final OpenWeatherAPIClient apiClient;

  CityRemoteDataSource({required this.apiClient});

  @override
  Future<List<CityModel>> get(String cityToSearch) async {
    final data = await apiClient.searchCities(cityToSearch);
    final modelList = data.map((e) => CityModel.fromJson(e)).toSet().toList();
    return modelList;
  }

  @override
  Future<List<CityModel>> getFromLocation(
    double latitude,
    double longitude,
  ) async {
    final data = await apiClient.searchCitiesFromLocation(latitude, longitude);
    final modelList = data.map((e) => CityModel.fromJson(e)).toSet().toList();
    return modelList;
  }
}
