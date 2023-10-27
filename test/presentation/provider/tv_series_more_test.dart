import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import 'package:ditonton/domain/usecases/tv_series/get_airing_today_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/get_top_rated_tv_series.dart';
import 'package:ditonton/presentation/pages/tv_series_more_page.dart';
import 'package:ditonton/presentation/provider/tv_series_more_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_series_list_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTVSeries, GetAirTodayTVSeries, GetPopularTVSeries])
void main() {
  late TVSeriesMoreNotifier provider;
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;
  late MockGetAirTodayTVSeries mockGetAirTodayTVSeries;
  late MockGetPopularTVSeries mockGetPopularTVSeries;
  late int listenerCallCount;

  var type = TVSeriesMoreType.topRated;

  setUp(() {
    mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
    mockGetAirTodayTVSeries = MockGetAirTodayTVSeries();
    mockGetPopularTVSeries = MockGetPopularTVSeries();
    listenerCallCount = 0;
    provider = TVSeriesMoreNotifier(
      getTopRatedTVSeries: mockGetTopRatedTVSeries,
      getAirTodayTVSeries: mockGetAirTodayTVSeries,
      getPopularTVSeries: mockGetPopularTVSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('Get List TV Series base on type', () {
    test('initialState should be Empty ', () {
      expect(provider.state, equals(RequestState.Empty));
    });

    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => Right([]));
      // act
      provider.fetchTVSeries(type);
      // assert
      expect(provider.state, equals(RequestState.Loading));
      expect(listenerCallCount, 1);
    });

    test('should change tvseries data when data is fetch successfully with TVSeriesMoreType.topRated type ', () async {
      // arrange
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => Right(testTVSeriesList));
      // act
      await provider.fetchTVSeries(type);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.tvSeriesList, testTVSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should change tvseries data when failure with TVSeriesMoreType.topRated type ', () async {
      // arrange
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTVSeries(type);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });

    test('should change tvseries data when data is fetch successfully with TVSeriesMoreType.airingToday type ', () async {
      // arrange
      when(mockGetAirTodayTVSeries.execute())
          .thenAnswer((_) async => Right(testTVSeriesList));
      // act
      type = TVSeriesMoreType.airingToday;
      await provider.fetchTVSeries(type);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.tvSeriesList, testTVSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should change tvseries data when data is fetch successfully with TVSeriesMoreType.popular type ', () async {
      // arrange
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((_) async => Right(testTVSeriesList));
      // act
      type = TVSeriesMoreType.popular;
      await provider.fetchTVSeries(type);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.tvSeriesList, testTVSeriesList);
      expect(listenerCallCount, 2);
    });
  });
}
