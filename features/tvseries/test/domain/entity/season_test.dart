
import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/tvseries.dart';

void main() {
  test('Should get airDate from response', () {
    // arrange
    const season = Season(
      sId: '1',
      airDate: '2021-06-09',
      episodes: [],
      name: 'Loki',
      overview: 'overview',
      id: 1,
      posterPath: 'posterPath',
      seasonNumber: 1,
      voteAverage: 0,
      episodeCount: 0
    );
    // act
    final result = season.airDateYear();
    // assert
    expect(result, '2021');
  });

  test('Should get airDate from response with empty response', () {
    // arrange
    const season = Season(
      sId: '1',
      airDate: '',
      episodes: [],
      name: 'Loki',
      overview: 'overview',
      id: 1,
      posterPath: 'posterPath',
      seasonNumber: 1,
      voteAverage: 0,
      episodeCount: 0
    );
    // act
    final result = season.airDateYear();
    // assert
    expect(result, '-');
  });
}