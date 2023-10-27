import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../../../features/tvseries/lib/data/repositories/tv_series_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TVSeriesRepositoryImpl repository;
  late MockTVSeriesRemoteDataSource mockRemoteDataSource;
  late MockTVSeriesLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockTVSeriesRemoteDataSource();
    mockLocalDataSource = MockTVSeriesLocalDataSource();
    repository = TVSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('get Airing Today TVSeries', () {
    test('should return tvseries list when call to data source is successful',
        () async {
      when(mockRemoteDataSource.getAiringTodayTVSeries())
          .thenAnswer((_) async => testTVSeriesModelList);
      final result = await repository.getAiringTodayTVSeries();
      verify(mockRemoteDataSource.getAiringTodayTVSeries());
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTVSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getAiringTodayTVSeries())
          .thenThrow(ServerException());
      final result = await repository.getAiringTodayTVSeries();
      verify(mockRemoteDataSource.getAiringTodayTVSeries());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getAiringTodayTVSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getAiringTodayTVSeries();
      // assert
      verify(mockRemoteDataSource.getAiringTodayTVSeries());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('get On The Air TVSeries', () {
    test('should return tvseries list when call to data source is successful',
        () async {
      when(mockRemoteDataSource.getOnTheAirTVSeries())
          .thenAnswer((_) async => testTVSeriesModelList);
      final result = await repository.getOnTheAirTVSeries();
      verify(mockRemoteDataSource.getOnTheAirTVSeries());
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTVSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getOnTheAirTVSeries())
          .thenThrow(ServerException());
      final result = await repository.getOnTheAirTVSeries();
      verify(mockRemoteDataSource.getOnTheAirTVSeries());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getOnTheAirTVSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getOnTheAirTVSeries();
      // assert
      verify(mockRemoteDataSource.getOnTheAirTVSeries());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('get Popular TVSeries', () {
    test('should return tvseries list when call to data source is successful',
        () async {
      when(mockRemoteDataSource.getPopularTVSeries())
          .thenAnswer((_) async => testTVSeriesModelList);
      final result = await repository.getPopularTVSeries();
      verify(mockRemoteDataSource.getPopularTVSeries());
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTVSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getPopularTVSeries())
          .thenThrow(ServerException());
      final result = await repository.getPopularTVSeries();
      verify(mockRemoteDataSource.getPopularTVSeries());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getPopularTVSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTVSeries();
      // assert
      verify(mockRemoteDataSource.getPopularTVSeries());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('get Top Rated TVSeries', () {
    test('should return tvseries list when call to data source is successful',
        () async {
      when(mockRemoteDataSource.getTopRatedTVSeries())
          .thenAnswer((_) async => testTVSeriesModelList);
      final result = await repository.getTopRatedTVSeries();
      verify(mockRemoteDataSource.getTopRatedTVSeries());
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTVSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getTopRatedTVSeries())
          .thenThrow(ServerException());
      final result = await repository.getTopRatedTVSeries();
      verify(mockRemoteDataSource.getTopRatedTVSeries());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopRatedTVSeries())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTVSeries();
      // assert
      verify(mockRemoteDataSource.getTopRatedTVSeries());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('get Recommendation TVSeries', () {
    test('should return tvseries list when call to data source is successful',
        () async {
      when(mockRemoteDataSource.getTVSeriesRecommendations(1))
          .thenAnswer((_) async => testTVSeriesModelList);
      final result = await repository.getTVSeriesRecommendations(1);
      verify(mockRemoteDataSource.getTVSeriesRecommendations(1));
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTVSeriesList);
    });

    test('should return tvseries list when call to data source is successful',
        () async {
      when(mockRemoteDataSource.getTVSeriesRecommendations(1))
          .thenThrow(ServerException());
      final result = await repository.getTVSeriesRecommendations(1);
      verify(mockRemoteDataSource.getTVSeriesRecommendations(1));
      expect(result, equals(Left(ServerFailure(''))));
    });

        test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesRecommendations(1))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVSeriesRecommendations(1);
      // assert
      verify(mockRemoteDataSource.getTVSeriesRecommendations(1));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search TVSeries', () {
    test('should return tvseries list when call to data source is successful',
        () async {
      when(mockRemoteDataSource.searchTVSeries('loki'))
          .thenAnswer((_) async => testTVSeriesModelList);
      final result = await repository.searchTVSeries('loki');
      verify(mockRemoteDataSource.searchTVSeries('loki'));
      final resultList = result.getOrElse(() => []);
      expect(resultList, testTVSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.searchTVSeries('loki'))
          .thenThrow(ServerException());
      final result = await repository.searchTVSeries('loki');
      verify(mockRemoteDataSource.searchTVSeries('loki'));
      expect(result, equals(Left(ServerFailure(''))));
    });

            test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchTVSeries('loki'))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTVSeries('loki');
      // assert
      verify(mockRemoteDataSource.searchTVSeries('loki'));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Detail TVSeries', () {
    test('should return tvseries list when call to data source is successful',
        () async {
      when(mockRemoteDataSource.getTVSeriesDetail(1))
          .thenAnswer((_) async => testTVSeriesDetailModel);
      final result = await repository.getTVSeriesDetail(1);
      verify(mockRemoteDataSource.getTVSeriesDetail(1));
      expect(result, equals(Right(testTVSeriesDetail)));
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      when(mockRemoteDataSource.getTVSeriesDetail(1))
          .thenThrow(ServerException());
      final result = await repository.getTVSeriesDetail(1);
      verify(mockRemoteDataSource.getTVSeriesDetail(1));
      expect(result, equals(Left(ServerFailure(''))));
    });

                test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getTVSeriesDetail(1))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTVSeriesDetail(1);
      // assert
      verify(mockRemoteDataSource.getTVSeriesDetail(1));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Save to Watchlist', () {
    test('should retuyrn string when the call to data source is successful',
        () async {
      when(mockLocalDataSource.insertWatchlist(testTVSeriesTable))
          .thenAnswer((_) async => 'Added to Watchlist');

      final result = await repository.saveWatchlist(testTVSeriesDetail);

      expect(result, equals(Right('Added to Watchlist')));
    });

    test(
        'should return DatabaseFailure when the call to data source is unsuccessful',
        () async {
      when(mockLocalDataSource.insertWatchlist(testTVSeriesTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));

      final result = await repository.saveWatchlist(testTVSeriesDetail);

      expect(result, equals(Left(DatabaseFailure('Failed to add watchlist'))));
    });
  });

  group('Remove from Watchlist', () {
    test('should retuyrn string when the call to data source is successful',
        () async {
      when(mockLocalDataSource.removeWatchlist(testTVSeriesTable))
          .thenAnswer((_) async => 'Removed from Watchlist');

      final result = await repository.removeWatchlist(testTVSeriesDetail);

      expect(result, equals(Right('Removed from Watchlist')));
    });

    test(
        'should return DatabaseFailure when the call to data source is unsuccessful',
        () async {
      when(mockLocalDataSource.removeWatchlist(testTVSeriesTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));

      final result = await repository.removeWatchlist(testTVSeriesDetail);

      expect(
          result, equals(Left(DatabaseFailure('Failed to remove watchlist'))));
    });
  });

  group('Is Added to Watchlist', () {
    test('should return tvseries list when call to data source is successful',
        () async {
      when(mockLocalDataSource.getWatchlistById(1))
          .thenAnswer((_) async => testTVSeriesTable);

      final result = await repository.isAddedToWatchlist(1);

      expect(result, true);
    });
  });
}
