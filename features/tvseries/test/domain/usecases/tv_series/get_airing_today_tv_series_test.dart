import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_airing_today_tv_series.dart';

import '../../../helpers/test_helpers.mocks.dart';
import '../../../dummy_data/dummy_objects.dart';

void main() {
  late GetAirTodayTVSeries usecase;
  late MockTVSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTVSeriesRepository();
    usecase = GetAirTodayTVSeries(mockRepository);
  });

  test('should get list of movies from the repository', () async {
    // arrange
    when(mockRepository.getAiringTodayTVSeries())
        .thenAnswer((_) async => Right(testTVSeriesList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTVSeriesList));
  });
}
