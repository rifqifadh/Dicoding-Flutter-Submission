import 'package:equatable/equatable.dart';
import 'package:tvseries/tvseries.dart';

class SeasonModel extends Equatable {
  final String? sId;
  final String? airDate;
  final List<EpisodeModel>? episodes;
  final String? name;
  final String? overview;
  final int? id;
  final String? posterPath;
  final int? seasonNumber;
  final double? voteAverage;
  final int? episodeCount;

  const SeasonModel(
      {this.sId,
      this.airDate,
      this.episodes,
      this.name,
      this.overview,
      this.id,
      this.posterPath,
      this.seasonNumber,
      this.voteAverage,
      this.episodeCount});

  factory SeasonModel.fromJson(Map<String, dynamic> json) => SeasonModel(
        sId: json['_id'],
        airDate: json['air_date'],
        episodes: json['episodes'] == null ? [] : List<EpisodeModel>.from(
            json["episodes"].map((x) => EpisodeModel.fromJson(x))),
        name: json['name'],
        overview: json['overview'],
        id: json['id'],
        posterPath: json['poster_path'],
        seasonNumber: json['season_number'],
        voteAverage: json['vote_average'].toDouble(),
        episodeCount: json['episode_count'] ?? 0,
      );

  @override
  List<Object?> get props {
    return [
      sId,
      airDate,
      episodes,
      name,
      overview,
      id,
      posterPath,
      seasonNumber,
      voteAverage,
      episodeCount
    ];
  }

  Season toEntity() {
    return Season(
      sId: sId ?? '',
      airDate: airDate ?? '',
      episodes: episodes?.map((e) => e.toEntity()).toList() ?? [],
      name: name ?? '',
      overview: overview ?? '',
      id: id ?? 0,
      posterPath: posterPath ?? '',
      seasonNumber: seasonNumber ?? 1,
      voteAverage: voteAverage ?? 0,
      episodeCount: episodeCount ?? 0,
    );
  }
}
