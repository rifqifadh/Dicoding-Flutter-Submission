
part of 'tv_series_more_bloc.dart';

abstract class TVSeriesMoreState extends Equatable {
  const TVSeriesMoreState();

  @override
  List<Object> get props => [];
}

class TVSeriesMoreEmpty extends TVSeriesMoreState {}
class TVSeriesMoreLoading extends TVSeriesMoreState {}
class TVSeriesMoreError extends TVSeriesMoreState {
  final String message;

  const TVSeriesMoreError(this.message);

  @override
  List<Object> get props => [message];
}
class TVSeriesMoreLoaded extends TVSeriesMoreState {
  final List<TVSeries> tvSeries;

  const TVSeriesMoreLoaded(this.tvSeries);

  @override
  List<Object> get props => [tvSeries];
}
