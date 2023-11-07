import 'package:core/core.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:movies/movies.dart';

@GenerateMocks([
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  GetPopularMovies,
  GetNowPlayingMovies,
  GetTopRatedMovies,
  DatabaseHelper,
  SearchMovies
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
