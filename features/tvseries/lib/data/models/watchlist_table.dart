import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:tvseries/domain/entities/tv_series_detail.dart';
import 'package:tvseries/domain/entities/watchlist.dart';

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
            type: type
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

  Watchlist toEntity() => Watchlist(
        id: id ?? 0,
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
