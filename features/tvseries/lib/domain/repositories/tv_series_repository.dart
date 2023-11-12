import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tvseries/tvseries.dart';

abstract class TVSeriesRepository {
  Future<Either<Failure, List<TVSeries>>> getAiringTodayTVSeries();
  Future<Either<Failure, List<TVSeries>>> getPopularTVSeries();
  Future<Either<Failure, List<TVSeries>>> getOnTheAirTVSeries();
  Future<Either<Failure, List<TVSeries>>> getTopRatedTVSeries();
  Future<Either<Failure, TVSeriesDetail>> getTVSeriesDetail(int id);
  Future<Either<Failure, List<TVSeries>>> getTVSeriesRecommendations(int id);
  Future<Either<Failure, List<TVSeries>>>  searchTVSeries(String query);
  Future<Either<Failure, String>> saveWatchlist(TVSeriesDetail tvSeries);
  Future<Either<Failure, String>> removeWatchlist(TVSeriesDetail tvSeries);
  Future<bool> isAddedToWatchlist(int id);
}
