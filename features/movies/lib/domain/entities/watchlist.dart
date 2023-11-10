import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';

class Watchlist extends Equatable {
  final int id;
  final String title;
  final String posterPath;
  final String overview;
  final int nextEpisode;
  final String nextEpisodeToAir;
  final String nextEpisodeName;
  final int seasonNumber;
  final WatchlistType type;

  const Watchlist({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.nextEpisode,
    required this.nextEpisodeToAir,
    required this.type,
    required this.nextEpisodeName,
    required this.seasonNumber,
  });

  Movie toMovie() => Movie.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        title: title,
  );

  @override
  List<Object> get props {
    return [
      id,
      title,
      posterPath,
      overview,
      type,
    ];
  }
}
