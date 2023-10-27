import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_airing_today_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/pages/tv_series_more_page.dart';
import 'package:flutter/widgets.dart';

class TVSeriesMoreNotifier extends ChangeNotifier {
  var _tvSeriesList = <TVSeries>[];
  List<TVSeries> get tvSeriesList => _tvSeriesList;

  var _message = '';
  String get message => _message;

  var _state = RequestState.Empty;
  RequestState get state => _state;

  final GetTopRatedTVSeries getTopRatedTVSeries;
  final GetAirTodayTVSeries getAirTodayTVSeries;
  final GetPopularTVSeries getPopularTVSeries;

  TVSeriesMoreNotifier({
    required this.getTopRatedTVSeries,
    required this.getAirTodayTVSeries,
    required this.getPopularTVSeries,
  });

  Future<void> fetchTVSeries(TVSeriesMoreType type) async {
    _state = RequestState.Loading;
    notifyListeners();

    final Either<Failure, List<TVSeries>> result;

    if (type == TVSeriesMoreType.topRated) {
      result = await getTopRatedTVSeries.execute();
    } else if (type == TVSeriesMoreType.airingToday) {
      result = await getAirTodayTVSeries.execute();
    } else {
      result = await getPopularTVSeries.execute();
    }

    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _state = RequestState.Loaded;
        _tvSeriesList = data;
        notifyListeners();
      },
    );
  }
}