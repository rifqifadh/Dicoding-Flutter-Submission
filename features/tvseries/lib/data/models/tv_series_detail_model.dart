import 'package:equatable/equatable.dart';
import 'package:tvseries/data/models/genre_model.dart';
import 'package:tvseries/data/models/next_episode_to_air_model.dart';
import 'package:tvseries/data/models/season_model.dart';
import 'package:tvseries/domain/entities/tv_series_detail.dart';

class TVSeriesDetailModel extends Equatable {
  final String? backdropPath;
  final List<GenreModel> genres;
  final int id;
  final String? name;
  final int? numberOfEpisodes;
  final int? numberOfSeasons;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? status;
  final String? tagline;
  final String? type;
  final double? voteAverage;
  final int? voteCount;
  final List<SeasonModel> seasons;
  final NextEpisodeToAirModel? nextEpisodeToAir;

  const TVSeriesDetailModel(
      {required this.backdropPath,
      required this.genres,
      required this.id,
      required this.name,
      required this.numberOfEpisodes,
      required this.numberOfSeasons,
      required this.originalLanguage,
      required this.originalName,
      required this.overview,
      required this.popularity,
      required this.posterPath,
      required this.status,
      required this.tagline,
      required this.type,
      required this.voteAverage,
      required this.voteCount,
      required this.seasons,
      required this.nextEpisodeToAir});

  factory TVSeriesDetailModel.fromJson(Map<String, dynamic> json) =>
      TVSeriesDetailModel(
        backdropPath: json['backdrop_path'],
        genres: List<GenreModel>.from(
            json["genres"].map((x) => GenreModel.fromJson(x))),
        id: json['id'],
        name: json['name'],
        numberOfEpisodes: json['number_of_episodes'],
        numberOfSeasons: json['number_of_seasons'],
        originalLanguage: json['original_language'],
        originalName: json['original_name'],
        overview: json['overview'],
        popularity: json['popularity'],
        posterPath: json['poster_path'],
        status: json['status'],
        tagline: json['tagline'],
        type: json['type'],
        voteAverage: json['vote_average'].toDouble(),
        voteCount: json['vote_count'],
        seasons: List<SeasonModel>.from(
            json["seasons"].map((x) => SeasonModel.fromJson(x))),
        nextEpisodeToAir: json['next_episode_to_air'] == null
            ? null
            : NextEpisodeToAirModel.fromJson(json['next_episode_to_air']),
      );

  @override
  List<Object?> get props {
    return [
      backdropPath,
      genres,
      id,
      name,
      numberOfEpisodes,
      numberOfSeasons,
      originalLanguage,
      originalName,
      overview,
      popularity,
      posterPath,
      status,
      tagline,
      type,
      voteAverage,
      voteCount,
      seasons
    ];
  }

  TVSeriesDetail toEntity() {
    return TVSeriesDetail(
      backdropPath: backdropPath,
      genres: genres.map((e) => e.toEntity()).toList(),
      id: id,
      name: name ?? '',
      numberOfEpisodes: numberOfEpisodes ?? 0,
      numberOfSeasons: numberOfSeasons ?? 0,
      originalLanguage: originalLanguage ?? '',
      originalName: originalName ?? '',
      overview: overview ?? '',
      popularity: popularity ?? 0.0,
      posterPath: posterPath ?? '',
      status: status ?? '',
      tagline: tagline ?? '',
      type: type ?? '',
      voteAverage: voteAverage ?? 0.0,
      voteCount: voteCount ?? 0,
      seasons: seasons.map((e) => e.toEntity()).toList(),
      nextEpisodeToAir: nextEpisodeToAir?.toEntity(),
    );
  }
}
