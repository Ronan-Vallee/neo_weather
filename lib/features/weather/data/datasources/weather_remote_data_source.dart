abstract class IWeatherRemoteDataSource {
  Future<void> get();
}

class WeatherRemoteDataSource implements IWeatherRemoteDataSource {
  WeatherRemoteDataSource();

  @override
  Future<void> get() async {}
}
