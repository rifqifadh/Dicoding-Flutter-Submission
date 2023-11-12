import 'package:equatable/equatable.dart';
import 'package:tvseries/domain/entities/next_episode_to_air.dart';

class NextEpisodeToAirModel extends Equatable {
  final int? id;
  final String? name;
  final String? airDate;
  final int? seasonNumber;
  final int? episodeNumber;

  const NextEpisodeToAirModel(
      {this.id,
      this.name,
      this.airDate,
      this.seasonNumber,
      this.episodeNumber});

  factory NextEpisodeToAirModel.fromJson(Map<String, dynamic> json) =>
      NextEpisodeToAirModel(
        id: json["id"],
        name: json["name"],
        airDate: json["air_date"],
        seasonNumber: json["season_number"],
        episodeNumber: json["episode_number"],
      );

  @override
  List<Object?> get props {
    return [
      id,
      name,
      airDate,
      seasonNumber,
      episodeNumber,
    ];
  }

  NextEpisodeToAir toEntity() {
    return NextEpisodeToAir(
        id: id ?? 0,
        name: name ?? '',
        airDate: airDate ?? '',
        seasonNumber: seasonNumber ?? 1,
        episodeNumber: episodeNumber ?? 1);
  }
}
