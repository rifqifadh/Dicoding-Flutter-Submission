import 'package:ditonton/data/datasources/watchlist_local_data_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late WatchlistLocalDataSourceImpl dataSource;
  late MockDatabaseHelper mockDatabaseHelper;

  setUp(() {
    mockDatabaseHelper = MockDatabaseHelper();
    dataSource = WatchlistLocalDataSourceImpl(databaseHelper: mockDatabaseHelper);
  });

  group('get Watchlist', () {
    test('should return list of WatchlistTable from database', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlist()).thenAnswer((_) async => [testTVSeriesMap]);
      // act
      final result = await dataSource.getWatchlist();
      // assert
      expect(result, [testTVSeriesTable]);
    });

    test('should return empty list if there is no data', () async {
      // arrange
      when(mockDatabaseHelper.getWatchlist()).thenAnswer((_) async => []);
      // act
      final result = await dataSource.getWatchlist();
      // assert
      expect(result, []);
    });
   });
}