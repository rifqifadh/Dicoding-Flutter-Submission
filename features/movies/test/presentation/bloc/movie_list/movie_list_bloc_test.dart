import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';

import '../../../dummy_data/dummy_object.dart';
import '../../../helpers/test_helper.mocks.dart';

@GenerateMocks([MovieListBloc])
void main() {
  late MovieListBloc movieListBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieListBloc = MovieListBloc(
      getNowPlayingMovies: mockGetNowPlayingMovies,
      getPopularMovies: mockGetPopularMovies,
      getTopRatedMovies: mockGetTopRatedMovies,
    );
  });

  blocTest<MovieListBloc, MovieListState>(
    'Should emit [Loading, Data] when fetch PopularMovies success',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return movieListBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    expect: () {
      return [
        MovieListState.initial().copyWith(
          popularMoviesState: RequestState.Loading,
        ),
        MovieListState.initial().copyWith(
          popularMoviesState: RequestState.Loaded,
          popularMovies: testMovieList,
        ),
      ];
    },
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<MovieListBloc, MovieListState>(
    'Should emit [Loading and Error] when fetch PopularMovies Error',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieListBloc;
    },
    act: (bloc) => bloc.add(FetchPopularMovies()),
    expect: () {
      return [
        MovieListState.initial().copyWith(
          popularMoviesState: RequestState.Loading,
        ),
        MovieListState.initial().copyWith(
          popularMoviesState: RequestState.Error,
          errorMessage: 'Server Failure',
        ),
      ];
    },
    verify: (bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest<MovieListBloc, MovieListState>(
    'Should emit [Loading, Data] when fetch NowPlayingMovies success',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return movieListBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovies()),
    expect: () {
      return [
        MovieListState.initial().copyWith(
          nowPlayingState: RequestState.Loading,
        ),
        MovieListState.initial().copyWith(
          nowPlayingState: RequestState.Loaded,
          nowPlayingMovies: testMovieList,
        ),
      ];
    },
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<MovieListBloc, MovieListState>(
    'Should emit [Loading and Error] when fetch NowPlayingMovies Error',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieListBloc;
    },
    act: (bloc) => bloc.add(FetchNowPlayingMovies()),
    expect: () {
      return [
        MovieListState.initial().copyWith(
          nowPlayingState: RequestState.Loading,
        ),
        MovieListState.initial().copyWith(
          nowPlayingState: RequestState.Error,
          errorMessage: 'Server Failure',
        ),
      ];
    },
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<MovieListBloc, MovieListState>(
    'Should emit [Loading, Data] when fetch TopRatedMovies success',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => Right(testMovieList));
      return movieListBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovies()),
    expect: () {
      return [
        MovieListState.initial().copyWith(
          topRatedMoviesState: RequestState.Loading,
        ),
        MovieListState.initial().copyWith(
          topRatedMoviesState: RequestState.Loaded,
          topRatedMovies: testMovieList,
        ),
      ];
    },
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );

  blocTest<MovieListBloc, MovieListState>(
    'Should emit [Loading and Error] when fetch TopRatedMovies Error',
    build: () {
      when(mockGetTopRatedMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return movieListBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedMovies()),
    expect: () {
      return [
        MovieListState.initial().copyWith(
          topRatedMoviesState: RequestState.Loading,
        ),
        MovieListState.initial().copyWith(
          topRatedMoviesState: RequestState.Error,
          errorMessage: 'Server Failure',
        ),
      ];
    },
    verify: (bloc) {
      verify(mockGetTopRatedMovies.execute());
    },
  );
}
