
import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late TVSeriesListBloc tvSeriesListBloc;
  late MockGetAirTodayTVSeries mockGetAirTodayTVSeries;
  late MockGetOnTheAirTVSeries mockGetOnTheAirTVSeries;
  late MockGetPopularTVSeries mockGetPopularTVSeries;
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;

  setUp(() {
    mockGetAirTodayTVSeries = MockGetAirTodayTVSeries();
    mockGetOnTheAirTVSeries = MockGetOnTheAirTVSeries();
    mockGetPopularTVSeries = MockGetPopularTVSeries();
    mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
    tvSeriesListBloc = TVSeriesListBloc(
      getAirTodayTVSeries: mockGetAirTodayTVSeries,
      getOnTheAirTVSeries: mockGetOnTheAirTVSeries,
      getPopularTVSeries: mockGetPopularTVSeries,
      getTopRatedTVSeries: mockGetTopRatedTVSeries,
    );
  });

  blocTest(
    'Should emit [Loading, Data] when fetch AiringToday success',
    build: () {
      when(mockGetAirTodayTVSeries.execute())
          .thenAnswer((_) async => Right(testTVSeriesList));
      return tvSeriesListBloc;
    },
    act: (bloc) => bloc.add(FetchAiringTodayTVSeries()),
    expect: () => [
        TVSeriesListState.initial().copyWith(
          airingTodayTVSeriesState: RequestState.Loading,
        ),
        TVSeriesListState.initial().copyWith(
          airingTodayTVSeriesState: RequestState.Loaded,
          airingTodayTVSeries: testTVSeriesList,
        ),
      ],
    verify: (bloc) => verify(mockGetAirTodayTVSeries.execute()),
    );

  blocTest(
    'Should emit [Loading and Error] when fetch AiringToday Error',
    build: () {
      when(mockGetAirTodayTVSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeriesListBloc;
    },
    act: (bloc) => bloc.add(FetchAiringTodayTVSeries()),
    expect: () => [
        TVSeriesListState.initial().copyWith(
          airingTodayTVSeriesState: RequestState.Loading,
        ),
        TVSeriesListState.initial().copyWith(
          airingTodayTVSeriesState: RequestState.Error,
          errorMessage: 'Server Failure',
        ),
      ],
    verify: (bloc) => verify(mockGetAirTodayTVSeries.execute()),
    );

  blocTest(
    'Should emit [Loading, Data] when fetch OnTheAir success',
    build: () {
      when(mockGetOnTheAirTVSeries.execute())
          .thenAnswer((_) async => Right(testTVSeriesList));
      return tvSeriesListBloc;
    },
    act: (bloc) => bloc.add(FetchOnTheAirTVSeries()),
    expect: () => [
        TVSeriesListState.initial().copyWith(
          onTheAirTVSeriesState: RequestState.Loading,
        ),
        TVSeriesListState.initial().copyWith(
          onTheAirTVSeriesState: RequestState.Loaded,
          onTheAirTVSeries: testTVSeriesList,
        ),
      ],
    verify: (bloc) => verify(mockGetOnTheAirTVSeries.execute()),
    );

  blocTest(
    'Should emit [Loading and Error] when fetch OnTheAir Error',
    build: () {
      when(mockGetOnTheAirTVSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeriesListBloc;
    },
    act: (bloc) => bloc.add(FetchOnTheAirTVSeries()),
    expect: () => [
        TVSeriesListState.initial().copyWith(
          onTheAirTVSeriesState: RequestState.Loading,
        ),
        TVSeriesListState.initial().copyWith(
          onTheAirTVSeriesState: RequestState.Error,
          errorMessage: 'Server Failure',
        ),
      ],
    verify: (bloc) => verify(mockGetOnTheAirTVSeries.execute()),
    );

  blocTest(
    'Should emit [Loading, Data] when fetch Popular success',
    build: () {
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((_) async => Right(testTVSeriesList));
      return tvSeriesListBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTVSeries()),
    expect: () => [
        TVSeriesListState.initial().copyWith(
          popularTVSeriesState: RequestState.Loading,
        ),
        TVSeriesListState.initial().copyWith(
          popularTVSeriesState: RequestState.Loaded,
          popularTVSeries: testTVSeriesList,
        ),
      ],
    verify: (bloc) => verify(mockGetPopularTVSeries.execute()),
    );

  blocTest(
    'Should emit [Loading and Error] when fetch Popular Error',
    build: () {
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeriesListBloc;
    },
    act: (bloc) => bloc.add(FetchPopularTVSeries()),
    expect: () => [
        TVSeriesListState.initial().copyWith(
          popularTVSeriesState: RequestState.Loading,
        ),
        TVSeriesListState.initial().copyWith(
          popularTVSeriesState: RequestState.Error,
          errorMessage: 'Server Failure',
        ),
      ],
    verify: (bloc) => verify(mockGetPopularTVSeries.execute()),
    );

  blocTest(
    'Should emit [Loading, Data] when fetch TopRated success',
    build: () {
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => Right(testTVSeriesList));
      return tvSeriesListBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTVSeries()),
    expect: () => [
        TVSeriesListState.initial().copyWith(
          topRatedTVSeriesState: RequestState.Loading,
        ),
        TVSeriesListState.initial().copyWith(
          topRatedTVSeriesState: RequestState.Loaded,
          topRatedTVSeries: testTVSeriesList,
        ),
      ],
    verify: (bloc) => verify(mockGetTopRatedTVSeries.execute()),
    );

  blocTest(
    'Should emit [Loading and Error] when fetch TopRated Error',
    build: () {
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return tvSeriesListBloc;
    },
    act: (bloc) => bloc.add(FetchTopRatedTVSeries()),
    expect: () => [
        TVSeriesListState.initial().copyWith(
          topRatedTVSeriesState: RequestState.Loading,
        ),
        TVSeriesListState.initial().copyWith(
          topRatedTVSeriesState: RequestState.Error,
          errorMessage: 'Server Failure',
        ),
      ],
    verify: (bloc) => verify(mockGetTopRatedTVSeries.execute()),
    );
}