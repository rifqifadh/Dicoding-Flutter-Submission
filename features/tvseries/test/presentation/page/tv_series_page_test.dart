
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nock/nock.dart';
import 'package:tvseries/tvseries.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

class MockTVSeriesListBloc extends Mock implements TVSeriesListBloc {
  @override
  GetAirTodayTVSeries get getAirTodayTVSeries => GetAirTodayTVSeries(MockTVSeriesRepository());
}

void main() {
  late TVSeriesListBloc bloc;

  setUpAll(nock.init);

  setUp(() {
    bloc = MockTVSeriesListBloc();
    GoogleFonts.config.allowRuntimeFetching = false;
    nock.cleanAll();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TVSeriesListBloc>.value(
      value: bloc,
      child: MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(),
          child: body,
        ),
      ),
    );
  }

  testWidgets('Page should display center progress bar when get airingToday',
      (WidgetTester widgetTester) async {
    when(() => bloc.stream)
        .thenAnswer((_) => Stream.value(TVSeriesListState.initial()));
    when(() => bloc.state).thenReturn(TVSeriesListState.initial().copyWith(
      airingTodayTVSeriesState: RequestState.Loading,
    ));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await widgetTester.pumpWidget(makeTestableWidget(const TVSeriesPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display list of airingToday',
   (WidgetTester widgetTester) async {
    when(() => bloc.stream).thenAnswer(
      (_) => Stream.value(TVSeriesListState.initial().copyWith(
        airingTodayTVSeriesState: RequestState.Loaded,
        airingTodayTVSeries: testTVSeriesList,
      )),
    );
    when(() => bloc.state).thenReturn(TVSeriesListState.initial().copyWith(
      airingTodayTVSeriesState: RequestState.Loaded,
      airingTodayTVSeries: testTVSeriesList,
    ));

    final listViewFinder = find.byType(ListView);

    await widgetTester.pumpWidget(makeTestableWidget(const TVSeriesPage()));

    expect(listViewFinder, findsOneWidget);
   });

  testWidgets('Page should display center progress bar when get onTheAir',
      (WidgetTester widgetTester) async {
    when(() => bloc.stream)
        .thenAnswer((_) => Stream.value(TVSeriesListState.initial()));
    when(() => bloc.state).thenReturn(TVSeriesListState.initial().copyWith(
      onTheAirTVSeriesState: RequestState.Loading,
    ));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await widgetTester.pumpWidget(makeTestableWidget(const TVSeriesPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display list of onTheAir',
   (WidgetTester widgetTester) async {
    when(() => bloc.stream).thenAnswer(
      (_) => Stream.value(TVSeriesListState.initial().copyWith(
        onTheAirTVSeriesState: RequestState.Loaded,
        onTheAirTVSeries: testTVSeriesList,
      )),
    );
    when(() => bloc.state).thenReturn(TVSeriesListState.initial().copyWith(
      onTheAirTVSeriesState: RequestState.Loaded,
      onTheAirTVSeries: testTVSeriesList,
    ));

    final listViewFinder = find.byType(ListView);

    await widgetTester.pumpWidget(makeTestableWidget(const TVSeriesPage()));

    expect(listViewFinder, findsOneWidget);
   });

  testWidgets('Page should display center progress bar when get popular',
      (WidgetTester widgetTester) async {
    when(() => bloc.stream)
        .thenAnswer((_) => Stream.value(TVSeriesListState.initial()));
    when(() => bloc.state).thenReturn(TVSeriesListState.initial().copyWith(
      popularTVSeriesState: RequestState.Loading,
    ));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await widgetTester.pumpWidget(makeTestableWidget(const TVSeriesPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display list of popular',
   (WidgetTester widgetTester) async {
    when(() => bloc.stream).thenAnswer(
      (_) => Stream.value(TVSeriesListState.initial().copyWith(
        popularTVSeriesState: RequestState.Loaded,
        popularTVSeries: testTVSeriesList,
      )),
    );
    when(() => bloc.state).thenReturn(TVSeriesListState.initial().copyWith(
      popularTVSeriesState: RequestState.Loaded,
      popularTVSeries: testTVSeriesList,
    ));

    final listViewFinder = find.byType(ListView);

    await widgetTester.pumpWidget(makeTestableWidget(const TVSeriesPage()));

    expect(listViewFinder, findsOneWidget);
   });

  testWidgets('Page should display center progress bar when get topRated',
      (WidgetTester widgetTester) async {
    when(() => bloc.stream)
        .thenAnswer((_) => Stream.value(TVSeriesListState.initial()));
    when(() => bloc.state).thenReturn(TVSeriesListState.initial().copyWith(
      topRatedTVSeriesState: RequestState.Loading,
    ));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await widgetTester.pumpWidget(makeTestableWidget(const TVSeriesPage()));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display list of topRated',
   (WidgetTester widgetTester) async {
    when(() => bloc.stream).thenAnswer(
      (_) => Stream.value(TVSeriesListState.initial().copyWith(
        topRatedTVSeriesState: RequestState.Loaded,
        topRatedTVSeries: testTVSeriesList,
      )),
    );
    when(() => bloc.state).thenReturn(TVSeriesListState.initial().copyWith(
      topRatedTVSeriesState: RequestState.Loaded,
      topRatedTVSeries: testTVSeriesList,
    ));

    final listViewFinder = find.byType(ListView);

    await widgetTester.pumpWidget(makeTestableWidget(const TVSeriesPage()));

    expect(listViewFinder, findsOneWidget);
   });
}