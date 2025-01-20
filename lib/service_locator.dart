import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;

import 'api/open_weather_api_client.dart';
import 'features/city/data/datasources/city_local_data_source.dart';
import 'features/city/data/datasources/city_remote_data_source.dart';
import 'features/city/data/repositories/city_repository.dart';
import 'features/city/domain/repositories/interface_city_repository.dart';
import 'features/city/domain/usecases/get_saved_cities.dart';
import 'features/city/domain/usecases/remove_city.dart';
import 'features/city/domain/usecases/save_city.dart';
import 'features/city/domain/usecases/search.dart';
import 'features/city/presentation/blocs/city_search_bloc/city_search_bloc.dart';
import 'features/weather/data/datasources/weather_remote_data_source.dart';
import 'features/weather/data/repositories/weather_repository.dart';
import 'features/weather/domain/repositories/interface_weather_repository.dart';
import 'features/weather/domain/usecases/get_weather.dart';
import 'features/weather/presentation/blocs/weather_bloc/weather_bloc.dart';

final locator = GetIt.instance;

Future<void> init() async {
  final cityBox = await Hive.openBox<String>('cityBox');

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

  /// *** City *** ///
  // bloc
  locator.registerFactory(() => CitySearchBloc(searchUsecase: locator()));

  // usecases
  locator.registerLazySingleton(() => Search(locator()));
  locator.registerLazySingleton(() => GetSavedCities(locator()));
  locator.registerLazySingleton(() => SaveCity(locator()));
  locator.registerLazySingleton(() => RemoveCity(locator()));

  // repository
  locator.registerLazySingleton<ICityRepository>(
    () => CityRepository(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<ICityRemoteDataSource>(
    () => CityRemoteDataSource(apiClient: locator()),
  );
  locator.registerLazySingleton<ICityLocalDataSource>(
    () => CityLocalDataSource(cityBox: locator()),
  );

  /// *** API *** ///
  locator.registerLazySingleton(() => OpenWeatherAPIClient(client: locator()));

  /// *** External *** ///
  locator.registerLazySingleton(() => http.Client());
  locator.registerSingleton<Box<String>>(cityBox);
}
