

import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_airing_today_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_on_the_air_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/provider/tv_series_list_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_list_notifier_test.mocks.dart';

@GenerateMocks([GetAirTodayTVSeries, GetTopRatedTVSeries, GetPopularTVSeries, GetOnTheAirTVSeries])

void main() {
  late TVSeriesListNotifier provider;
  late MockGetAirTodayTVSeries mockGetAirTodayTVSeries;
  late MockGetOnTheAirTVSeries mockGetOnTheAirTVSeries;
  late MockGetPopularTVSeries mockGetPopularTVSeries;
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetAirTodayTVSeries = MockGetAirTodayTVSeries();
    mockGetOnTheAirTVSeries = MockGetOnTheAirTVSeries();
    mockGetPopularTVSeries = MockGetPopularTVSeries();
    mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
    provider = TVSeriesListNotifier(
      getAirTodayTVSeries: mockGetAirTodayTVSeries,
      getOnTheAirTVSeries: mockGetOnTheAirTVSeries,
      getPopularTVSeries: mockGetPopularTVSeries,
      getTopRatedTVSeries: mockGetTopRatedTVSeries,
    )..addListener(() {
      listenerCallCount += 1;
    });
  });

  final tTVSeriesList = <TVSeries>[testTVSeries];

  group('air today tvseries', () {
    test('initialState should be empty', () {
      expect(provider.airingTodayTVSeriesState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetAirTodayTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      await provider.fetchAirTodayTVSeries();
      // assert
      verify(mockGetAirTodayTVSeries.execute());
    });

    test('should change state to Loading when usecase is caleld', () {
      // arrange
      when(mockGetAirTodayTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      provider.fetchAirTodayTVSeries();
      // assert
      expect(provider.airingTodayTVSeriesState, equals(RequestState.Loading));
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetAirTodayTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      await provider.fetchAirTodayTVSeries();
      // assert
      expect(provider.airingTodayTVSeriesState, equals(RequestState.Loaded));
      expect(provider.airingTodayTVSeries, equals(tTVSeriesList));
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetAirTodayTVSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchAirTodayTVSeries();
      // assert
      expect(provider.airingTodayTVSeriesState, equals(RequestState.Error));
      expect(provider.message, equals('Server Failure'));
      expect(listenerCallCount, 2);
    });
  });

  group('on the air tvseries', () {

    test('initialState should be Empty', () {
      expect(provider.onTheAirTVSeriesState, equals(RequestState.Empty));
    });

    test('should change state to loading when usecase is called', () {
      // arrange
      when(mockGetOnTheAirTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      provider.fetchOnTheAirTVSeries();
      // assert
      expect(provider.onTheAirTVSeriesState, equals(RequestState.Loading));
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetOnTheAirTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      await provider.fetchOnTheAirTVSeries();
      // assert
      expect(provider.onTheAirTVSeriesState, equals(RequestState.Loaded));
      expect(provider.onTheAirTVSeries, equals(tTVSeriesList));
      expect(listenerCallCount, 2);
     });

     test('should return error when data is unsuccessful', () async {
        // arrange
        when(mockGetOnTheAirTVSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        // act
        await provider.fetchOnTheAirTVSeries();
        // assert
        expect(provider.onTheAirTVSeriesState, equals(RequestState.Error));
        expect(provider.message, equals('Server Failure'));
        expect(listenerCallCount, 2);
     });
  });

  group('top rated tvseries', () {
    test('initialState should be empty', () {
      expect(provider.topRatedTVSeriesState, equals(RequestState.Empty));
    });

        test('should get data from the usecase', () async {
      // arrange
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      provider.fetchTopRatedTVSeries();
      // assert
      verify(mockGetTopRatedTVSeries.execute());
    });

    test('should change state to loading when usecase is called', () {
      // arrange
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      provider.fetchTopRatedTVSeries();
      // assert
      expect(provider.topRatedTVSeriesState, equals(RequestState.Loading));
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      await provider.fetchTopRatedTVSeries();
      // assert
      expect(provider.topRatedTVSeriesState, equals(RequestState.Loaded));
      expect(provider.topRatedTVSeries, equals(tTVSeriesList));
      expect(listenerCallCount, 2);
     });

     test('should return error when data is unsuccessful', () async {
        // arrange
        when(mockGetTopRatedTVSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        // act
        await provider.fetchTopRatedTVSeries();
        // assert
        expect(provider.topRatedTVSeriesState, equals(RequestState.Error));
        expect(provider.message, equals('Server Failure'));
        expect(listenerCallCount, 2);
     });
  });

  group('popular tvseries', () {
    test('initialState should be empty', () {
      expect(provider.topRatedTVSeriesState, equals(RequestState.Empty));
    });

        test('should get data from the usecase', () async {
      // arrange
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      provider.fetchPopularTVSeries();
      // assert
      verify(mockGetPopularTVSeries.execute());
    });

    test('should change state to loading when usecase is called', () {
      // arrange
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      provider.fetchPopularTVSeries();
      // assert
      expect(provider.popularTVSeriesState, equals(RequestState.Loading));
    });

    test('should change movies when data is gotten successfully', () async {
      // arrange
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      await provider.fetchPopularTVSeries();
      // assert
      expect(provider.popularTVSeriesState, equals(RequestState.Loaded));
      expect(provider.popularTVSeries, equals(tTVSeriesList));
      expect(listenerCallCount, 2);
     });

     test('should return error when data is unsuccessful', () async {
        // arrange
        when(mockGetPopularTVSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        // act
        await provider.fetchPopularTVSeries();
        // assert
        expect(provider.popularTVSeriesState, equals(RequestState.Error));
        expect(provider.message, equals('Server Failure'));
        expect(listenerCallCount, 2);
     });
  });
}