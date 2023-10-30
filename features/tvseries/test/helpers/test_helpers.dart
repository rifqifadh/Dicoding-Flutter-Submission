import 'package:core/core.dart';
import 'package:tvseries/tvseries.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TVSeriesLocalDataSource,
  TVSeriesRemoteDataSource,
  TVSeriesRepository,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
