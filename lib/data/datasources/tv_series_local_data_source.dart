import 'package:core/core.dart';
import 'package:ditonton/data/models/watchlist_table.dart';

abstract class TVSeriesLocalDataSource {
  Future<String> insertWatchlist(WatchlistTable tvseries);
  Future<String> removeWatchlist(WatchlistTable tvseries);
  Future<WatchlistTable?> getWatchlistById(int id);
}

class TVSeriesLocalDataSourceImpl implements TVSeriesLocalDataSource {
  final DatabaseHelper databaseHelper;

  TVSeriesLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(WatchlistTable tvseries) async {
    try {
      await databaseHelper.insertWatchlist(tvseries);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(WatchlistTable tvseries) async {
    try {
      await databaseHelper.removeWatchlist(tvseries);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<WatchlistTable?> getWatchlistById(int id) async {
    final result = await databaseHelper.getWatchlistById(id);
    if (result != null) {
      return WatchlistTable.fromMap(result);
    } else {
      return null;
    }
  }
}
