import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/domain/usecases/get_tv_series_watchlist_status.dart';

import '../../../helpers/test_helpers.mocks.dart';

void main() {
  late GetWatchListStatusTVSeries usecase;
  late MockTVSeriesRepository mockRepository;

  setUp(() {
    mockRepository = MockTVSeriesRepository();
    usecase = GetWatchListStatusTVSeries(mockRepository);
  });

  test('should get status of movies in detail movie from the repository when already added', () async {
    // arrange
    when(mockRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, true);
  });

  test('should get status of movies in detail movie from the repository when not added', () async {
    // arrange
    when(mockRepository.isAddedToWatchlist(1))
        .thenAnswer((_) async => false);
    // act
    final result = await usecase.execute(1);
    // assert
    expect(result, false);
  });
}
