import 'package:core/core.dart';
import 'package:tvseries/tvseries.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TVSeriesLocalDataSource,
  TVSeriesRemoteDataSource,
  TVSeriesRepository,
  SearchTVSeries,
  GetAirTodayTVSeries,
  GetOnTheAirTVSeries,
  GetPopularTVSeries,
  GetTopRatedTVSeries,
  GetTVSeriesDetail,
  GetWatchListStatusTVSeries,
  GetTVSeriesRecommendations,
  RemoveWatchlistTVSeries,
  SaveWatchlistTVSeries,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
