

import 'package:core/core.dart';
import 'package:ditonton/presentation/bloc/watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../dummy_data/dummy_objects.dart';

class MockWatchlistPageBloc extends Mock implements WatchlistBloc {}

void main() {
  late WatchlistBloc bloc;

  setUp(() {
    bloc = MockWatchlistPageBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<WatchlistBloc>.value(
      value: bloc,
      child: MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(),
          child: body,
        ),
      ),
    );
  }

  testWidgets('renders WatchlistPage with Loading', (WidgetTester tester) async {
    when(() => bloc.stream).thenAnswer((_) => Stream.value(WatchlistState.initial().copyWith(
      state: RequestState.Loading,
      watchlist: [],
    )));
    when(() => bloc.state).thenReturn(WatchlistState.initial().copyWith(
      state: RequestState.Loading,
      watchlist: [],
    ));

    await tester.pumpWidget(makeTestableWidget(WatchlistPage()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('renders WatchlistPage with Error', (WidgetTester tester) async {
    when(() => bloc.stream).thenAnswer((_) => Stream.value(WatchlistState.initial().copyWith(
      state: RequestState.Error,
      message: 'Server Error',
      watchlist: [],
    )));
    when(() => bloc.state).thenReturn(WatchlistState.initial().copyWith(
      state: RequestState.Error,
      message: 'Server Error',
      watchlist: [],
    ));

    await tester.pumpWidget(makeTestableWidget(WatchlistPage()));

    expect(find.text('Server Error'), findsOneWidget);
  });

  testWidgets('renders WatchlistPage with wishlist from Movie', (WidgetTester tester) async {
    when(() => bloc.stream).thenAnswer((_) => Stream.value(WatchlistState.initial().copyWith(
      state: RequestState.Loaded,
      watchlist: [testWatchlistMovie],
    )));
    when(() => bloc.state).thenReturn(WatchlistState.initial().copyWith(
      state: RequestState.Loaded,
      watchlist: [testWatchlistMovie],
    ));

    await tester.pumpWidget(makeTestableWidget(WatchlistPage()));

    expect(find.byKey(Key('watchlist_list')), findsOneWidget);
  });

  testWidgets('renders WatchlistPage with wishlist from Movie', (WidgetTester tester) async {
    when(() => bloc.stream).thenAnswer((_) => Stream.value(WatchlistState.initial().copyWith(
      state: RequestState.Loaded,
      watchlist: [testWatchlist],
    )));
    when(() => bloc.state).thenReturn(WatchlistState.initial().copyWith(
      state: RequestState.Loaded,
      watchlist: [testWatchlist],
    ));

    await tester.pumpWidget(makeTestableWidget(WatchlistPage()));

    expect(find.byKey(Key('watchlist_list')), findsOneWidget);
  });
}