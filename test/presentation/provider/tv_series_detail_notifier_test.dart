

import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import 'package:ditonton/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_recommendation.dart';
import 'package:ditonton/domain/usecases/tv_series/get_watchlist_status_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/remove_watchlist_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/save_watchlist_tv_series.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_detail_notifier_test.mocks.dart';

@GenerateMocks([GetTVSeriesDetail, GetTVSeriesRecommendations, SaveWatchlistTVSeries, RemoveWatchlistTVSeries, GetWatchListStatusTVSeries])
void main() {
  late TVSeriesDetailNotifier provider;
  late MockGetTVSeriesDetail mockGetTVSeriesDetail;
  late MockGetTVSeriesRecommendations mockGetTVSeriesRecommendations;
  late MockSaveWatchlistTVSeries mockSaveWatchlistTVSeries;
  late MockRemoveWatchlistTVSeries mockRemoveWatchlistTVSeries;
  late MockGetWatchListStatusTVSeries mockGetWatchListStatusTVSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTVSeriesDetail = MockGetTVSeriesDetail();
    mockGetTVSeriesRecommendations = MockGetTVSeriesRecommendations();
    mockSaveWatchlistTVSeries = MockSaveWatchlistTVSeries();
    mockRemoveWatchlistTVSeries = MockRemoveWatchlistTVSeries();
    mockGetWatchListStatusTVSeries = MockGetWatchListStatusTVSeries();
    provider = TVSeriesDetailNotifier(
      getTVSeriesDetail: mockGetTVSeriesDetail,
      getTVSeriesRecommendations: mockGetTVSeriesRecommendations,
      saveWatchlist: mockSaveWatchlistTVSeries,
      removeWatchlist: mockRemoveWatchlistTVSeries,
      getWatchListStatus: mockGetWatchListStatusTVSeries,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  final tvSeriesId = 1;

  void _arrangeUsecase() {
    when(mockGetTVSeriesDetail.execute(tvSeriesId))
    .thenAnswer((_) async => Right(testTVSeriesDetail));

    when(mockGetTVSeriesRecommendations.execute(tvSeriesId))
    .thenAnswer((_) async => Right(testTVSeriesList));
  }

  group('On Initialization to hit detail and reccomendation ', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.onInitialization(tvSeriesId);
      // assert
      verify(mockGetTVSeriesDetail.execute(tvSeriesId));
      verify(mockGetTVSeriesRecommendations.execute(tvSeriesId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.onInitialization(tvSeriesId);
      // assert
      expect(provider.tvSeriesDetailState, equals(RequestState.Loading));
      expect(listenerCallCount, 2);
    });

    test('should change tv series detail when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.onInitialization(tvSeriesId);
      // assert
      expect(provider.tvSeriesDetailState, equals(RequestState.Loaded));
      expect(provider.tvSeriesDetail, testTVSeriesDetail);
      expect(listenerCallCount, 4);
    });

    test('should change recommendation tv series when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.onInitialization(tvSeriesId);
      // assert
      expect(provider.tvSeriesDetailState, equals(RequestState.Loaded));
      expect(provider.tvSeriesRecommendations, testTVSeriesList);
      expect(listenerCallCount, 4);
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchListStatusTVSeries.execute(tvSeriesId))
      .thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(tvSeriesId);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called success', () async {
      // arrange
      when(mockSaveWatchlistTVSeries.execute(testTVSeriesDetail))
      .thenAnswer((_) async => Right('Added to Watchlist'));

      when(mockGetWatchListStatusTVSeries.execute(testTVSeriesDetail.id))
      .thenAnswer((_) async => true);
      // act
      await provider.addWatchlist(testTVSeriesDetail);
      // assert
      verify(mockSaveWatchlistTVSeries.execute(testTVSeriesDetail));
      verify(mockGetWatchListStatusTVSeries.execute(testTVSeriesDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should execute save watchlist when function called failure', () async {
      // arrange
      when(mockSaveWatchlistTVSeries.execute(testTVSeriesDetail))
      .thenAnswer((_) async => Left(DatabaseFailure('Failed')));

      when(mockGetWatchListStatusTVSeries.execute(testTVSeriesDetail.id))
      .thenAnswer((_) async => false);
      // act
      await provider.addWatchlist(testTVSeriesDetail);
      // assert
      verify(mockSaveWatchlistTVSeries.execute(testTVSeriesDetail));
      verify(mockGetWatchListStatusTVSeries.execute(testTVSeriesDetail.id));
      expect(provider.isAddedToWatchlist, false);
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveWatchlistTVSeries.execute(testTVSeriesDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchListStatusTVSeries.execute(testTVSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTVSeriesDetail);
      // assert
      verify(mockRemoveWatchlistTVSeries.execute(testTVSeriesDetail));
      expect(provider.isAddedToWatchlist, false);
      expect(provider.watchlistMessage, 'Removed');
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTVSeriesDetail.execute(tvSeriesId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTVSeriesRecommendations.execute(tvSeriesId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.onInitialization(tvSeriesId);
      // assert
      expect(provider.tvSeriesDetailState, RequestState.Error);
      expect(provider.tvSeriesRecommendationsState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 4);
    });
  });
}