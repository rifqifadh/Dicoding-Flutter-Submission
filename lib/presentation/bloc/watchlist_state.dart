part of 'watchlist_bloc.dart';

class WatchlistState extends Equatable {
  final List<Watchlist> watchlist;
  final RequestState state;
  final String message;

  WatchlistState(
      {required this.watchlist, required this.state, required this.message});

  factory WatchlistState.initial() => WatchlistState(
        watchlist: [],
        state: RequestState.Empty,
        message: '',
      );

  @override
  List<Object> get props => [watchlist, state, message];

  WatchlistState copyWith({
    List<Watchlist>? watchlist,
    RequestState? state,
    String? message,
  }) {
    return WatchlistState(
      watchlist: watchlist ?? this.watchlist,
      state: state ?? this.state,
      message: message ?? this.message,
    );
  }
}
