import 'package:core/core.dart';
import 'package:ditonton/common/utils.dart';
import 'package:about/about.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:ditonton/presentation/provider/watchlist_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tvseries/tvseries.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TVSeriesListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TVSeriesDetailNotifier>(),
        ),
        BlocProvider(create: (_) => di.locator<SearchBloc>()),
        BlocProvider(create: (_) => di.locator<MovieDetailBloc>()),
        BlocProvider(create: (_) => di.locator<TopRatedMoviesBloc>()),
        BlocProvider(create: (_) => di.locator<PopularMoviesBloc>()),
        BlocProvider(create:(context) => di.locator<MovieListBloc>()),
        BlocProvider(create:(context) => di.locator<SearchTVSeriesBloc>()),
        BlocProvider(create:(context) => di.locator<SearchTVSeriesBloc>()),
        BlocProvider(create:(context) => di.locator<TVSeriesMoreBloc>()),
        BlocProvider(create:(context) => di.locator<TVSeriesDetailBloc>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TVSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(
                builder: (_) => TVSeriesPage(),
              );
              case TVSeriesDetailPage.ROUTE_NAME:
              final serie = settings.arguments as TVSeries;
              return MaterialPageRoute(
                builder: (_) => TVSeriesDetailPage(id: serie.id ?? 0),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case SearchTVSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchTVSeriesPage());
            case TVSeriesMorePage.ROUTE_NAME:
              final type = settings.arguments as TVSeriesMoreType;
              return CupertinoPageRoute(builder: (_) => TVSeriesMorePage(type: type,));
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
