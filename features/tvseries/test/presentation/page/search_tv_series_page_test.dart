import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/tvseries.dart';

import '../../dummy_data/dummy_objects.dart';

class MockSearchTVSeriesBloc extends Mock implements SearchTVSeriesBloc {}

void main() {
  late SearchTVSeriesBloc bloc;

  setUp(() {
    bloc = MockSearchTVSeriesBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<SearchTVSeriesBloc>.value(
      value: bloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('renders SearchTVSeriesPage with Loaded data and typing Loki in textfield', (tester) async {
    when(() => bloc.stream).thenAnswer(
        (_) => Stream.value(SearchTVSeriesLoaded(testTVSeriesList)));
    when(() => bloc.state).thenReturn(SearchTVSeriesLoaded(testTVSeriesList));

    await tester.pumpWidget(_makeTestableWidget(const SearchTVSeriesPage()));
    await tester.enterText(find.byKey(const Key('search_text_field')), 'Loki');

    expect(find.byKey(const Key('search_text_field')), findsOneWidget);
  });

  testWidgets('renders SearchTVSeriesPage with Loaded data', (tester) async {
    when(() => bloc.stream)
        .thenAnswer((_) => Stream.value(SearchTVSeriesEmpty()));
    when(() => bloc.state).thenReturn(const SearchTVSeriesError('Server Error'));

    await tester.pumpWidget(_makeTestableWidget(const SearchTVSeriesPage()));

    expect(find.byType(Expanded), findsOneWidget);
  });

}
