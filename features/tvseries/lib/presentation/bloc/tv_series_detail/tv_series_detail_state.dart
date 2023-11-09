// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'tv_series_detail_bloc.dart';

class TVSeriesDetailState extends Equatable {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final  TVSeriesDetail tvSeries;
  final RequestState tvSeriesDetailState;
  final List<TVSeries> tvSeriesRecommendations;
  final RequestState tvSeriesRecommendationsState;
  final bool isAddedToWatchlist;
  final String message;
  final String watchlistMessage;

  const TVSeriesDetailState({
    required this.tvSeries,
    required this.tvSeriesDetailState,
    required this.tvSeriesRecommendations,
    required this.tvSeriesRecommendationsState,
    required this.isAddedToWatchlist,
    this.message = '',
    this.watchlistMessage = '',
  });

  //tambahkan juga factory contructor untuk membuat initial state nya
  factory TVSeriesDetailState.initial() => TVSeriesDetailState(
    tvSeries: TVSeriesDetail.empty(),
    tvSeriesDetailState: RequestState.Empty,
    tvSeriesRecommendations: const [],
    tvSeriesRecommendationsState: RequestState.Empty,
    isAddedToWatchlist: false,
  );

  @override
  List<Object> get props {
    return [
      tvSeries,
      tvSeriesDetailState,
      tvSeriesRecommendations,
      tvSeriesRecommendationsState,
      isAddedToWatchlist,
    ];
  }  

  TVSeriesDetailState copyWith({
    TVSeriesDetail? tvSeries,
    RequestState? tvSeriesDetailState,
    List<TVSeries>? tvSeriesRecommendations,
    RequestState? tvSeriesRecommendationsState,
    bool? isAddedToWatchlist,
    String? message,
    String? watchlistMessage,
  }) {
    return TVSeriesDetailState(
      tvSeries: tvSeries ?? this.tvSeries,
      tvSeriesDetailState: tvSeriesDetailState ?? this.tvSeriesDetailState,
      tvSeriesRecommendations: tvSeriesRecommendations ?? this.tvSeriesRecommendations,
      tvSeriesRecommendationsState: tvSeriesRecommendationsState ?? this.tvSeriesRecommendationsState,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
    );
  }
}
