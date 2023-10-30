import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late SearchTVSeries usecase;
  late MockTVSeriesRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockTVSeriesRepository();
    usecase = SearchTVSeries(mockMovieRepository);
  });

  final tTvseries = <TVSeries>[];
  const tQuery = 'Loki';

  test('should get list of tvseries from the repository', () async {
    // arrange
    when(mockMovieRepository.searchTVSeries(tQuery))
        .thenAnswer((_) async => Right(tTvseries));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tTvseries));
  });
}
