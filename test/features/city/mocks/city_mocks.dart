import 'package:mocktail/mocktail.dart';
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

// Data Source
class MockCityRemoteDataSource extends Mock implements ICityRemoteDataSource {}
