

import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/tvseries.dart';

void main() {
  test('Should call from watchlist initializer', () {
    final watchlist = TVSeries.watchlist(id: 1, overview: 'overview', posterPath: 'posterPath', name: 'name', nextEpisodeToAir: NextEpisodeToAir(id: 1, name: 'name', airDate: '2023-12-12', seasonNumber: 1, episodeNumber: 2));

    expect(watchlist, isA<TVSeries>());
  });
}