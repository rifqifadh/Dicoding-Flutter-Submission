
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/tvseries.dart';

part 'search_tv_series_event.dart';
part 'search_tv_series_state.dart';

class SearchTVSeriesBloc extends Bloc<SearchTVSeriesEvent, SearchTVSeriesState> {
  final SearchTVSeries searchTVSeries;

  SearchTVSeriesBloc({required this.searchTVSeries}) : super(SearchTVSeriesEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;
      emit(SearchTVSeriesLoading());
      final result = await searchTVSeries.execute(query);

      result.fold(
        (failure) {
          emit(SearchTVSeriesError(failure.message));
        },
        (data) {
          emit(SearchTVSeriesLoaded(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}