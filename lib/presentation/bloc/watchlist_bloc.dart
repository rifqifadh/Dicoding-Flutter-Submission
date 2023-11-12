
import 'package:core/core.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:ditonton/domain/usecases/get_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlist getWatchlist;

  WatchlistBloc({
    required this.getWatchlist,
  }) : super(WatchlistState.initial()) {
    on<OnLoadWatchlist>((event, emit) async {
      emit(state.copyWith(state: RequestState.Loading));
      final result = await getWatchlist.execute();

      result.fold(
        (failure) {
          emit(state.copyWith(state: RequestState.Error, message: failure.message));
        },
        (watchlist) async {
          emit(state.copyWith(state: RequestState.Loaded, watchlist: watchlist));
        },
      );
    });
  }
}