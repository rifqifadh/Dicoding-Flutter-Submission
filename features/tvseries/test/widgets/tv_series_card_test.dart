
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/presentation/widgets/tv_series_card.dart';

import '../dummy_data/dummy_objects.dart';

void main() {

  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: Scaffold(
        body: Material(
          child: body,
        ),
      )
    );
  }

  testWidgets('renders TVSeriesCard', (tester) async {
    await tester.pumpWidget(_makeTestableWidget(TVSeriesCard(
      testTVSeries
    )));

    expect(find.byType(TVSeriesCard), findsOneWidget);
  });

  testWidgets('displays TV series title', (tester) async {
    await tester.pumpWidget(_makeTestableWidget(TVSeriesCard(
      testTVSeries
    )));

    expect(find.text(testTVSeries.name!), findsOneWidget);
  });

  testWidgets('displays TV series overview', (tester) async {
    await tester.pumpWidget(_makeTestableWidget(TVSeriesCard(
      testTVSeries
    )));

    expect(find.text(testTVSeries.overview), findsOneWidget);
  });

  testWidgets('display nextEpisodeToAir with nextEpisodeToAir', (widgetTester) async {
    await widgetTester.pumpWidget(_makeTestableWidget(TVSeriesCard(
      testTVSeriesWithSeason
    )));

    expect(find.text(' | ${testTVSeriesWithSeason.nextEpisodeToAir!.airDateFormatted()}'), findsOneWidget);
  });

  testWidgets('display nextEpisodeToAir with nextEpisodeToAir.name > 24', (widgetTester) async {
    testTVSeriesWithSeason.nextEpisodeToAir!.name = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.';
    await widgetTester.pumpWidget(_makeTestableWidget(TVSeriesCard(
      testTVSeriesWithSeason
    )));

    expect(find.text(' | ${testTVSeriesWithSeason.nextEpisodeToAir!.airDateFormatted()}'), findsOneWidget);
  });
}