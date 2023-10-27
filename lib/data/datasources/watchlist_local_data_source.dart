import 'package:core/core.dart';
import 'package:ditonton/data/models/watchlist_table.dart';

abstract class WatchlistLocalDataSource {
  Future<List<WatchlistTable>> getWatchlist();
}

class WatchlistLocalDataSourceImpl implements WatchlistLocalDataSource {
  final DatabaseHelper databaseHelper;

  WatchlistLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<WatchlistTable>> getWatchlist() async {
    final result = await databaseHelper.getWatchlist();
    return result.map((data) => WatchlistTable.fromMap(data)).toList();
  }
}
