
part of 'watchlist_bloc.dart';

abstract class WatchlistEvent extends Equatable {
  const WatchlistEvent();

  @override
  List<Object> get props => [];
}

class OnLoadWatchlist extends WatchlistEvent {
  const OnLoadWatchlist();

  @override
  List<Object> get props => [];
}