import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late TVSeriesDetailBloc bloc;
  late MockGetTVSeriesDetail mockGetTVSeriesDetail;
  late MockGetTVSeriesRecommendations mockGetTVSeriesRecommendations;
  late MockGetWatchListStatusTVSeries mockGetWatchListStatusTVSeries;
  late MockSaveWatchlistTVSeries mockSaveWatchlistTVSeries;
  late MockRemoveWatchlistTVSeries mockRemoveWatchlistTVSeries;

  setUp(() {
    mockGetTVSeriesDetail = MockGetTVSeriesDetail();
    mockGetTVSeriesRecommendations = MockGetTVSeriesRecommendations();
    mockGetWatchListStatusTVSeries = MockGetWatchListStatusTVSeries();
    mockSaveWatchlistTVSeries = MockSaveWatchlistTVSeries();
    mockRemoveWatchlistTVSeries = MockRemoveWatchlistTVSeries();
    bloc = TVSeriesDetailBloc(
      getTVSeriesDetail: mockGetTVSeriesDetail,
      getTVSeriesRecommendations: mockGetTVSeriesRecommendations,
      getWatchListStatus: mockGetWatchListStatusTVSeries,
      saveWatchlist: mockSaveWatchlistTVSeries,
      removeWatchlist: mockRemoveWatchlistTVSeries,
    );
  });

  const id = 1;

  blocTest(
    'Should emit tvSeries when fetch detail is success',
    build: () {
      when(mockGetTVSeriesDetail.execute(id))
          .thenAnswer((_) async => Right(testTVSeriesDetail));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnLoadTVSeriesDetail(id)),
    expect: () => [
      TVSeriesDetailState.initial().copyWith(
        tvSeriesDetailState: RequestState.Loading,
      ),
      TVSeriesDetailState.initial().copyWith(
        tvSeriesDetailState: RequestState.Loaded,
        tvSeries: testTVSeriesDetail,
      ),
    ],
    verify: (bloc) {
      verify(mockGetTVSeriesDetail.execute(id));
    },
  );

  blocTest(
    'Should emit error when fetch detail is failure',
    build: () {
      when(mockGetTVSeriesDetail.execute(id))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnLoadTVSeriesDetail(id)),
    expect: () => [
      TVSeriesDetailState.initial().copyWith(
        tvSeriesDetailState: RequestState.Loading,
      ),
      TVSeriesDetailState.initial().copyWith(
        tvSeriesDetailState: RequestState.Error,
        message: 'Server Failure',
      ),
    ],
    verify: (bloc) => verify(mockGetTVSeriesDetail.execute(id)),
  );

  blocTest(
    'Should emit tvSeriesRecommendations when fetch recommendation is success',
    build: () {
      when(mockGetTVSeriesRecommendations.execute(id))
          .thenAnswer((_) async => Right(testTVSeriesList));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnLoadTVSeriesRecommendation(id)),
    expect: () => [
      TVSeriesDetailState.initial().copyWith(
        tvSeriesRecommendationsState: RequestState.Loading,
      ),
      TVSeriesDetailState.initial().copyWith(
        tvSeriesRecommendationsState: RequestState.Loaded,
        tvSeriesRecommendations: testTVSeriesList,
      ),
    ],
    verify: (bloc) => verify(mockGetTVSeriesRecommendations.execute(id)),
  );

  blocTest(
    'Should emit error when fetch recommendation is failure',
    build: () {
      when(mockGetTVSeriesRecommendations.execute(id))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnLoadTVSeriesRecommendation(id)),
    expect: () => [
      TVSeriesDetailState.initial().copyWith(
        tvSeriesRecommendationsState: RequestState.Loading,
      ),
      TVSeriesDetailState.initial().copyWith(
        tvSeriesRecommendationsState: RequestState.Error,
        message: 'Server Failure',
      ),
    ],
    verify: (bloc) => verify(mockGetTVSeriesRecommendations.execute(id)),
  );

  blocTest(
    'Should Add to Wishlist with successful result',
    build: () {
      when(mockSaveWatchlistTVSeries.execute(testTVSeriesDetail))
          .thenAnswer((_) async => const Right('Added to Watchlist'));
      when(mockGetWatchListStatusTVSeries.execute(id))
          .thenAnswer((_) async => true);
      return bloc;
    },
    act: (bloc) => bloc.add(OnButtonWatchlistTapped(testTVSeriesDetail)),
    expect: () => [
      TVSeriesDetailState.initial().copyWith(
        isAddedToWatchlist: true,
        watchlistMessage: 'Added to Watchlist',
      ),
    ],
    verify: (bloc) =>
        verify(mockSaveWatchlistTVSeries.execute(testTVSeriesDetail)),
  );

  blocTest(
    'Should add to Wishlist with unsuccessful result',
    build: () {
      when(mockSaveWatchlistTVSeries.execute(testTVSeriesDetail)).thenAnswer(
          (_) async => const Left(DatabaseFailure('Database Failure')));
      when(mockGetWatchListStatusTVSeries.execute(id))
          .thenAnswer((_) async => false);
      return bloc;
    },
    act: (bloc) => bloc.add(OnButtonWatchlistTapped(testTVSeriesDetail)),
    expect: () => [
      TVSeriesDetailState.initial().copyWith(
        isAddedToWatchlist: false,
        message: 'Database Failure',
      ),
    ],
    verify: (bloc) =>
        verify(mockSaveWatchlistTVSeries.execute(testTVSeriesDetail)),
  );

  blocTest(
    'Should check watchlist status', 
    build: () {
    when(mockGetWatchListStatusTVSeries.execute(id))
        .thenAnswer((_) async => true);
        return bloc;
    },
    act: (bloc) => bloc.add(const OnLoadWatchlistStatus(id)),
    expect: () => [
      TVSeriesDetailState.initial().copyWith(
        isAddedToWatchlist: true,
      ),
    ],
    verify: (bloc) => verify(mockGetWatchListStatusTVSeries.execute(id)),
    );
}
