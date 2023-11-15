import 'package:core/core.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:tvseries/domain/entities/next_episode_to_air.dart';
import 'package:tvseries/domain/entities/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';


void main() {

  test('Should map from Watchlist to Movie Entity', () {
    // arrange
    final watchlist = Watchlist(
      id: 1,
      title: 'title',
      posterPath: 'posterPath',
      overview: 'overview',
      nextEpisode: 0,
      nextEpisodeToAir: '',
      type: WatchlistType.movie,
      nextEpisodeName: '',
      seasonNumber: 0,
    );
    final movie = Movie.watchlist(
      id: 1,
      title: 'title',
      posterPath: 'posterPath',
      overview: 'overview',
    );
    // act
    final result = watchlist.toMovie();
    // assert
    expect(result, movie);
  });

  test('Should map from Watchlist to TVSeries Entity', () {
    // arrange
    final watchlist = Watchlist(
      id: 1,
      title: 'title',
      posterPath: 'posterPath',
      overview: 'overview',
      nextEpisode: 2,
      nextEpisodeToAir: '2023-01-01',
      type: WatchlistType.tvSeries,
      nextEpisodeName: 'Loki',
      seasonNumber: 1,
    );
    final tvSeries = TVSeries.watchlist(
      id: 1,
      name: 'title',
      posterPath: 'posterPath',
      overview: 'overview',
      nextEpisodeToAir: NextEpisodeToAir(id: 0, name: 'Loki', airDate: '2023-01-01', seasonNumber: 1, episodeNumber: 2),
    );
    // act
    final result = watchlist.toTVSeries();
    // assert
    expect(result, tvSeries);
  });

  test('Should map watchlist to toJson with unimplemented', () {
    final watchlist = Watchlist(
      id: 1,
      title: 'title',
      posterPath: 'posterPath',
      overview: 'overview',
      nextEpisode: 2,
      nextEpisodeToAir: '2023-01-01',
      type: WatchlistType.tvSeries,
      nextEpisodeName: 'Loki',
      seasonNumber: 1,
    );

    expect(() => watchlist.toJson(), throwsUnimplementedError);
  });
}