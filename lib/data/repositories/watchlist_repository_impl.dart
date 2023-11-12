
import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:ditonton/data/datasources/watchlist_local_data_source.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:ditonton/domain/repositories/watchlist_repository.dart';

class WatchlistRepositoryImpl extends WatchlistRepository {
  final WatchlistLocalDataSource localDataSource;

  WatchlistRepositoryImpl({
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Watchlist>>> getWatchlist() async {
    try {
    final result = await localDataSource.getWatchlist();
      return Right(result.map((data) => data.toEntity()).toList());
    } on DatabaseException {
      return const Left(DatabaseFailure('Failed to get watchlist'));
    }
  }
}