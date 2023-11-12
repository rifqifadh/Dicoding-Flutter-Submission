import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/tvseries.dart';

part 'tv_series_detail_event.dart';
part 'tv_series_detail_state.dart';

class TVSeriesDetailBloc
    extends Bloc<TVSeriesDetailEvent, TVSeriesDetailState> {
  final GetTVSeriesDetail getTVSeriesDetail;
  final GetTVSeriesRecommendations getTVSeriesRecommendations;
  final GetWatchListStatusTVSeries getWatchListStatus;
  final SaveWatchlistTVSeries saveWatchlist;
  final RemoveWatchlistTVSeries removeWatchlist;

  TVSeriesDetailBloc({
    required this.getTVSeriesDetail,
    required this.getTVSeriesRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(TVSeriesDetailState.initial()) {
    on<OnLoadTVSeriesDetail>((event, emit) async {
      emit(state.copyWith(tvSeriesDetailState: RequestState.Loading));
      final detailResult = await getTVSeriesDetail.execute(event.id);

      detailResult.fold(
        (failure) {
          emit(state.copyWith(
              tvSeriesDetailState: RequestState.Error,
              message: failure.message));
        },
        (tvSeries) async {
          emit(state.copyWith(
              tvSeries: tvSeries, tvSeriesDetailState: RequestState.Loaded));
        },
      );
    });

    on<OnLoadTVSeriesRecommendation>((event, emit) async {
      emit(state.copyWith(tvSeriesRecommendationsState: RequestState.Loading));
      final recommendationResult =
          await getTVSeriesRecommendations.execute(event.id);

      recommendationResult.fold(
        (failure) {
          emit(state.copyWith(
              tvSeriesRecommendationsState: RequestState.Error,
              message: failure.message));
        },
        (tvSeries) async {
          emit(state.copyWith(
              tvSeriesRecommendations: tvSeries,
              tvSeriesRecommendationsState: RequestState.Loaded));
        },
      );
    });

    on<OnButtonWatchlistTapped>((event, emit) async {
      if (state.isAddedToWatchlist) {
        final result = await removeWatchlist.execute(event.tvSeries);
        watchlistResult(event.tvSeries.id, result, event, emit, false);
      } else {
        final result = await saveWatchlist.execute(event.tvSeries);
        watchlistResult(event.tvSeries.id, result, event, emit, true);
      }
    });

    on<OnLoadWatchlistStatus>((event, emit) async {
      final watchlistResult = await getWatchListStatus.execute(event.id);
      emit(state.copyWith(isAddedToWatchlist: watchlistResult));      
    });
  }

  void watchlistResult(
      int id,
      Either<Failure, String> result,
      TVSeriesDetailEvent event,
      Emitter<TVSeriesDetailState> emit,
      bool isAddedToWatchlist,
    ) {
      result.fold(
        (failure) {
          emit(state.copyWith(
              message: failure.message, isAddedToWatchlist: false));
        },
        (value) {
          emit(state.copyWith(
              watchlistMessage: value,
              isAddedToWatchlist: isAddedToWatchlist));
        },
      );
    }
}
