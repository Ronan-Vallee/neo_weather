import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'api/open_weather_api_client.dart';
import 'features/city/data/datasources/city_remote_data_source.dart';
import 'features/city/data/repositories/city_repository.dart';
import 'features/city/domain/repositories/interface_city_repository.dart';
import 'features/city/domain/usecases/search.dart';
import 'features/city/presentation/blocs/city_search_bloc/city_search_bloc.dart';
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

  /// *** CitySearch *** ///
  // usecase
  locator.registerLazySingleton(() => Search(locator()));

  // repository
  locator.registerLazySingleton<ICityRepository>(
    () => CityRepository(remoteDataSource: locator()),
  );

  // data source
  locator.registerLazySingleton<ICityRemoteDataSource>(
    () => CityRemoteDataSource(apiClient: locator()),
  );

  /// *** API *** ///
  locator.registerLazySingleton(() => OpenWeatherAPIClient(client: locator()));

  /// *** External *** ///
  locator.registerLazySingleton(() => http.Client());
}
