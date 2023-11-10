
import 'package:core/database_helper/database_helper.dart';
import 'package:tvseries/data/models/next_episode_to_air_model.dart';
import 'package:tvseries/domain/entities/watchlist.dart';
import 'package:tvseries/tvseries.dart';

final testWatchlistList = [testWatchlist];

const testWatchlist = Watchlist(
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

final testTVSeries = TVSeries(
    id: 1,
    name: 'Loki',
    overview: 'After stealing the Tesseract during the events of',
    posterPath: '/voHUmluYmKyleFkTu3lOXQG702u.jpg',
    voteAverage: 0.0);

var testTVSeriesWithSeason = TVSeries(
    id: 1,
    name: 'Loki',
    overview: 'After stealing the Tesseract during the events of',
    posterPath: '/voHUmluYmKyleFkTu3lOXQG702u.jpg',
    voteAverage: 0.0,
    nextEpisodeToAir: NextEpisodeToAir(
        id: 1,
        name: 'Ourboros',
        airDate: '2019-05-19',
        seasonNumber: 2,
        episodeNumber: 1)
    );

const testTVSeriesModel = TVSeriesModel(
    backdropPath: '',
    firstAirDate: '',
    genreIds: [],
    id: 1,
    name: 'Loki',
    originCountry: [],
    originalLanguage: '',
    originalName: '',
    overview: 'After stealing the Tesseract during the events of',
    popularity: 0,
    posterPath: '/voHUmluYmKyleFkTu3lOXQG702u.jpg',
    voteAverage: 0,
    voteCount: 0);

final testTVSeriesList = [testTVSeries];
final testTVSeriesModelList = [testTVSeriesModel];

final testTVSeriesDetailModel = TVSeriesDetailModel(
    backdropPath: '',
    genres: const [GenreModel(id: 1, name: 'Action')],
    id: 1,
    name: 'Loki',
    numberOfEpisodes: 16,
    numberOfSeasons: 2,
    originalLanguage: '',
    originalName: '',
    overview: 'After stealing the Tesseract during the events of',
    popularity: 0,
    posterPath: '/voHUmluYmKyleFkTu3lOXQG702u.jpg',
    status: '',
    tagline: '',
    type: '',
    voteAverage: 0,
    voteCount: 0,
    seasons: [
      SeasonModel(airDate: '', episodeCount: 1, id: 1, name: '', episodes: [
        EpisodeModel(
            airDate: '',
            episodeNumber: 1,
            id: 1,
            name: '',
            overview: '',
            seasonNumber: 1,
            stillPath: '',
            voteAverage: 0,
            runtime: 120,
            showId: 1)
      ])
    ],
    nextEpisodeToAir: const NextEpisodeToAirModel(
        id: 1,
        name: 'Ourboros',
        airDate: '',
        seasonNumber: 2,
        episodeNumber: 1));

final testTVSeriesDetail = TVSeriesDetail(
    backdropPath: '',
    genres: const [Genre(id: 1, name: 'Action')],
    id: 1,
    name: 'Loki',
    numberOfEpisodes: 16,
    numberOfSeasons: 2,
    originalLanguage: '',
    originalName: '',
    overview: 'After stealing the Tesseract during the events of',
    popularity: 0,
    posterPath: '/voHUmluYmKyleFkTu3lOXQG702u.jpg',
    status: '',
    tagline: '',
    type: '',
    voteAverage: 0,
    voteCount: 0,
    seasons: const [
      Season(airDate: '', episodeCount: 1, id: 1, name: '', episodes: [
        Episode(
            airDate: '',
            episodeNumber: 1,
            id: 1,
            name: '',
            overview: '',
            seasonNumber: 1,
            stillPath: '',
            voteAverage: 0,
            runtime: 120,
            showId: 1)
      ])
    ],
    nextEpisodeToAir: NextEpisodeToAir(
        id: 1,
        name: 'Ourboros',
        airDate: '',
        seasonNumber: 2,
        episodeNumber: 1));

const testTVSeriesDetailFailure = TVSeriesDetail(
    backdropPath: '',
    genres: [],
    id: 1,
    name: 'Loki',
    numberOfEpisodes: 16,
    numberOfSeasons: 2,
    originalLanguage: '',
    originalName: '',
    overview: '',
    popularity: 0,
    posterPath: '',
    status: '',
    tagline: '',
    type: '',
    voteAverage: 0,
    voteCount: 0,
    seasons: [],
    nextEpisodeToAir: null);

final testTVSeriesDetailWithAirDate = TVSeriesDetail(
    backdropPath: '',
    genres: const [Genre(id: 1, name: 'Action')],
    id: 1,
    name: 'Loki',
    numberOfEpisodes: 16,
    numberOfSeasons: 2,
    originalLanguage: '',
    originalName: '',
    overview: 'After stealing the Tesseract during the events of',
    popularity: 0,
    posterPath: '/voHUmluYmKyleFkTu3lOXQG702u.jpg',
    status: '',
    tagline: '',
    type: '',
    voteAverage: 0,
    voteCount: 0,
    seasons: const [
      Season(airDate: '', episodeCount: 1, id: 1, name: '', episodes: [
        Episode(
            airDate: '',
            episodeNumber: 1,
            id: 1,
            name: '',
            overview: '',
            seasonNumber: 1,
            stillPath: '',
            voteAverage: 0,
            runtime: 120,
            showId: 1)
      ])
    ],
    nextEpisodeToAir: NextEpisodeToAir(
        id: 1,
        name: 'Ourboros',
        airDate: '',
        seasonNumber: 2,
        episodeNumber: 1));
