import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';
import '../../../dummy_data/dummy_object.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late PopularMoviesBloc mockBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    mockBloc = PopularMoviesBloc(getPopularMovies: mockGetPopularMovies);
  });

  test('initial state should be empty', () {
    expect(mockBloc.state, PopularMoviesEmpty());
  });

  blocTest<PopularMoviesBloc, PopularMoviesState>(
      'Should emit [Loading, Data] when fetch data is success',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return mockBloc;
      },
      act: (bloc) => bloc.add(OnPopularInitialization()),
      expect: () => [
            PopularMoviesLoading(),
            PopularMoviesHasData(testMovieList),
          ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      });

  blocTest<PopularMoviesBloc, PopularMoviesState>(
    'Should emit [Loading and Error] when fetch data is unsuccessful',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return mockBloc;
    },
    act: (bloc) => bloc.add(OnPopularInitialization()),
    expect: () => [
      PopularMoviesLoading(),
      const PopularMoviesError('Server Failure'),
    ],
    verify: (bloc) => verify(mockGetPopularMovies.execute()),
  );
}
