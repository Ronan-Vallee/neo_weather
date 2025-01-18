import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'api/open_weather_api_client.dart';
import 'features/weather/data/datasources/weather_remote_data_source.dart';
import 'features/weather/data/repositories/weather_repository.dart';
import 'features/weather/domain/repositories/interface_weather_repository.dart';
import 'features/weather/domain/usecases/get_weather.dart';
import 'features/weather/presentation/blocs/weather_bloc/weather_bloc.dart';

final locator = GetIt.instance;

void init() {
  /// *** Weather *** ///
  // bloc
  locator.registerFactory(() => WeatherBloc(getWeatherUsecase: locator()));

  // usecase
  locator.registerLazySingleton(() => GetWeather(locator()));

  // repository
  locator.registerLazySingleton<IWeatherRepository>(
    () => WeatherRepository(remoteDataSource: locator()),
  );

  // data source
  locator.registerLazySingleton<IWeatherRemoteDataSource>(
    () => WeatherRemoteDataSource(apiClient: locator()),
  );

  /// *** API *** ///
  locator.registerLazySingleton(() => OpenWeatherAPIClient(client: locator()));

  /// *** External *** ///
  locator.registerLazySingleton(() => http.Client());
}
