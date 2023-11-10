

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlist mockBloc;
  late MockWatchlistRepository repository;

  setUp(() {
    repository = MockWatchlistRepository();
    mockBloc = GetWatchlist(repository);
  });

  group('GetWatchlist Tests', () {
    test('should get list of watchlist from the repository', () async {
      // arrange
      when(repository.getWatchlist()).thenAnswer((_) async => Right(testWatchlistList));
      // act
      final result = await mockBloc.execute();
      // assert
      expect(result, Right(testWatchlistList));
    });

    test('should return server error when call to repository is unsuccessful', () async {
      // arrange
      when(repository.getWatchlist()).thenAnswer((_) async => Left(DatabaseFailure('Server Failure')));
      // act
      final result = await mockBloc.execute();
      // assert
      expect(result, Left(DatabaseFailure('Server Failure')));
    });
  });
}