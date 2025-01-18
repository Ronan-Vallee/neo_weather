import '../../../../api/open_weather_api_client.dart';
import '../models/weather_model.dart';

abstract class IWeatherRemoteDataSource {
  Future<WeatherModel> get(double latitude, double longitude);
}

class WeatherRemoteDataSource implements IWeatherRemoteDataSource {
  final OpenWeatherAPIClient apiClient;

  WeatherRemoteDataSource({required this.apiClient});

  @override
  Future<WeatherModel> get(double latitude, double longitude) async {
    final data = await apiClient.getWeatherData(
      latitude: latitude,
      longitude: longitude,
    );
    return WeatherModel.fromJson(data);
  }
}
