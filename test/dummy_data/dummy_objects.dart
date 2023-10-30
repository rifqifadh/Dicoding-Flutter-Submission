import 'package:core/core.dart';
import 'package:ditonton/data/models/watchlist_table.dart';
import 'package:ditonton/domain/entities/watchlist.dart';

final testWatchlistList = [testWatchlist];

final testWatchlist = Watchlist(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
    nextEpisode: 1,
    nextEpisodeToAir: 'nextEpisodeToAir',
    nextEpisodeName: 'nextEpisodeName',
    seasonNumber: 1,
    type: WatchlistType.tvSeries);

final testTVSeriesTable = WatchlistTable(
    id: 1,
    title: 'Loki',
    posterPath: '/voHUmluYmKyleFkTu3lOXQG702u.jpg',
    overview: 'After stealing the Tesseract during the events of',
    nextEpisode: 1,
    nextEpisodeToAir: 'nextEpisodeToAir',
    nextEpisodeName: 'nextEpisodeName',
    seasonNumber: 2,
    type: WatchlistType.tvSeries);

final testTVSeriesMap = {
  'id': 1,
  'overview': 'After stealing the Tesseract during the events of',
  'posterPath': '/voHUmluYmKyleFkTu3lOXQG702u.jpg',
  'title': 'Loki',
  'type': 'tvSeries',
  'nextEpisode': 1,
  'nextEpisodeToAir': 'nextEpisodeToAir',
  'nextEpisodeName': 'nextEpisodeName',
  'seasonNumber': 2,
};