
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/data/datasources/watchlist_local_data_source.dart';
import 'package:ditonton/data/models/watchlist_table.dart';
import 'package:ditonton/data/repositories/watchlist_repository_impl.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:ditonton/domain/repositories/watchlist_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

@GenerateMocks([WatchlistRepositoryImpl, WatchlistLocalDataSource])
void main() {
    late WatchlistRepository repository;
    late WatchlistLocalDataSource localDataSource;
  
  setUp(() {
    localDataSource = MockWatchlistLocalDataSource();
    repository = WatchlistRepositoryImpl(localDataSource: localDataSource);
  });

  final testWatchlistTable = WatchlistTable(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
    nextEpisode: 2,
    nextEpisodeName: 'nextEpisodeName',
    seasonNumber: 1,
    nextEpisodeToAir: '2020-01-01',
    type: WatchlistType.tvSeries,
  );

  final testWatchlist = Watchlist(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
    nextEpisode: 2,
    nextEpisodeName: 'nextEpisodeName',
    seasonNumber: 1,
    nextEpisodeToAir: '2020-01-01',
    type: WatchlistType.tvSeries,
  );

  group('get watchlist', () {
    test('should return list of watchlist from local storage', () async {
      // arrange
      when(localDataSource.getWatchlist()).thenAnswer((_) async => [testWatchlistTable]);
      // act
      final result = await repository.getWatchlist();
      // assert
      final resultExpected = result.getOrElse(() => [testWatchlist]);
      expect(resultExpected, [testWatchlist]);
    });

    test('should return empty list if local storage is empty', () async {
      // arrange
      when(localDataSource.getWatchlist()).thenAnswer((_) async => []);
      // act
      final result = await repository.getWatchlist();
      // assert
      final resultExpected = result.getOrElse(() => [testWatchlist]);
      expect(resultExpected, []);
    });

    test('should return Failure when call to local storage is unsuccessful', () async {
      // arrange
      when(localDataSource.getWatchlist()).thenThrow(DatabaseException('Error'));
      // act
      final result = await repository.getWatchlist();
      // assert
      expect(result, equals(Left<DatabaseFailure, List<Watchlist>>(DatabaseFailure('Failed to get watchlist'))));
    });
  });
}