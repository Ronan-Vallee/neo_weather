import 'package:get_it/get_it.dart';
import 'package:neo_weather/features/weather/data/datasources/weather_remote_data_source.dart';
import 'package:neo_weather/features/weather/data/repositories/weather_repository.dart';
import 'package:neo_weather/features/weather/domain/repositories/interface_weather_repository.dart';
import 'package:neo_weather/features/weather/domain/usecases/get_weather.dart';
import 'package:neo_weather/features/weather/presentation/blocs/weather_bloc/weather_bloc.dart';

final locator = GetIt.instance;

void init() {
  /// *** Weather *** ///
  // bloc
  locator.registerFactory(() => WeatherBloc(getWeather: locator()));

  // usecase
  locator.registerLazySingleton(() => GetWeather(locator()));

  // repository
  locator.registerLazySingleton<IWeatherRepository>(
    () => WeatherRepository(remoteDataSource: locator()),
  );

  // data source
  locator.registerLazySingleton<IWeatherRemoteDataSource>(
    () => WeatherRemoteDataSource(),
  );
}
