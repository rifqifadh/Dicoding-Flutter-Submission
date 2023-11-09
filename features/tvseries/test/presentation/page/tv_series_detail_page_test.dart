import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/tvseries.dart';
import 'package:nock/nock.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

class MockTVSeriesDetailBloc extends Mock implements TVSeriesDetailBloc {
  @override
  Stream<TVSeriesDetailState> mapEventToState(
      TVSeriesDetailEvent event) async* {
    yield TVSeriesDetailState.initial().copyWith(
      tvSeriesDetailState: RequestState.Loading,
    );
    yield TVSeriesDetailState.initial().copyWith(
      tvSeriesDetailState: RequestState.Loaded,
      tvSeries: testTVSeriesDetail,
      tvSeriesRecommendations: <TVSeries>[],
      tvSeriesRecommendationsState: RequestState.Loaded,
    );
  }
}

void main() {
  late TVSeriesDetailBloc bloc;
  final mockHttpClient = MockHttpClient();

  setUpAll(nock.init);

  setUp(() {
    bloc = MockTVSeriesDetailBloc();
    nock.cleanAll();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TVSeriesDetailBloc>.value(
      value: bloc,
      child: MaterialApp(
        home: body,
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

    await widgetTester.pumpWidget(_makeTestableWidget(const TVSeriesDetailPage(
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

    await widgetTester.pumpWidget(_makeTestableWidget(const TVSeriesDetailPage(
      id: 1,
    )));

    expect(progressBarFinder, findsOneWidget);
  });
}
