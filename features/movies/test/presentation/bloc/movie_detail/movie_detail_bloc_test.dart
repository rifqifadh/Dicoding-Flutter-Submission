import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';

import '../../../dummy_data/dummy_object.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieDetailBloc = MovieDetailBloc(
      getMovieDetail: mockGetMovieDetail,
      getMovieRecommendations: mockGetMovieRecommendations,
      getWatchListStatus: mockGetWatchListStatus,
      saveWatchlist: mockSaveWatchlist,
      removeWatchlist: mockRemoveWatchlist,
    );
  });

  const tId = 1;

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: const [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovies = <Movie>[tMovie];

  test('initial state should be empty', () {
    expect(movieDetailBloc.state.movieDetailState, RequestState.Empty);
  });

  blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit Data when fetch is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => const Right(testMovieDetail));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const OnLoadMovieDetail(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () {
        return [
          MovieDetailState.initial()
              .copyWith(movieDetailState: RequestState.Loading),
          MovieDetailState.initial().copyWith(
              movieDetailState: RequestState.Loaded, movie: testMovieDetail),
        ];
      },
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      });

  blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit Error when fetch is unsuccessful',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const OnLoadMovieDetail(tId)),
      wait: const Duration(milliseconds: 1),
      expect: () {
        return [
          MovieDetailState.initial()
              .copyWith(movieDetailState: RequestState.Loading),
          MovieDetailState.initial().copyWith(
              movieDetailState: RequestState.Error, message: 'Server Failure'),
        ];
      },
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      });

  blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit Data when fetch movie recommendation is successfully',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const OnLoadMovieRecommendation(tId)),
      wait: const Duration(milliseconds: 1),
      expect: () {
        return [
          MovieDetailState.initial()
              .copyWith(movieRecommendationsState: RequestState.Loading),
          MovieDetailState.initial().copyWith(
              movieRecommendationsState: RequestState.Loaded,
              movieRecommendations: tMovies),
        ];
      },
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      });

  blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit Error when fetch movie recommendation is unsuccessful',
      build: () {
        when(mockGetMovieRecommendations.execute(tId)).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const OnLoadMovieRecommendation(tId)),
      wait: const Duration(milliseconds: 1),
      expect: () {
        return [
          MovieDetailState.initial()
              .copyWith(movieRecommendationsState: RequestState.Loading),
          MovieDetailState.initial().copyWith(
              movieRecommendationsState: RequestState.Error,
              message: 'Server Failure'),
        ];
      },
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      });

  blocTest<MovieDetailBloc, MovieDetailState>(
      'Should Add to Wishlist with successful result',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const OnButtonWatchlistTapped(testMovieDetail)),
      wait: const Duration(milliseconds: 1),
      expect: () {
        return [
          MovieDetailState.initial().copyWith(
              isAddedToWatchlist: true, watchlistMessage: 'Added to Watchlist'),
        ];
      },
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      });

  blocTest<MovieDetailBloc, MovieDetailState>(
      'Should Add to Wishlist with unsucessful result',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
            (_) async => const Left(DatabaseFailure('Database Failure')));
        when(mockGetWatchListStatus.execute(tId))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(const OnButtonWatchlistTapped(testMovieDetail)),
      wait: const Duration(milliseconds: 1),
      expect: () {
        return [
          MovieDetailState.initial().copyWith(
              isAddedToWatchlist: false, watchlistMessage: 'Database Failure'),
        ];
      },
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      });
}
