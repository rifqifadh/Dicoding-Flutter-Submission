import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_object.dart';

class MockTopRatedMoviesBloc extends Mock implements TopRatedMoviesBloc {}

void main() {
  late TopRatedMoviesBloc mockBloc;

  setUp(() {
    mockBloc = MockTopRatedMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedMoviesBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.stream)
    .thenAnswer((_) => Stream.value(TopRatedMoviesEmpty()));

    when(() => mockBloc.state).thenReturn(
      TopRatedMoviesLoading()
    );

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('Page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.stream)
    .thenAnswer((_) => Stream.value(TopRatedMoviesEmpty()));

    when(() => mockBloc.state).thenReturn(
      TopRatedMoviesHasData(testMovieList)
    );

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.stream)
    .thenAnswer((_) => Stream.value(TopRatedMoviesEmpty()));

    when(() => mockBloc.state).thenReturn(
      const TopRatedMoviesError('Error Message')
    );


    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Empty',
      (WidgetTester tester) async {
    when(() => mockBloc.stream)
    .thenAnswer((_) => Stream.value(TopRatedMoviesEmpty()));
    when(() => mockBloc.state).thenReturn(
      TopRatedMoviesEmpty()
    );

    final textFinder = find.byType(Expanded);

    await tester.pumpWidget(_makeTestableWidget(const TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
