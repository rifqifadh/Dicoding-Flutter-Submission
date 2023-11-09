import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tvseries/presentation/bloc/search_tv_series/search_tv_series_bloc.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helpers.mocks.dart';

void main() {
  late SearchTVSeriesBloc bloc;
  late MockSearchTVSeries mockSearchTVSeries;

  setUp(() {
    mockSearchTVSeries = MockSearchTVSeries();
    bloc = SearchTVSeriesBloc(searchTVSeries: mockSearchTVSeries);
  });

  blocTest<SearchTVSeriesBloc, SearchTVSeriesState>(
      'Shuld emit [Loading, Data] when fetch is success',
      build: () {
        when(mockSearchTVSeries.execute('spiderman'))
            .thenAnswer((_) async => Right(testTVSeriesList));
        return bloc;
      },
      act: (bloc) => bloc.add(const OnQueryChanged('spiderman')),
      wait: const Duration(milliseconds: 500),
      expect: () => [
            SearchTVSeriesLoading(),
            SearchTVSeriesLoaded(testTVSeriesList),
          ],
      verify: (bloc) {
        verify(mockSearchTVSeries.execute('spiderman'));
      });

  blocTest<SearchTVSeriesBloc, SearchTVSeriesState>(
    'Should emit [Loading, Error] when fetch is unsuccessful',
    build: () {
      when(mockSearchTVSeries.execute('spiderman'))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged('spiderman')),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTVSeriesLoading(),
      const SearchTVSeriesError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTVSeries.execute('spiderman'));
    }
    );
}
