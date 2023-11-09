
part of 'tv_series_more_bloc.dart';

abstract class TVSeriesMoreEvent extends Equatable {
  const TVSeriesMoreEvent();

  @override
  List<Object> get props => [];
}

class OnInitialFetchTVSeriesMore extends TVSeriesMoreEvent {
  final TVSeriesMoreType type;

  const OnInitialFetchTVSeriesMore(this.type);

  @override
  List<Object> get props => [type];
}