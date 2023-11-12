part of 'movie_list_bloc.dart';

class MovieListState extends Equatable {
  final List<Movie> nowPlayingMovies;
  final List<Movie> popularMovies;
  final List<Movie> topRatedMovies;

  final RequestState nowPlayingState;
  final RequestState popularMoviesState;
  final RequestState topRatedMoviesState;

  final String errorMessage;

  const MovieListState({
    required this.nowPlayingMovies,
    required this.popularMovies,
    required this.topRatedMovies,
    required this.nowPlayingState,
    required this.popularMoviesState,
    required this.topRatedMoviesState,
    required this.errorMessage,
  });

  factory MovieListState.initial() =>
    const MovieListState(
      nowPlayingMovies: [],
      popularMovies: [],
      topRatedMovies: [],
      nowPlayingState: RequestState.Empty,
      popularMoviesState: RequestState.Empty,
      topRatedMoviesState: RequestState.Empty,
      errorMessage: '',
    );

  MovieListState copyWith({
    List<Movie>? nowPlayingMovies,
    List<Movie>? popularMovies,
    List<Movie>? topRatedMovies,
    RequestState? nowPlayingState,
    RequestState? popularMoviesState,
    RequestState? topRatedMoviesState,
    String? errorMessage,
  }) {
    return MovieListState(
      nowPlayingMovies: nowPlayingMovies ?? this.nowPlayingMovies,
      popularMovies: popularMovies ?? this.popularMovies,
      topRatedMovies: topRatedMovies ?? this.topRatedMovies,
      nowPlayingState: nowPlayingState ?? this.nowPlayingState,
      popularMoviesState: popularMoviesState ?? this.popularMoviesState,
      topRatedMoviesState: topRatedMoviesState ?? this.topRatedMoviesState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props {
    return [
      nowPlayingMovies,
      popularMovies,
      topRatedMovies,
      nowPlayingState,
      popularMoviesState,
      topRatedMoviesState,
      errorMessage,
    ];
  }
}
