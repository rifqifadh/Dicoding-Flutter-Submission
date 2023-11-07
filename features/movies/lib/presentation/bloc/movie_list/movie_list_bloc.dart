import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListBloc({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(MovieListState.initial()) {
    on<FetchNowPlayingMovies>((event, emit) async {
      emit(state.copyWith(nowPlayingState: RequestState.Loading));
      final result = await getNowPlayingMovies.execute();

      result.fold((failure) {
        emit(state.copyWith(
            nowPlayingState: RequestState.Error,
            errorMessage: failure.message));
      }, (movie) {
        emit(state.copyWith(
            nowPlayingState: RequestState.Loaded, nowPlayingMovies: movie));
      });
    });

    on<FetchPopularMovies>((event, emit) async {
      emit(state.copyWith(popularMoviesState: RequestState.Loading));
      final result = await getPopularMovies.execute();

      result.fold((failure) {
        emit(state.copyWith(
            popularMoviesState: RequestState.Error,
            errorMessage: failure.message));
      }, (movie) {
        emit(state.copyWith(
            popularMoviesState: RequestState.Loaded, popularMovies: movie));
      });
    });

    on<FetchTopRatedMovies>((event, emit) async {
      emit(state.copyWith(topRatedMoviesState: RequestState.Loading));
      final result = await getTopRatedMovies.execute();

      result.fold((failure) {
        emit(state.copyWith(
            topRatedMoviesState: RequestState.Error,
            errorMessage: failure.message));
      }, (movie) {
        emit(state.copyWith(
            topRatedMoviesState: RequestState.Loaded, topRatedMovies: movie));
      });
    });
  }
}
