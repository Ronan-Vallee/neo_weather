import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neo_weather/features/city/data/datasources/city_local_data_source.dart';
import 'package:neo_weather/features/city/data/datasources/city_remote_data_source.dart';
import 'package:neo_weather/features/city/data/datasources/location_data_source.dart';
import 'package:neo_weather/features/city/data/repositories/city_repository.dart';
import 'package:neo_weather/features/city/data/repositories/location_repository.dart';
import 'package:neo_weather/features/city/domain/usecases/get_saved_cities_weather.dart';
import 'package:neo_weather/features/city/domain/usecases/remove_city.dart';
import 'package:neo_weather/features/city/domain/usecases/save_city.dart';
import 'package:neo_weather/features/city/domain/usecases/search.dart';
import 'package:neo_weather/features/city/presentation/blocs/city_search_bloc/city_search_bloc.dart';

// Bloc
class MockCitySearchBloc extends Mock implements CitySearchBloc {}

// Usecases
class MockSearch extends Mock implements Search {}

class MockGetSavedCities extends Mock implements GetSavedCitiesWeather {}

class MockSaveCity extends Mock implements SaveCity {}

class MockRemoveCity extends Mock implements RemoveCity {}

// Repository
class MockCityRepository extends Mock implements CityRepository {}

class MockLocationRepository extends Mock implements LocationRepository {}

// Data Sources
class MockCityRemoteDataSource extends Mock implements ICityRemoteDataSource {}

class MockCityLocalDataSource extends Mock implements CityLocalDataSource {}

class MockLocationDataSource extends Mock implements ILocationDataSource {}

// Hive
class MockCityBox extends Mock implements Box<String> {}
