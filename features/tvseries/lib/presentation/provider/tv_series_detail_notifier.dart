
// ignore_for_file: unnecessary_import

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:tvseries/domain/usecases/get_tv_series_watchlist_status.dart';
import 'package:tvseries/domain/usecases/remove_watchlist_tv_series.dart';
import 'package:tvseries/domain/usecases/save_watchlist_tv_series.dart';
import 'package:tvseries/tvseries.dart';

class TVSeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTVSeriesDetail getTVSeriesDetail;
  final GetTVSeriesRecommendations getTVSeriesRecommendations;
  final SaveWatchlistTVSeries saveWatchlist;
  final RemoveWatchlistTVSeries removeWatchlist;
  final GetWatchListStatusTVSeries getWatchListStatus;

  TVSeriesDetailNotifier({
    required this.getTVSeriesDetail,
    required this.getTVSeriesRecommendations,
    required this.saveWatchlist,
    required this.removeWatchlist,
    required this.getWatchListStatus,
  });

  late TVSeriesDetail _tvSeriesDetail;
  TVSeriesDetail get tvSeriesDetail => _tvSeriesDetail;

  RequestState _tvSeriesDetailState = RequestState.Empty;
  RequestState get tvSeriesDetailState => _tvSeriesDetailState;

  late List<TVSeries> _tvSeriesRecommendations = [];
  List<TVSeries> get tvSeriesRecommendations => _tvSeriesRecommendations;

  RequestState _tvSeriesRecommendationsState = RequestState.Empty;
  RequestState get tvSeriesRecommendationsState => _tvSeriesRecommendationsState;

  String _message = '';
  String get message => _message;

  final List<String> _seasonsList = [];
  List<String> get seasonsList => _seasonsList;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchTVSeriesDetail(int id) async {
    _tvSeriesDetailState = RequestState.Loading;
    notifyListeners();
    final result = await getTVSeriesDetail.execute(id);
    result.fold(
      (failure) {
        _tvSeriesDetailState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesDetail) {
        _tvSeriesDetail = tvSeriesDetail;
        for (var i = 0; i < tvSeriesDetail.numberOfSeasons; i++) {
          _seasonsList.add('Season ${i + 1}');
        }
        _tvSeriesDetailState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> fetchTVSeriesRecommendations(int id) async {
_tvSeriesRecommendationsState = RequestState.Loading;
    notifyListeners();
    final result = await getTVSeriesRecommendations.execute(id);
    result.fold(
      (failure) {
        _tvSeriesRecommendationsState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesRecommendations) {
        _tvSeriesRecommendations = tvSeriesRecommendations;
        _tvSeriesRecommendationsState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  Future<void> onInitialization(int id) async {
    await Future.wait([
      fetchTVSeriesDetail(id),
      fetchTVSeriesRecommendations(id)]);
  }


  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TVSeriesDetail tvSeries) async {
    final result = await saveWatchlist.execute(tvSeries);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvSeries.id);
  }

  Future<void> removeFromWatchlist(TVSeriesDetail tvSeries) async {
    final result = await removeWatchlist.execute(tvSeries);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvSeries.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}