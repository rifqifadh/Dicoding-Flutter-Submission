// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

import 'package:core/core.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_airing_today_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_on_the_air_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_top_rated_tv_series.dart';

class TVSeriesListNotifier extends ChangeNotifier {
  var _airingTodayTVSeries = <TVSeries>[];
  List<TVSeries> get airingTodayTVSeries => _airingTodayTVSeries;

  RequestState _airingTodayTVSeriesState = RequestState.Empty;
  RequestState get airingTodayTVSeriesState => _airingTodayTVSeriesState;

  var _topRatedTVSeries = <TVSeries>[];
  List<TVSeries> get topRatedTVSeries => _topRatedTVSeries;

  RequestState _topRatedTVSeriesState = RequestState.Empty;
  RequestState get topRatedTVSeriesState => _topRatedTVSeriesState;

  var _onTheAirTVSeries = <TVSeries>[];
  List<TVSeries> get onTheAirTVSeries => _onTheAirTVSeries;

  RequestState _onTheAirTVSeriesState = RequestState.Empty;
  RequestState get onTheAirTVSeriesState => _onTheAirTVSeriesState;

  var _popularTVSeries = <TVSeries>[];
  List<TVSeries> get popularTVSeries => _popularTVSeries;

  RequestState _popularTVSeriesState = RequestState.Empty;
  RequestState get popularTVSeriesState => _popularTVSeriesState;

  String _message = '';
  String get message => _message;

  final GetAirTodayTVSeries getAirTodayTVSeries;
  final GetTopRatedTVSeries getTopRatedTVSeries;
  final GetOnTheAirTVSeries getOnTheAirTVSeries;
  final GetPopularTVSeries getPopularTVSeries;

  TVSeriesListNotifier({
    required this.getAirTodayTVSeries,
    required this.getTopRatedTVSeries,
    required this.getOnTheAirTVSeries,
    required this.getPopularTVSeries,
  });

  Future<void> fetchAirTodayTVSeries() async {
    _airingTodayTVSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getAirTodayTVSeries.execute();

    result.fold(
      (failure) {
        _airingTodayTVSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _airingTodayTVSeriesState = RequestState.Loaded;
        _airingTodayTVSeries = data;
        notifyListeners();
      }
    );
  }

  Future<void> fetchOnTheAirTVSeries() async {
    _onTheAirTVSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getOnTheAirTVSeries.execute();

    result.fold(
      (failure) {
        _onTheAirTVSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _onTheAirTVSeriesState = RequestState.Loaded;
        _onTheAirTVSeries = data;
        notifyListeners();
      }
    );
  }
  
  Future<void> fetchPopularTVSeries() async {
    _popularTVSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularTVSeries.execute();

    result.fold(
      (failure) {
        _popularTVSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _popularTVSeriesState = RequestState.Loaded;
        _popularTVSeries = data;
        notifyListeners();
      }
    );
  }

  Future<void> fetchTopRatedTVSeries() async {
    _topRatedTVSeriesState = RequestState.Loading;
    notifyListeners();

    final result = await getTopRatedTVSeries.execute();

    result.fold(
      (failure) {
        _topRatedTVSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (data) {
        _topRatedTVSeriesState = RequestState.Loaded;
        _topRatedTVSeries = data;
        notifyListeners();
      }
    );
  }
}
