part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class OnLoadMovieDetail extends MovieDetailEvent {
  final int id;

  const OnLoadMovieDetail(this.id);

  @override
  List<Object> get props => [id];
}

class OnLoadMovieRecommendation extends MovieDetailEvent {
  final int id;

  const OnLoadMovieRecommendation(this.id);

  @override
  List<Object> get props => [id];
}

class OnLoadWatchlistStatus extends MovieDetailEvent {
  final int id;

  const OnLoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}

class OnButtonWatchlistTapped extends MovieDetailEvent {
  final MovieDetail movie;

  const OnButtonWatchlistTapped(this.movie);

  @override
  List<Object> get props => [movie];
}