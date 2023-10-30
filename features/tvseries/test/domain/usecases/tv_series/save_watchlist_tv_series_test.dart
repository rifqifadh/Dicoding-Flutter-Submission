import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';
import '../../../helpers/test_helpers.mocks.dart';
import '../../../dummy_data/dummy_objects.dart';

void main() {
  late SaveWatchlistTVSeries usecase;
  late MockTVSeriesRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockTVSeriesRepository();
    usecase = SaveWatchlistTVSeries(mockMovieRepository);
  });

  test('should save tvseries to the repository', () async {
    // arrange
    when(mockMovieRepository.saveWatchlist(testTVSeriesDetail))
        .thenAnswer((_) async => const Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTVSeriesDetail);
    // assert
    verify(mockMovieRepository.saveWatchlist(testTVSeriesDetail));
    expect(result, const Right('Added to Watchlist'));
  });
}
