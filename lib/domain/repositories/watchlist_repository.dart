import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:ditonton/domain/entities/watchlist.dart';

abstract class WatchlistRepository {
  Future<Either<Failure, List<Watchlist>>> getWatchlist();
}
