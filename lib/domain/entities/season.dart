// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/entities/episode.dart';

class Season extends Equatable {
  final String sId;
  final String airDate;
  final List<Episode> episodes;
  final String name;
  final String overview;
  final int id;
  final String posterPath;
  final int seasonNumber;
  final double voteAverage;
  final int episodeCount;
  

  String airDateYear() {
    if (airDate.isEmpty) {
      return '-';
    }
    final date = DateTime.parse(airDate);
    return '${date.year}';
  }

  Season({
    this.sId = '',
    this.airDate = '',
    this.episodes = const [],
    this.name = '',
    this.overview = '',
    this.id = 0,
    this.posterPath = '',
    this.seasonNumber = 1,
    this.voteAverage = 0,
    this.episodeCount = 0
  });

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
}
