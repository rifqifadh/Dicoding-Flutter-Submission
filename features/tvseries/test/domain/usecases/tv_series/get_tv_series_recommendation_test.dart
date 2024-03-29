import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/tvseries.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late GetTVSeriesRecommendations usecase;
  late MockTVSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTVSeriesRepository();
    usecase = GetTVSeriesRecommendations(mockRepository);
  });

  test('should get list recommendation of movies from the repository', () async {
    // arrange
    when(mockRepository.getTVSeriesRecommendations(1))
        .thenAnswer((_) async => Right(testTVSeriesList));
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, Right(testTVSeriesList));
  });
}
