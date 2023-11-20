import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/tvseries.dart';

part 'tv_series_more_event.dart';
part 'tv_series_more_state.dart';

class TVSeriesMoreBloc extends Bloc<TVSeriesMoreEvent, TVSeriesMoreState> {
  final GetTopRatedTVSeries getTopRatedTVSeries;
  final GetAirTodayTVSeries getAirTodayTVSeries;
  final GetPopularTVSeries getPopularTVSeries;
  final GetOnTheAirTVSeries getOnTheAirTVSeries;

  TVSeriesMoreBloc({
    required this.getTopRatedTVSeries,
    required this.getAirTodayTVSeries,
    required this.getPopularTVSeries,
    required this.getOnTheAirTVSeries,
  }) : super(TVSeriesMoreEmpty()) {
    on<OnInitialFetchTVSeriesMore>((event, emit) async {
      final type = event.type;
      final Either<Failure, List<TVSeries>> result;
      emit(TVSeriesMoreLoading());

      if (type == TVSeriesMoreType.topRated) {
        result = await getTopRatedTVSeries.execute();
      } else if (type == TVSeriesMoreType.airingToday) {
        result = await getAirTodayTVSeries.execute();
      } else if (type == TVSeriesMoreType.onTheAir) {
        result = await getOnTheAirTVSeries.execute();
      } else {
        result = await getPopularTVSeries.execute();
      }

      result.fold(
        (failure) {
          emit(TVSeriesMoreError(failure.message));
        },
        (data) {
          emit(TVSeriesMoreLoaded(data));
        },
      );
    });
  }
}
