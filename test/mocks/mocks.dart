import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;

class MockHTTPClient extends Mock implements http.Client {}

class MockUri extends Mock implements Uri {}
