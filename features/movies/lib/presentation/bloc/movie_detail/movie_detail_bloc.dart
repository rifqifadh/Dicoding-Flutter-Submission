import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  MovieDetailBloc({
    required this.getMovieDetail,
    required this.getMovieRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieDetailState.initial()) {
    on<OnLoadMovieDetail>((event, emit) async {
      emit(state.copyWith(movieDetailState: RequestState.Loading));
      final detailResult = await getMovieDetail.execute(event.id);

      detailResult.fold(
        (failure) {
          emit(state.copyWith(
              movieDetailState: RequestState.Error, message: failure.message));
        },
        (movie) async {
          emit(state.copyWith(
              movie: movie, movieDetailState: RequestState.Loaded));
        },
      );
    });

    on<OnLoadMovieRecommendation>((event, emit) async {
      emit(state.copyWith(movieRecommendationsState: RequestState.Loading));
      final recommendationResult =
          await getMovieRecommendations.execute(event.id);

      recommendationResult.fold(
        (failure) {
          emit(state.copyWith(
              movieRecommendationsState: RequestState.Error,
              message: failure.message));
        },
        (movies) async {
          emit(state.copyWith(
              movieRecommendations: movies,
              movieRecommendationsState: RequestState.Loaded));
        },
      );
    });

    on<OnButtonWatchlistTapped>((event, emit) async {
      final isAddedToWatchlist = state.isAddedToWatchlist;
      if (isAddedToWatchlist) {
        final result = await removeWatchlist.execute(event.movie);
        watchlistResult(result, event, emit, false);
      } else {
        final result = await saveWatchlist.execute(event.movie);
        watchlistResult(result, event, emit, true);
      }
      add(OnLoadWatchlistStatus(event.movie.id));
    });

    on<OnLoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: result));
    });
  }

  void watchlistResult(
      Either<Failure, String> result,
      OnButtonWatchlistTapped event,
      Emitter<MovieDetailState> emit,
      bool isAdded) {
    result.fold(
      (failure) {
        emit(state.copyWith(
            isAddedToWatchlist: false, watchlistMessage: failure.message));
      },
      (value) {
        emit(state.copyWith(
            isAddedToWatchlist: isAdded, watchlistMessage: value));
      },
    );
  }
}
