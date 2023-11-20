import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late TVSeriesMoreBloc bloc;
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;
  late MockGetAirTodayTVSeries mockGetAirTodayTVSeries;
  late MockGetPopularTVSeries mockGetPopularTVSeries;
  late MockGetOnTheAirTVSeries mockGeOnTheAirTVSeries;

  setUp(() {
    mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
    mockGetAirTodayTVSeries = MockGetAirTodayTVSeries();
    mockGetPopularTVSeries = MockGetPopularTVSeries();
    mockGeOnTheAirTVSeries = MockGetOnTheAirTVSeries();
    bloc = TVSeriesMoreBloc(
      getTopRatedTVSeries: mockGetTopRatedTVSeries,
      getAirTodayTVSeries: mockGetAirTodayTVSeries,
      getPopularTVSeries: mockGetPopularTVSeries,
      getOnTheAirTVSeries: mockGeOnTheAirTVSeries,
    );
  });

  blocTest<TVSeriesMoreBloc, TVSeriesMoreState>(
      'Should emit [Loading, Data] with type of popular with successfully result',
      build: () {
        when(mockGetPopularTVSeries.execute())
            .thenAnswer((_) async => Right(testTVSeriesList));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const OnInitialFetchTVSeriesMore(TVSeriesMoreType.popular)),
      expect: () => [
            TVSeriesMoreLoading(),
            TVSeriesMoreLoaded(testTVSeriesList),
          ],
      verify: (bloc) {
        verify(mockGetPopularTVSeries.execute());
      });
  blocTest<TVSeriesMoreBloc, TVSeriesMoreState>(
      'Should emit [Loading, Data] with type of topRated with successfully result',
      build: () {
        when(mockGetTopRatedTVSeries.execute())
            .thenAnswer((_) async => Right(testTVSeriesList));
        return bloc;
      },
      act: (bloc) =>
          bloc.add(const OnInitialFetchTVSeriesMore(TVSeriesMoreType.topRated)),
      expect: () => [
            TVSeriesMoreLoading(),
            TVSeriesMoreLoaded(testTVSeriesList),
          ],
      verify: (bloc) {
        verify(mockGetTopRatedTVSeries.execute());
      });

  blocTest<TVSeriesMoreBloc, TVSeriesMoreState>(
    'Should emit [Loading, Data] with type of onTheAir with successfully result',
    build: () {
      when(mockGeOnTheAirTVSeries.execute())
          .thenAnswer((_) async => Right(testTVSeriesList));
      return bloc;
    },
    act: (bloc) =>
        bloc.add(const OnInitialFetchTVSeriesMore(TVSeriesMoreType.onTheAir)),
    expect: () => [
      TVSeriesMoreLoading(),
      TVSeriesMoreLoaded(testTVSeriesList),
    ],
    verify: (bloc) {
      verify(mockGeOnTheAirTVSeries.execute());
    },
  );

  blocTest<TVSeriesMoreBloc, TVSeriesMoreState>(
    'Should emit [Loading, Error] when get popular is unsuccessful',
    build: () {
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) =>
        bloc.add(const OnInitialFetchTVSeriesMore(TVSeriesMoreType.popular)),
    expect: () =>
        [TVSeriesMoreLoading(), const TVSeriesMoreError('Server Failure')],
    verify: (bloc) {
      verify(mockGetPopularTVSeries.execute());
    },
  );

  blocTest<TVSeriesMoreBloc, TVSeriesMoreState>(
      'Should emit [Loading, Data] with type of airingToday with successfully result',
      build: () {
        when(mockGetAirTodayTVSeries.execute())
            .thenAnswer((_) async => Right(testTVSeriesList));
        return bloc;
      },
      act: (bloc) => bloc
          .add(const OnInitialFetchTVSeriesMore(TVSeriesMoreType.airingToday)),
      expect: () => [
            TVSeriesMoreLoading(),
            TVSeriesMoreLoaded(testTVSeriesList),
          ],
      verify: (bloc) {
        verify(mockGetAirTodayTVSeries.execute());
      });

  blocTest<TVSeriesMoreBloc, TVSeriesMoreState>(
      'Should emit [Loading, Error] when get airingToday is unsuccessful',
      build: () {
        when(mockGetAirTodayTVSeries.execute()).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return bloc;
      },
      act: (bloc) => bloc
          .add(const OnInitialFetchTVSeriesMore(TVSeriesMoreType.airingToday)),
      expect: () =>
          [TVSeriesMoreLoading(), const TVSeriesMoreError('Server Failure')],
      verify: (bloc) {
        verify(mockGetAirTodayTVSeries.execute());
      });
}
