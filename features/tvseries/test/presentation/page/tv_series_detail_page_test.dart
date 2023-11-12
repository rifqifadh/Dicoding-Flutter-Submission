import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/tvseries.dart';
import 'package:nock/nock.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTVSeriesDetailBloc extends Mock implements TVSeriesDetailBloc {}

void main() {
  late TVSeriesDetailBloc bloc;

  setUpAll(nock.init);

  setUp(() {
    bloc = MockTVSeriesDetailBloc();
    nock.cleanAll();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TVSeriesDetailBloc>.value(
      value: bloc,
      child: MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(),
          child: body,
        ),
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester widgetTester) async {
    when(() => bloc.stream)
        .thenAnswer((_) => Stream.value(TVSeriesDetailState.initial()));
    when(() => bloc.state).thenReturn(TVSeriesDetailState.initial().copyWith(
      tvSeriesDetailState: RequestState.Loading,
    ));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await widgetTester.pumpWidget(makeTestableWidget(const TVSeriesDetailPage(
      id: 1,
    )));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display text error when error',
      (WidgetTester widgetTester) async {
    when(() => bloc.stream)
        .thenAnswer((_) => Stream.value(TVSeriesDetailState.initial()));
    when(() => bloc.state).thenReturn(TVSeriesDetailState.initial().copyWith(
      tvSeriesDetailState: RequestState.Error,
    ));

    final progressBarFinder = find.byType(Text);

    await widgetTester.pumpWidget(makeTestableWidget(const TVSeriesDetailPage(
      id: 1,
    )));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display TVSeriesDetail when success',
      (WidgetTester widgetTester) async {
    when(() => bloc.stream)
        .thenAnswer((_) => Stream.value(TVSeriesDetailState.initial()));
    when(() => bloc.state).thenReturn(TVSeriesDetailState.initial().copyWith(
      tvSeriesDetailState: RequestState.Loaded,
      tvSeries: testTVSeriesDetail,
      tvSeriesRecommendations: <TVSeries>[],
      tvSeriesRecommendationsState: RequestState.Loaded,
    ));

    final tvSeriesDetailFinder = find.byType(TVSeriesDetailPage);

    await widgetTester.pumpWidget(makeTestableWidget(const 
      TVSeriesDetailPage(id: 123)
    ));
    await widgetTester.pumpAndSettle();

    expect(tvSeriesDetailFinder, findsOneWidget);
  });

  testWidgets('Page should display TVSeriesDetail when success with empty response',
      (WidgetTester widgetTester) async {
    when(() => bloc.stream)
        .thenAnswer((_) => Stream.value(TVSeriesDetailState.initial()));
    when(() => bloc.state).thenReturn(TVSeriesDetailState.initial().copyWith(
      tvSeriesDetailState: RequestState.Loaded,
      tvSeries: testTVSeriesDetailFailure,
      tvSeriesRecommendations: <TVSeries>[],
      tvSeriesRecommendationsState: RequestState.Loaded,
    ));

    final tvSeriesDetailFinder = find.byType(TVSeriesDetailContent);

    await widgetTester.pumpWidget(makeTestableWidget(const 
      TVSeriesDetailPage(id: 123)
    ));

    expect(tvSeriesDetailFinder, findsOneWidget);
  });

  testWidgets('Should Add to Wishlist with successful result',
      (WidgetTester widgetTester) async {
    when(() => bloc.stream)
        .thenAnswer((_) => Stream.value(TVSeriesDetailState.initial()));
    when(() => bloc.state).thenReturn(TVSeriesDetailState.initial().copyWith(
      tvSeriesDetailState: RequestState.Loaded,
      tvSeries: testTVSeriesDetail,
      tvSeriesRecommendations: <TVSeries>[],
      tvSeriesRecommendationsState: RequestState.Loaded,
      isAddedToWatchlist: false,
      message: 'Added to Watchlist',
    ));


    final watchlistButtonIcon = find.byIcon(Icons.add);

    await widgetTester.pumpWidget(makeTestableWidget(const 
      TVSeriesDetailPage(id: 123)
    ));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}