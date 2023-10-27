import 'dart:convert';
import 'dart:io';

import 'package:core/core.dart';
import 'package:ditonton/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const API_KEY = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const BASE_URL = 'https://api.themoviedb.org/3';

  late TVSeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TVSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get On The Air TVSeries', () {
    final tvSeriesList = TVSeriesResponse.fromJson(
            json.decode(readJson('dummy_data/tvseries_on_the_air.json')))
        .results;

    test('should return list of TVSeries Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response(
                  readJson('dummy_data/tvseries_on_the_air.json'), 200,
                  headers: {
                    HttpHeaders.contentTypeHeader:
                        'application/json; charset=utf-8',
                  }));
      // // act
      final result = await dataSource.getOnTheAirTVSeries();
      // // assert
      expect(result, equals(tvSeriesList));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/on_the_air?$API_KEY')))
          .thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getOnTheAirTVSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get Popular TVSeries', () {
    group('get Popular TVSeries', () {
      final tvSeriesList = TVSeriesResponse.fromJson(
              json.decode(readJson('dummy_data/tvseries_popular.json')))
          .results;

      test('should return list of TVSeries Model when the response code is 200',
          () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
            .thenAnswer((_) async => http.Response(
                    readJson('dummy_data/tvseries_popular.json'), 200,
                    headers: {
                      HttpHeaders.contentTypeHeader:
                          'application/json; charset=utf-8',
                    }));
        // // act
        final result = await dataSource.getPopularTVSeries();
        // // assert
        expect(result, equals(tvSeriesList));
      });

      test(
          'should throw a ServerException when the response code is 404 or other',
          () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/popular?$API_KEY')))
            .thenAnswer((_) async => http.Response(
                    readJson('dummy_data/tvseries_popular.json'), 404,
                    headers: {
                      HttpHeaders.contentTypeHeader:
                          'application/json; charset=utf-8',
                    }));
        // act
        final call = dataSource.getPopularTVSeries();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
    });
  });

  group('get Top Rated TVSeries', () {
    group('get Popular TVSeries', () {
      final tvSeriesList = TVSeriesResponse.fromJson(
              json.decode(readJson('dummy_data/tvseries_top_rated.json')))
          .results;

      test('should return list of TVSeries Model when the response code is 200',
          () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
            .thenAnswer((_) async => http.Response(
                    readJson('dummy_data/tvseries_top_rated.json'), 200,
                    headers: {
                      HttpHeaders.contentTypeHeader:
                          'application/json; charset=utf-8',
                    }));
        // // act
        final result = await dataSource.getTopRatedTVSeries();
        // // assert
        expect(result, equals(tvSeriesList));
      });

      test(
          'should throw a ServerException when the response code is 404 or other',
          () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/top_rated?$API_KEY')))
            .thenAnswer((_) async => http.Response(
                    readJson('dummy_data/tvseries_top_rated.json'), 404,
                    headers: {
                      HttpHeaders.contentTypeHeader:
                          'application/json; charset=utf-8',
                    }));
        // act
        final call = dataSource.getTopRatedTVSeries();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
    });
  });

  group('get Airing Today TVSeries', () {
    group('get Popular TVSeries', () {
      final tvSeriesList = TVSeriesResponse.fromJson(
              json.decode(readJson('dummy_data/tvseries_airing_today.json')))
          .results;

      test('should return list of TVSeries Model when the response code is 200',
          () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
            .thenAnswer((_) async => http.Response(
                    readJson('dummy_data/tvseries_airing_today.json'), 200,
                    headers: {
                      HttpHeaders.contentTypeHeader:
                          'application/json; charset=utf-8',
                    }));
        // // act
        final result = await dataSource.getAiringTodayTVSeries();
        // // assert
        expect(result, equals(tvSeriesList));
      });

      test(
          'should throw a ServerException when the response code is 404 or other',
          () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/airing_today?$API_KEY')))
            .thenAnswer((_) async => http.Response(
                    readJson('dummy_data/tvseries_airing_today.json'), 404,
                    headers: {
                      HttpHeaders.contentTypeHeader:
                          'application/json; charset=utf-8',
                    }));
        // act
        final call = dataSource.getAiringTodayTVSeries();
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
    });
  });

  group('get Detail TVSeries', () {
    group('get Detail TVSeries', () {
      final response = TVSeriesDetailModel.fromJson(
              json.decode(readJson('dummy_data/tvseries_detail.json')));

      test('should return list of TVSeries Model when the response code is 200',
          () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/84958?$API_KEY')))
            .thenAnswer((_) async => http.Response(
                    readJson('dummy_data/tvseries_detail.json'), 200,
                    headers: {
                      HttpHeaders.contentTypeHeader:
                          'application/json; charset=utf-8',
                    }));
        // // act
        final result = await dataSource.getTVSeriesDetail(84958);
        // // assert
        expect(result, equals(response));
      });

      test(
          'should throw a ServerException when the response code is 404 or other',
          () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/84958?$API_KEY')))
            .thenAnswer((_) async => http.Response(
                    readJson('dummy_data/tvseries_detail.json'), 404,
                    headers: {
                      HttpHeaders.contentTypeHeader:
                          'application/json; charset=utf-8',
                    }));
        // act
        final call = dataSource.getTVSeriesDetail(84958);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
    });
  });

  group('search TVSeries', () {
    group('search TVSeries', () {
      final tvSeriesList = TVSeriesResponse.fromJson(
              json.decode(readJson('dummy_data/search_loki.json')))
          .results;
          final query = 'loki';

      test('should return list of TVSeries Model when the response code is 200',
          () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query')))
            .thenAnswer((_) async => http.Response(
                    readJson('dummy_data/search_loki.json'), 200,
                    headers: {
                      HttpHeaders.contentTypeHeader:
                          'application/json; charset=utf-8',
                    }));
        // // act
        final result = await dataSource.searchTVSeries(query);
        // // assert
        expect(result, equals(tvSeriesList));
      });

      test(
          'should throw a ServerException when the response code is 404 or other',
          () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$BASE_URL/search/tv?$API_KEY&query=$query')))
            .thenAnswer((_) async => http.Response(
                    readJson('dummy_data/search_loki.json'), 404,
                    headers: {
                      HttpHeaders.contentTypeHeader:
                          'application/json; charset=utf-8',
                    }));
        // act
        final call = dataSource.searchTVSeries(query);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
    });
  });

  group('Recommendation by TVSeries', () {
    group('Recommendation by TVSeries', () {
      final tvSeriesList = TVSeriesResponse.fromJson(
              json.decode(readJson('dummy_data/tv_recommendation.json')))
          .results;
final id = 28511;

      test('should return list of TVSeries Model when the response code is 200',
          () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY')))
            .thenAnswer((_) async => http.Response(
                    readJson('dummy_data/tv_recommendation.json'), 200,
                    headers: {
                      HttpHeaders.contentTypeHeader:
                          'application/json; charset=utf-8',
                    }));
        // // act
        final result = await dataSource.getTVSeriesRecommendations(id);
        // // assert
        expect(result, equals(tvSeriesList));
      });

      test(
          'should throw a ServerException when the response code is 404 or other',
          () async {
        // arrange
        when(mockHttpClient.get(Uri.parse('$BASE_URL/tv/$id/recommendations?$API_KEY')))
            .thenAnswer((_) async => http.Response(
                    readJson('dummy_data/tv_recommendation.json'), 404,
                    headers: {
                      HttpHeaders.contentTypeHeader:
                          'application/json; charset=utf-8',
                    }));
        // act
        final call = dataSource.getTVSeriesRecommendations(id);
        // assert
        expect(() => call, throwsA(isA<ServerException>()));
      });
    });
  });
}

