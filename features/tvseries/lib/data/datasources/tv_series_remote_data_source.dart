import 'dart:convert';

import 'package:core/core.dart';
import 'package:http/http.dart' as http;
import 'package:tvseries/tvseries.dart';

abstract class TVSeriesRemoteDataSource {
  Future<List<TVSeriesModel>> getAiringTodayTVSeries();
  Future<List<TVSeriesModel>> getPopularTVSeries();
  Future<List<TVSeriesModel>> getOnTheAirTVSeries();
  Future<List<TVSeriesModel>> getTopRatedTVSeries();
  Future<List<TVSeriesModel>> getTVSeriesRecommendations(int id);
  Future<TVSeriesDetailModel> getTVSeriesDetail(int id);
  Future<List<TVSeriesModel>> searchTVSeries(String query);
}

class TVSeriesRemoteDataSourceImpl implements TVSeriesRemoteDataSource {
final http.Client client;

TVSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TVSeriesModel>> getAiringTodayTVSeries() async {
    final response =
        await client.get(Uri.parse('${ENV.BASE_URL}/tv/airing_today?${ENV.API_KEY}'));

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> getOnTheAirTVSeries() async {
    final response =
        await client.get(Uri.parse('${ENV.BASE_URL}/tv/on_the_air?${ENV.API_KEY}'));
    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> getPopularTVSeries() async {
    final response =
        await client.get(Uri.parse('${ENV.BASE_URL}/tv/popular?${ENV.API_KEY}'));

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> getTopRatedTVSeries() async {
    final response =
        await client.get(Uri.parse('${ENV.BASE_URL}/tv/top_rated?${ENV.API_KEY}'));

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }
  
  @override
  Future<TVSeriesDetailModel> getTVSeriesDetail(int id) async {
    final response =
        await client.get(Uri.parse('${ENV.BASE_URL}/tv/$id?${ENV.API_KEY}'));

    if (response.statusCode == 200) {
      return TVSeriesDetailModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

    @override
  Future<List<TVSeriesModel>> getTVSeriesRecommendations(int id) async {
    final response = await client
        .get(Uri.parse('${ENV.BASE_URL}/tv/$id/recommendations?${ENV.API_KEY}'));

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TVSeriesModel>> searchTVSeries(String query) async {
    final response = await client
        .get(Uri.parse('${ENV.BASE_URL}/search/tv?${ENV.API_KEY}&query=$query'));

    if (response.statusCode == 200) {
      return TVSeriesResponse.fromJson(json.decode(response.body)).results;
    } else {
      throw ServerException();
    }
  }
}
