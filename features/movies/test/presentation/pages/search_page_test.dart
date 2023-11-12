

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';

import '../../dummy_data/dummy_object.dart';

class MockSearchBloc extends Mock implements SearchBloc {}

void main() {
  late SearchBloc bloc;

  setUp(() {
    bloc = MockSearchBloc();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<SearchBloc>.value(
      value: bloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }


  testWidgets('renders SearchPage with Loaded data and typing Spiderman in textfield', (tester) async {
    when(() => bloc.stream).thenAnswer((_) => Stream.value(SearchHasData(testMovieList)));
    when(() => bloc.state).thenReturn(SearchHasData(testMovieList));

    await tester.pumpWidget(makeTestableWidget(const SearchPage()));
    await tester.enterText(find.byKey(const Key('search_text_field')), 'Spiderman');

    expect(find.byKey(const Key('search_text_field')), findsOneWidget);
  });
  
  testWidgets('renders SearchPage with Error result', (tester) async {
    when(() => bloc.stream).thenAnswer((_) => Stream.value(SearchEmpty()));
    when(() => bloc.state).thenReturn(const SearchError('Server Error'));

    await tester.pumpWidget(makeTestableWidget(const SearchPage()));

    expect(find.byType(Expanded), findsOneWidget);
  });
}