import 'package:hive_flutter/hive_flutter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:neo_weather/features/city/data/datasources/city_local_data_source.dart';
import 'package:neo_weather/features/city/data/datasources/city_remote_data_source.dart';
import 'package:neo_weather/features/city/data/repositories/city_repository.dart';
import 'package:neo_weather/features/city/domain/usecases/search.dart';
import 'package:neo_weather/features/city/presentation/blocs/city_search_bloc/city_search_bloc.dart';

// Bloc
class MockCitySearchBloc extends Mock implements CitySearchBloc {}

// Usecase
class MockSearch extends Mock implements Search {}

// Repository
class MockCityRepository extends Mock implements CityRepository {}

// Data Sources
class MockCityRemoteDataSource extends Mock implements ICityRemoteDataSource {}

class MockCityLocalDataSource extends Mock implements CityLocalDataSource {}

// Hive
class MockCityBox extends Mock implements Box<String> {}
