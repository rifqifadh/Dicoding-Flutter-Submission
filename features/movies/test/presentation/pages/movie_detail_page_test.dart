
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movies/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nock/nock.dart';
import '../../dummy_data/dummy_object.dart';

class MockMovieDetailBloc extends Mock implements MovieDetailBloc {}

void main() {
  late MovieDetailBloc mockBloc;

  setUpAll(nock.init);

  setUp(() {
    mockBloc = MockMovieDetailBloc();
    nock.cleanAll();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<MovieDetailBloc>.value(
      value: mockBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester widgetTester) async {
    when(() => mockBloc.stream)
        .thenAnswer((_) => Stream.value(MovieDetailState.initial()));
    when(() => mockBloc.state).thenReturn(MovieDetailState.initial().copyWith(
      movieDetailState: RequestState.Loading,
    ));

    final progressBarFinder = find.byType(CircularProgressIndicator);

    await widgetTester.pumpWidget(_makeTestableWidget(const MovieDetailPage(
      id: 1,
    )));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display text error when error',
      (WidgetTester widgetTester) async {
    when(() => mockBloc.stream)
        .thenAnswer((_) => Stream.value(MovieDetailState.initial()));
    when(() => mockBloc.state).thenReturn(MovieDetailState.initial().copyWith(
      movieDetailState: RequestState.Error,
    ));

    final progressBarFinder = find.byType(Text);

    await widgetTester.pumpWidget(_makeTestableWidget(const MovieDetailPage(
      id: 1,
    )));

    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display movie detail when data is loaded',
      (WidgetTester widgetTester) async {
    when(() => mockBloc.stream)
        .thenAnswer((_) => Stream.value(MovieDetailState.initial()));
    when(() => mockBloc.state).thenReturn(MovieDetailState.initial().copyWith(
      movieDetailState: RequestState.Loaded,
      movie: testMovieDetail,
    ));

    final movieDetailFinder = find.byType(DetailContent);

    await widgetTester.pumpWidget(_makeTestableWidget(const MovieDetailPage(
      id: 1,
    )));

    expect(movieDetailFinder, findsOneWidget);
  });

  testWidgets('Page should display movie detail when data is loaded with recommendations data success',
      (WidgetTester widgetTester) async {
    when(() => mockBloc.stream)
        .thenAnswer((_) => Stream.value(MovieDetailState.initial()));
    when(() => mockBloc.state).thenReturn(MovieDetailState.initial().copyWith(
      movieDetailState: RequestState.Loaded,
      movie: testMovieDetail,
      movieRecommendations: testMovieList,
      movieRecommendationsState: RequestState.Loaded,
    ));

    final movieDetailFinder = find.byKey(const Key('recommendation_list'));

    await widgetTester.pumpWidget(_makeTestableWidget(const MovieDetailPage(
      id: 1,
    )));

    expect(movieDetailFinder, findsOneWidget);
  });

  testWidgets('Page should display movie detail when data is loaded with recommendations data failure',
      (WidgetTester widgetTester) async {
    when(() => mockBloc.stream)
        .thenAnswer((_) => Stream.value(MovieDetailState.initial()));
    when(() => mockBloc.state).thenReturn(MovieDetailState.initial().copyWith(
      movieDetailState: RequestState.Loaded,
      movie: testMovieDetail,
      movieRecommendationsState: RequestState.Error,
      message: 'Server Error',
    ));

    final movieDetailFinder = find.byWidgetPredicate(
  (Widget widget) => widget is Text && widget.data == 'Server Error',
);

    await widgetTester.pumpWidget(_makeTestableWidget(const MovieDetailPage(
      id: 1,
    )));

    expect(movieDetailFinder, findsOneWidget);
  });

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