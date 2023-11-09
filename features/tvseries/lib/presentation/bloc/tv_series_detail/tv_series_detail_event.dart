
part of 'tv_series_detail_bloc.dart';

abstract class TVSeriesDetailEvent extends Equatable {
  const TVSeriesDetailEvent();

  @override
  List<Object?> get props => [];
}

class OnLoadTVSeriesDetail extends TVSeriesDetailEvent {
  final int id;

  const OnLoadTVSeriesDetail(this.id);

  @override
  List<Object?> get props => [id];
}

class OnLoadTVSeriesRecommendation extends TVSeriesDetailEvent {
  final int id;

  const OnLoadTVSeriesRecommendation(this.id);

  @override
  List<Object?> get props => [id];
}

class OnLoadWatchlistStatus extends TVSeriesDetailEvent {
  final int id;

  const OnLoadWatchlistStatus(this.id);

  @override
  List<Object?> get props => [id];
}

class OnButtonWatchlistTapped extends TVSeriesDetailEvent {
  final TVSeriesDetail tvSeries;

  const OnButtonWatchlistTapped(this.tvSeries);

  @override
  List<Object?> get props => [tvSeries];
}