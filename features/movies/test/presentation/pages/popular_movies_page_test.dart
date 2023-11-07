import 'dart:io';

import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_object.dart';

class MockPopularMoviesBloc extends Mock implements PopularMoviesBloc {}
class MockPopularMoviesEvent extends Mock implements PopularMoviesEvent {}
class MockPopularMoviesState extends Mock implements PopularMoviesState {}


void main() {
  late PopularMoviesBloc mockBloc;

  setUp(() {
    mockBloc = MockPopularMoviesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMoviesBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockBloc.stream)
    .thenAnswer((_) => Stream.value(PopularMoviesEmpty()));

    when(() => mockBloc.state).thenReturn(
      PopularMoviesLoading()
    );

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockBloc.stream)
    .thenAnswer((_) => Stream.value(PopularMoviesEmpty()));

    when(() => mockBloc.state).thenReturn(
      PopularMoviesHasData(testMovieList)
    );

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockBloc.stream)
    .thenAnswer((_) => Stream.value(PopularMoviesEmpty()));

    when(() => mockBloc.state).thenReturn(
      const PopularMoviesError('Error Message')
    );

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Empty',
      (WidgetTester tester) async {
    when(() => mockBloc.stream)
    .thenAnswer((_) => Stream.value(PopularMoviesEmpty()));
    when(() => mockBloc.state).thenReturn(
      PopularMoviesEmpty()
    );

    final textFinder = find.byType(Expanded);

    await tester.pumpWidget(_makeTestableWidget(const PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
