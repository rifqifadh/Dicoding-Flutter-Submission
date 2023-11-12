import 'package:ditonton/data/datasources/watchlist_local_data_source.dart';
import 'package:ditonton/data/repositories/watchlist_repository_impl.dart';
import 'package:ditonton/domain/repositories/watchlist_repository.dart';
import 'package:ditonton/domain/usecases/get_watchlist.dart';
import 'package:ditonton/presentation/bloc/watchlist_bloc.dart';
import 'package:core/networking/ssl_pinning.dart';
import 'package:http/io_client.dart';
import 'package:movies/movies.dart';
import 'package:core/core.dart';
import 'package:get_it/get_it.dart';
import 'package:tvseries/tvseries.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // provider
  locator.registerFactory(() => WatchlistBloc(getWatchlist: locator()));

  locator.registerFactory(() => SearchBloc(locator()));

  locator.registerFactory(() => MovieDetailBloc(
        getMovieDetail: locator(),
        getMovieRecommendations: locator(),
        getWatchListStatus: locator(),
        saveWatchlist: locator(),
        removeWatchlist: locator(),
      ));

  locator
      .registerFactory(() => TopRatedMoviesBloc(getTopRatedMovies: locator()));
  locator.registerFactory(() => PopularMoviesBloc(getPopularMovies: locator()));
  locator.registerFactory(() => MovieListBloc(
        getNowPlayingMovies: locator(),
        getPopularMovies: locator(),
        getTopRatedMovies: locator(),
      ));

  locator.registerFactory(() => SearchTVSeriesBloc(searchTVSeries: locator()));
  locator.registerFactory(() => TVSeriesMoreBloc(
        getTopRatedTVSeries: locator(),
        getAirTodayTVSeries: locator(),
        getPopularTVSeries: locator(),
      ));
  locator.registerFactory(() => TVSeriesDetailBloc(
        getTVSeriesDetail: locator(),
        getTVSeriesRecommendations: locator(),
        getWatchListStatus: locator(),
        saveWatchlist: locator(),
        removeWatchlist: locator(),
      ));
  locator.registerFactory(() => TVSeriesListBloc(
        getAirTodayTVSeries: locator(),
        getOnTheAirTVSeries: locator(),
        getPopularTVSeries: locator(),
        getTopRatedTVSeries: locator(),
      ));

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetAirTodayTVSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTVSeries(locator()));
  locator.registerLazySingleton(() => GetOnTheAirTVSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTVSeries(locator()));
  locator.registerLazySingleton(() => GetTVSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTVSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => GetWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistTVSeries(locator()));
  locator.registerLazySingleton(() => SaveWatchlistTVSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusTVSeries(locator()));
  locator.registerLazySingleton(() => SearchTVSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TVSeriesRepository>(
    () => TVSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<WatchlistRepository>(
      () => WatchlistRepositoryImpl(localDataSource: locator()));

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<WatchlistLocalDataSource>(
      () => WatchlistLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TVSeriesRemoteDataSource>(
      () => TVSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVSeriesLocalDataSource>(
      () => TVSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  // locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton<Networking>(() => NetworkingImpl(client: locator()));
  IOClient ioClient = await SslPinning.ioClient;
  locator.registerLazySingleton<IOClient>(() => ioClient);
  // locator.registerSingleton<SSLPinningHelperImpl>(SSLPinningHelperImpl());

  // GetIt.I.registerSingletonAsync<Networking>(() async {
  //   final sslHelper = GetIt.I<SSLPinningHelperImpl>();
  //   final client = await sslHelper.getSSLPinningClient();
  //   return NetworkingImpl(client: client);
  // });
}
