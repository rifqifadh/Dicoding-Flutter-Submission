import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:core/core.dart';

class WatchlistTable extends WatchlistTableInterface with EquatableMixin {

  WatchlistTable({
    required int id,
    String? title,
    String? posterPath,
    String? overview,
    int? nextEpisode,
    String? nextEpisodeToAir,
    String? nextEpisodeName,
    int? seasonNumber,
    WatchlistType? type,
  }) : super(
            id: id,
            title: title,
            posterPath: posterPath,
            overview: overview,
            nextEpisode: nextEpisode,
            nextEpisodeToAir: nextEpisodeToAir,
            nextEpisodeName: nextEpisodeName,
            seasonNumber: seasonNumber,
            type: type);

  factory WatchlistTable.fromMovieEntity(MovieDetail movie) => WatchlistTable(
        id: movie.id,
        title: movie.title,
        posterPath: movie.posterPath,
        overview: movie.overview,
        nextEpisode: 0,
        nextEpisodeToAir: '',
        nextEpisodeName: '',
        seasonNumber: 0,
        type: WatchlistType.movie,
      );

  factory WatchlistTable.fromMap(Map<String, dynamic> map) {
    return WatchlistTable(
      id: map['id'],
      title: map['title'],
      posterPath: map['posterPath'],
      overview: map['overview'],
      nextEpisode: map['nextEpisode'],
      nextEpisodeToAir: map['nextEpisodeToAir'],
      nextEpisodeName: map['nextEpisodeName'],
      seasonNumber: map['seasonNumber'],
      type: WatchlistType.values.byName(map['type']),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'posterPath': posterPath,
        'overview': overview,
        'nextEpisode': nextEpisode,
        'nextEpisodeToAir': nextEpisodeToAir,
        'nextEpisodeName': nextEpisodeName,
        'seasonNumber': seasonNumber,
        'type': type?.name.toString() ?? 'movie',
      };

  @override
  List<Object?> get props => [id, title, posterPath, overview];
}
