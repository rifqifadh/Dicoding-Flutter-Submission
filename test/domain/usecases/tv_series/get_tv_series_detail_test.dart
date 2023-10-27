import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/tv_series/get_tv_series_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

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
        .thenAnswer((_) async => Right(testTVSeriesDetail));
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, Right(testTVSeriesDetail));
  });

  test('should get detail movies from the repository with airDate', () async {
    // arrange
    when(mockRepository.getTVSeriesDetail(1))
        .thenAnswer((_) async => Right(testTVSeriesDetailWithAirDate));
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, Right(testTVSeriesDetailWithAirDate));
  });
}
