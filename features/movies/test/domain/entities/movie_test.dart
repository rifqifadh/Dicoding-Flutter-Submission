

import 'package:flutter_test/flutter_test.dart';
import 'package:movies/domain/entities/movie.dart';

void main() {
  test('Should call from watchlist initializer', () {
    final watchlist = Movie.watchlist(id: 1, overview: 'overview', posterPath: 'posterPath', title: 'title');

    expect(watchlist, isA<Movie>());
  });
}