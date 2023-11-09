

part of 'search_tv_series_bloc.dart';

abstract class SearchTVSeriesState extends Equatable {
  const SearchTVSeriesState();

  @override
  List<Object> get props => [];
}

class SearchTVSeriesEmpty extends SearchTVSeriesState {}
class SearchTVSeriesLoading extends SearchTVSeriesState {}
class SearchTVSeriesError extends SearchTVSeriesState {
  final String message;

  const SearchTVSeriesError(this.message);

  @override
  List<Object> get props => [message];
}
class SearchTVSeriesLoaded extends SearchTVSeriesState {
  final List<TVSeries> searchResult;

  const SearchTVSeriesLoaded(this.searchResult);

  @override
  List<Object> get props => [searchResult];
}
