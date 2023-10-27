// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ditonton/domain/entities/next_episode_to_air.dart';
import 'package:equatable/equatable.dart';

class TVSeries extends Equatable {
  String? backdropPath;
  String? firstAirDate;
  List<int>? genreIds;
  int? id;
  String? name;
  List<String>? originCountry;
  String? originalLanguage;
  String? originalName;
  String overview;
  double? popularity;
  String? posterPath;
  num? voteAverage;
  int? voteCount;
  NextEpisodeToAir? nextEpisodeToAir;
  
  TVSeries({
    this.backdropPath = '',
    this.firstAirDate  = '',
    this.genreIds = const [],
    required this.id,
    required this.name,
    this.originCountry = const [],
    this.originalLanguage = '',
    this.originalName = '',
    required this.overview,
    this.popularity = 0,
    required this.posterPath,
    this.voteAverage = 0,
    this.voteCount = 0,
    this.nextEpisodeToAir
  });

   TVSeries.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
    required this.nextEpisodeToAir,
  });

  @override
  List<Object?> get props => [
      backdropPath,
      firstAirDate,
      genreIds,
      id,
      name,
      originCountry,
      originalLanguage,
      originalName,
      overview,
      popularity,
      posterPath,
      voteAverage,
      voteCount,
      nextEpisodeToAir
    ];
}
