import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/tvseries.dart';

part 'tv_series_list_state.dart';
part 'tv_series_list_event.dart';

class TVSeriesListBloc extends Bloc<TVSeriesListEvent, TVSeriesListState> {
  final GetAirTodayTVSeries getAirTodayTVSeries;
  final GetOnTheAirTVSeries getOnTheAirTVSeries;
  final GetPopularTVSeries getPopularTVSeries;
  final GetTopRatedTVSeries getTopRatedTVSeries;

  TVSeriesListBloc({
    required this.getAirTodayTVSeries,
    required this.getOnTheAirTVSeries,
    required this.getPopularTVSeries,
    required this.getTopRatedTVSeries,
  }) : super(TVSeriesListState.initial()) {
    on<FetchAiringTodayTVSeries>((event, emit) async {
      emit(state.copyWith(airingTodayTVSeriesState: RequestState.Loading));
      final result = await getAirTodayTVSeries.execute();

      result.fold((failure) {
        emit(state.copyWith(
            airingTodayTVSeriesState: RequestState.Error,
            errorMessage: failure.message));
      }, (tvSeries) {
        emit(state.copyWith(
            airingTodayTVSeriesState: RequestState.Loaded,
            airingTodayTVSeries: tvSeries));
      });
    });

    on<FetchOnTheAirTVSeries>((event, emit) async {
      emit(state.copyWith(onTheAirTVSeriesState: RequestState.Loading));
      final result = await getOnTheAirTVSeries.execute();

      result.fold((failure) {
        emit(state.copyWith(
            onTheAirTVSeriesState: RequestState.Error,
            errorMessage: failure.message));
      }, (tvSeries) {
        emit(state.copyWith(
            onTheAirTVSeriesState: RequestState.Loaded,
            onTheAirTVSeries: tvSeries));
      });
    });

    on<FetchPopularTVSeries>((event, emit) async {
      emit(state.copyWith(popularTVSeriesState: RequestState.Loading));
      final result = await getPopularTVSeries.execute();

      result.fold((failure) {
        emit(state.copyWith(
            popularTVSeriesState: RequestState.Error,
            errorMessage: failure.message));
      }, (tvSeries) {
        emit(state.copyWith(
            popularTVSeriesState: RequestState.Loaded,
            popularTVSeries: tvSeries));
      });
    });

    on<FetchTopRatedTVSeries>((event, emit) async {
      emit(state.copyWith(topRatedTVSeriesState: RequestState.Loading));
      final result = await getTopRatedTVSeries.execute();

      result.fold((failure) {
        emit(state.copyWith(
            topRatedTVSeriesState: RequestState.Error,
            errorMessage: failure.message));
      }, (tvSeries) {
        emit(state.copyWith(
            topRatedTVSeriesState: RequestState.Loaded,
            topRatedTVSeries: tvSeries));
      });
    });
  }
}