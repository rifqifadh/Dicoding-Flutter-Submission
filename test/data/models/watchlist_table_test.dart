
import 'package:core/core.dart';
import 'package:ditonton/data/models/watchlist_table.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {

  test('Should map from WatchlistTable to JSON', () {
    // arrange
    final watchlistTable = WatchlistTable(
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
    final json = {
      'id': 1,
      'title': 'title',
      'posterPath': 'posterPath',
      'overview': 'overview',
      'nextEpisode': 2,
      'nextEpisodeToAir': '2023-01-01',
      'type': 'tvSeries',
      'nextEpisodeName': 'Loki',
      'seasonNumber': 1,
    };
    // act
    final result = watchlistTable.toJson();
    // assert
    expect(result, json);
  });
}