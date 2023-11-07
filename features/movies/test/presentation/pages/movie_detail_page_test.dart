import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movies/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../dummy_data/dummy_object.dart';

class MockMovieDetailBloc extends Mock implements MovieDetailBloc {}

class MockMovieDetailEvent extends Fake implements MovieDetailEvent {}

class MockMovieDetailState extends Fake implements MovieDetailState {}

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MovieDetailBloc mockBloc;
  // late HttpClient httpClient;

  setUp(() {
    mockBloc = MockMovieDetailBloc();
    // httpClient = MockHttpClient();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockBloc.stream)
        .thenAnswer((_) => Stream.value(MovieDetailState.initial()));
    when(() => mockBloc.state).thenReturn(MovieDetailState.initial().copyWith(
      movieDetailState: RequestState.Loaded,
      movie: testMovieDetail,
      movieRecommendationsState: RequestState.Loaded,
      movieRecommendations: <Movie>[],
      isAddedToWatchlist: false,
    ));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockBloc.stream)
        .thenAnswer((_) => Stream.value(MovieDetailState.initial()));
    when(() => mockBloc.state).thenReturn(MovieDetailState.initial().copyWith(
      movieDetailState: RequestState.Loaded,
      movie: testMovieDetail,
      movieRecommendationsState: RequestState.Loaded,
      movieRecommendations: <Movie>[],
      isAddedToWatchlist: true,
    ));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });
}