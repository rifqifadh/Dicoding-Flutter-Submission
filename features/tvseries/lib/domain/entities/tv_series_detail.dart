import 'package:equatable/equatable.dart';
import 'package:tvseries/tvseries.dart';

class TVSeriesDetail extends Equatable {
  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;
  final List<Season> seasons;
  final NextEpisodeToAir? nextEpisodeToAir;
  
  const TVSeriesDetail({
    required this.backdropPath,
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
    required this.nextEpisodeToAir
  });

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
      seasons,
      nextEpisodeToAir
    ];
  }
}
