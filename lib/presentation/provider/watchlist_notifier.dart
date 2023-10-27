import 'package:core/core.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:ditonton/domain/usecases/watchlist/get_watchlist.dart';
import 'package:flutter/foundation.dart';

class WatchlistNotifier extends ChangeNotifier {
  var _wathclistData = <Watchlist>[];
  List<Watchlist> get watchlistData => _wathclistData;

  var _watchlistState = RequestState.Empty;
  RequestState get watchlistState => _watchlistState;

  String _message = '';
  String get message => _message;

  WatchlistNotifier({required this.getWatchlist});

  final GetWatchlist getWatchlist;

  Future<void> fetchWatchlistMovies() async {
    _watchlistState = RequestState.Loading;
    notifyListeners();

    final result = await getWatchlist.execute();
    result.fold(
      (failure) {
        _watchlistState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (watchlistData) {
        _watchlistState = RequestState.Loaded;
        _wathclistData = watchlistData;
        notifyListeners();
      },
    );
  }
}
