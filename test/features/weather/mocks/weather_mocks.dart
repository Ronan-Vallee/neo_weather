import 'package:mocktail/mocktail.dart';
import 'package:neo_weather/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:neo_weather/features/weather/data/repositories/weather_repository.dart';
import 'package:neo_weather/features/weather/domain/usecases/get_weather.dart';

// Usecase
class MockGetWeather extends Mock implements GetWeather {}

// Repository
class MockWeatherRepository extends Mock implements WeatherRepository {}

// Data Source
class MockWeatherRemoteDataSource extends Mock
    implements IWeatherRemoteDataSource {}
