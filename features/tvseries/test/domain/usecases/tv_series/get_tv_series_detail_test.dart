import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';
import '../../../helpers/test_helpers.mocks.dart';
import '../../../dummy_data/dummy_objects.dart';

void main() {
  late GetTVSeriesDetail usecase;
  late MockTVSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTVSeriesRepository();
    usecase = GetTVSeriesDetail(mockRepository);
  });

  test('should get detail movies from the repository', () async {
    // arrange
    when(mockRepository.getTVSeriesDetail(1))
        .thenAnswer((_) async => const Right(testTVSeriesDetail));
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, const Right(testTVSeriesDetail));
  });

  test('should get detail movies from the repository with airDate', () async {
    // arrange
    when(mockRepository.getTVSeriesDetail(1))
        .thenAnswer((_) async => const Right(testTVSeriesDetailWithAirDate));
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, const Right(testTVSeriesDetailWithAirDate));
  });
}
