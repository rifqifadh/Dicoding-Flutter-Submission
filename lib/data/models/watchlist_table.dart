import 'package:core/core.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:tvseries/tvseries.dart';

class WatchlistTable extends WatchlistTableInterface with EquatableMixin {
  final int id;
  final String? title;
  final String? posterPath;
  final String? overview;
  final int? nextEpisode;
  final String? nextEpisodeToAir;
  final String? nextEpisodeName;
  final int? seasonNumber;
  final WatchlistType? type;

  WatchlistTable({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.overview,
    required this.nextEpisode,
    required this.nextEpisodeToAir,
    required this.nextEpisodeName,
    required this.seasonNumber,
    required this.type,
  });

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

  factory WatchlistTable.fromTVSeriesEntity(TVSeriesDetail tvSeries) => WatchlistTable(
        id: tvSeries.id,
        title: tvSeries.name,
        posterPath: tvSeries.posterPath,
        overview: tvSeries.overview,
        nextEpisode: tvSeries.nextEpisodeToAir?.episodeNumber ?? 0,
        nextEpisodeToAir: tvSeries.nextEpisodeToAir?.airDate ?? '',
        nextEpisodeName: tvSeries.nextEpisodeToAir?.name ?? '',
        seasonNumber: tvSeries.nextEpisodeToAir?.seasonNumber ?? 0,
        type: WatchlistType.tvSeries,
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

  Watchlist toEntity() => Watchlist(
        id: id,
        overview: overview ?? '',
        posterPath: posterPath ?? '',
        title: title ?? '',
        nextEpisode: nextEpisode ?? 0,
        nextEpisodeToAir: nextEpisodeToAir ?? '',
        nextEpisodeName: nextEpisodeName ?? '',
        seasonNumber: seasonNumber ?? 0,
        type: type ?? WatchlistType.movie,
      );

  @override
  List<Object?> get props => [id, title, posterPath, overview];
}
