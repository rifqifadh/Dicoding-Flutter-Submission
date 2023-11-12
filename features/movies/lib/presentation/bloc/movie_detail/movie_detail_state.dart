part of 'movie_detail_bloc.dart';

class MovieDetailState extends Equatable {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  
  final MovieDetail movie;
  final RequestState movieDetailState;
  final List<Movie> movieRecommendations;
  final RequestState movieRecommendationsState;
  final bool isAddedToWatchlist;
  final String message;
  final String watchlistMessage;
  
  const MovieDetailState({
    required this.movie,
    required this.movieDetailState,
    required this.movieRecommendations,
    required this.movieRecommendationsState,
    required this.isAddedToWatchlist,
    this.message = '',
    this.watchlistMessage = '',
});

  factory MovieDetailState.initial() => MovieDetailState(
    movie: MovieDetail.empty(),
    movieDetailState: RequestState.Empty,
    movieRecommendations: const [],
    movieRecommendationsState: RequestState.Empty,
    isAddedToWatchlist: false,
  );

  @override
  List<Object> get props {
    return [
      movie,
      movieDetailState,
      movieRecommendations,
      movieRecommendationsState,
      isAddedToWatchlist,
    ];
  }

  MovieDetailState copyWith({
    MovieDetail? movie,
    RequestState? movieDetailState,
    List<Movie>? movieRecommendations,
    RequestState? movieRecommendationsState,
    bool? isAddedToWatchlist,
    String? message,
    String? watchlistMessage,
  }) {
    return MovieDetailState(
      movie: movie ?? this.movie,
      movieDetailState: movieDetailState ?? this.movieDetailState,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
      movieRecommendationsState: movieRecommendationsState ?? this.movieRecommendationsState,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      message: message ?? this.message,
      watchlistMessage: watchlistMessage ?? this.watchlistMessage,
    );
  }
}

