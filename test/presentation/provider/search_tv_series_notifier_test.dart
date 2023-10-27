

import 'package:dartz/dartz.dart';
import 'package:core/core.dart';

import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/tv_series/search_tv_series.dart';
import 'package:ditonton/presentation/provider/search_tv_series_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_tv_series_notifier_test.mocks.dart';

@GenerateMocks([SearchTVSeries])
void main() {
  late SearchTVSeriesNotifier provider;
  late MockSearchTVSeries mockSearchTVSeries;
  late int listenerCallCount;

  setUp(() {
    mockSearchTVSeries = MockSearchTVSeries();
    listenerCallCount = 0;
    provider = SearchTVSeriesNotifier(searchTVSeries: mockSearchTVSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });
  
  final tTVSeries = TVSeries(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: [1, 2, 3],
    id: 1,
    name: 'Loki',
    originCountry: ['originCountry'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
  );

  final query = 'Loki';

  group('Search TV Series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockSearchTVSeries.execute(query))
          .thenAnswer((_) async => Right([tTVSeries]));
      // act
      provider.fetchSearchBy(query);
      // assert
      expect(provider.state, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change search resault data when data is fetched successfully', () async {
      // arrange
      when(mockSearchTVSeries.execute(query))
          .thenAnswer((_) async => Right([tTVSeries]));
      // act
      await provider.fetchSearchBy(query);
      // assert
      expect(provider.state, RequestState.Loaded);
      expect(provider.searchResult, [tTVSeries]);
      expect(listenerCallCount, 2);
    });

    test('shoudl return error when data is unsuccessful', () async {
      // arrange
      when(mockSearchTVSeries.execute(query))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchSearchBy(query);
      // assert
      expect(provider.state, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}