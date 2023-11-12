

import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/watchlist.dart';
import 'package:ditonton/domain/usecases/get_watchlist.dart';
import 'package:ditonton/presentation/bloc/watchlist_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';

import 'watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlist])
void main() {
  late WatchlistBloc watchlistBloc;
  late MockGetWatchlist getWatchlist;

  setUp(() {
    getWatchlist = MockGetWatchlist();
    watchlistBloc = WatchlistBloc(getWatchlist: getWatchlist);
  });

  final testWatchlist = Watchlist(
    id: 1,
    title: 'title',
    posterPath: 'posterPath',
    overview: 'overview',
    nextEpisode: 2,
    nextEpisodeName: 'nextEpisodeName',
    seasonNumber: 1,
    nextEpisodeToAir: '2020-01-01',
    type: WatchlistType.tvSeries,
  );

  blocTest<WatchlistBloc, WatchlistState>(
    'Should emit [Loading, Loaded] when fetch watchlist success',
    build: () {
      when(getWatchlist.execute())
      .thenAnswer((_) async => Right([testWatchlist]));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(OnLoadWatchlist()),
    expect: () => [
        WatchlistState.initial().copyWith(
          state: RequestState.Loading,
        ),
        WatchlistState.initial().copyWith(
          state: RequestState.Loaded,
          watchlist: [testWatchlist],
        ),
      ],
    verify: (bloc) => verify(getWatchlist.execute())
  );

  blocTest<WatchlistBloc, WatchlistState>(
    'Should emit [Loading, Error] when fetch watchlist error',
    build: () {
      when(getWatchlist.execute())
      .thenAnswer((_) async => Left(DatabaseFailure('Database Exception')));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(OnLoadWatchlist()),
    expect: () => [
        WatchlistState.initial().copyWith(
          state: RequestState.Loading,
        ),
        WatchlistState.initial().copyWith(
          state: RequestState.Error,
          message: 'Database Exception',
        ),
      ],
    verify: (bloc) => verify(getWatchlist.execute())
  );
}