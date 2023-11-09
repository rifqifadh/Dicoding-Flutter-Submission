

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/tvseries.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTVSeriesMoreBloc extends Mock implements TVSeriesMoreBloc {}

void main() {
  late TVSeriesMoreBloc bloc;

  setUp(() {
    bloc = MockTVSeriesMoreBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TVSeriesMoreBloc>.value(
      value: bloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }


  testWidgets('Page should display center progress bar when loading with popular type',
   (WidgetTester widgetTester) async {
      when(() => bloc.stream)
      .thenAnswer((_) => Stream.value(TVSeriesMoreEmpty()));
      when(() => bloc.state).thenReturn(TVSeriesMoreLoading());
  
      final progressBarFinder = find.byType(CircularProgressIndicator);
  
      await widgetTester.pumpWidget(_makeTestableWidget(const TVSeriesMorePage(type: TVSeriesMoreType.popular,)));
  
      expect(progressBarFinder, findsOneWidget);
    });
  testWidgets('Page should display center progress bar when loading',
   (WidgetTester widgetTester) async {
      when(() => bloc.stream)
      .thenAnswer((_) => Stream.value(TVSeriesMoreEmpty()));
      when(() => bloc.state).thenReturn(TVSeriesMoreLoading());
  
      final progressBarFinder = find.byType(CircularProgressIndicator);
  
      await widgetTester.pumpWidget(_makeTestableWidget(const TVSeriesMorePage(type: TVSeriesMoreType.popular,)));
  
      expect(progressBarFinder, findsOneWidget);
    });

  testWidgets('Page should display center progress bar when loading with topRated type',
   (WidgetTester widgetTester) async {
      when(() => bloc.stream)
      .thenAnswer((_) => Stream.value(TVSeriesMoreEmpty()));
      when(() => bloc.state).thenReturn(TVSeriesMoreLoading());
  
      final progressBarFinder = find.byType(CircularProgressIndicator);
  
      await widgetTester.pumpWidget(_makeTestableWidget(const TVSeriesMorePage(type: TVSeriesMoreType.topRated,)));
  
      expect(progressBarFinder, findsOneWidget);
    });
  testWidgets('Page should display ListView when data is loaded with onTheAir type',
    (WidgetTester widgetTester) async {
        when(() => bloc.stream)
        .thenAnswer((_) => Stream.value(TVSeriesMoreEmpty()));
        when(() => bloc.state).thenReturn(TVSeriesMoreLoaded(testTVSeriesList));
    
        final listViewFinder = find.byType(ListView);
    
        await widgetTester.pumpWidget(_makeTestableWidget(const TVSeriesMorePage(type: TVSeriesMoreType.onTheAir,)));
    
        expect(listViewFinder, findsOneWidget);
      });

  testWidgets('Page should display error message when data is loaded',
    (WidgetTester widgetTester) async {
        when(() => bloc.stream)
        .thenAnswer((_) => Stream.value(TVSeriesMoreEmpty()));
        when(() => bloc.state).thenReturn(const TVSeriesMoreError('Error'));
    
        final textFinder = find.byKey(const Key('error_message'));
    
        await widgetTester.pumpWidget(_makeTestableWidget(const TVSeriesMorePage(type: TVSeriesMoreType.popular,)));
    
        expect(textFinder, findsOneWidget);
      });

  testWidgets('Page should display empty container when data is loaded',
    (WidgetTester widgetTester) async {
        when(() => bloc.stream)
        .thenAnswer((_) => Stream.value(TVSeriesMoreEmpty()));
        when(() => bloc.state).thenReturn(TVSeriesMoreEmpty());
    
        final containerFinder = find.byType(Container);
    
        await widgetTester.pumpWidget(_makeTestableWidget(const TVSeriesMorePage(type: TVSeriesMoreType.popular,)));
    
        expect(containerFinder, findsOneWidget);
      });
}