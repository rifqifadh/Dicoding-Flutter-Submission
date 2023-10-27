import 'package:ditonton/common/watchlist_type.dart';
import 'package:ditonton/data/models/episode_model.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/next_episode_to_air_model.dart';
import 'package:ditonton/data/models/season_model.dart';
import 'package:ditonton/data/models/tv_series_detail_model.dart';
import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:ditonton/data/models/watchlist_table.dart';
import 'package:ditonton/domain/entities/episode.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/next_episode_to_air.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/entities/watchlist.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];
final testWatchlistList = [testWatchlist];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  title: 'title',
  voteAverage: 1,
  voteCount: 1,
);

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

final testMovieTable = WatchlistTable(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
    nextEpisode: 1,
    nextEpisodeToAir: '',
    nextEpisodeName: '',
    seasonNumber: 1,
    type: WatchlistType.movie);

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

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
  'type': 'movie'
};

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

final testTVSeriesModel = TVSeriesModel(
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
    genres: [GenreModel(id: 1, name: 'Action')],
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
    nextEpisodeToAir: NextEpisodeToAirModel(
        id: 1,
        name: 'Ourboros',
        airDate: '',
        seasonNumber: 2,
        episodeNumber: 1));

final testTVSeriesDetail = TVSeriesDetail(
    backdropPath: '',
    genres: [Genre(id: 1, name: 'Action')],
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

final testTVSeriesDetailWithAirDate = TVSeriesDetail(
    backdropPath: '',
    genres: [Genre(id: 1, name: 'Action')],
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
