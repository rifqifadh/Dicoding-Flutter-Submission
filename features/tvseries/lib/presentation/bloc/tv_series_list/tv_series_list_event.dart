
part of 'tv_series_list_bloc.dart';

abstract class TVSeriesListEvent extends Equatable {
  const TVSeriesListEvent();

  @override
  List<Object?> get props => [];
}

class FetchPopularTVSeries extends TVSeriesListEvent {
  @override
  List<Object?> get props => [];
}

class FetchTopRatedTVSeries extends TVSeriesListEvent {
  @override
  List<Object?> get props => [];
}

class FetchOnTheAirTVSeries extends TVSeriesListEvent {
  @override
  List<Object?> get props => [];
}

class FetchAiringTodayTVSeries extends TVSeriesListEvent {
  @override
  List<Object?> get props => [];
}