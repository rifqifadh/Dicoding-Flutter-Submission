import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/presentation/bloc/tv_series_list/tv_series_list_bloc.dart';
import 'package:tvseries/tvseries.dart';

class TVSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series';
  const TVSeriesPage({Key? key}) : super(key: key);

  @override
  State<TVSeriesPage> createState() => _TVSeriesPageState();
}

class _TVSeriesPageState extends State<TVSeriesPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TVSeriesListBloc>(context).add(FetchOnTheAirTVSeries());
    BlocProvider.of<TVSeriesListBloc>(context).add(FetchPopularTVSeries());
    BlocProvider.of<TVSeriesListBloc>(context).add(FetchAiringTodayTVSeries());
    BlocProvider.of<TVSeriesListBloc>(context).add(FetchTopRatedTVSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchTVSeriesPage.ROUTE_NAME);
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'On The Air',
                style: kHeading6,
              ),
              BlocBuilder<TVSeriesListBloc, TVSeriesListState>(
                builder: (context, state) {
                if (state.onTheAirTVSeriesState == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.onTheAirTVSeriesState == RequestState.Loaded) {
                  return TVSeriesList(state.onTheAirTVSeries);
                } else {
                  return const Text("failed");
                }
              }),
              _buildSubHeading(
                  onTap: () {
                    Navigator.pushNamed(
                              context, TVSeriesMorePage.ROUTE_NAME,
                              arguments: TVSeriesMoreType.topRated);
                  },
                  title: 'Top Rated'),
              BlocBuilder<TVSeriesListBloc, TVSeriesListState>(
                builder: (context, state) {
                if (state.topRatedTVSeriesState == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.topRatedTVSeriesState == RequestState.Loaded) {
                  return TVSeriesList(state.topRatedTVSeries);
                } else {
                  return const Text("failed");
                }
              }),
              _buildSubHeading(
                  onTap: () {
                    Navigator.pushNamed(
                              context, TVSeriesMorePage.ROUTE_NAME,
                              arguments: TVSeriesMoreType.popular);
                  },
                  title: 'Popular'),
              BlocBuilder<TVSeriesListBloc, TVSeriesListState>(
                builder: (context, state) {
                if (state.popularTVSeriesState == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.popularTVSeriesState == RequestState.Loaded) {
                  return TVSeriesList(state.popularTVSeries);
                } else {
                  return const Text("failed");
                }
              }),
              _buildSubHeading(
                  onTap: () {
                    Navigator.pushNamed(
                              context, TVSeriesMorePage.ROUTE_NAME,
                              arguments: TVSeriesMoreType.airingToday);
                  },
                  title: 'Airing Today'),
              BlocBuilder<TVSeriesListBloc, TVSeriesListState>(
                builder: (context, state) {
                if (state.airingTodayTVSeriesState == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state.airingTodayTVSeriesState == RequestState.Loaded) {
                  return TVSeriesList(state.airingTodayTVSeries);
                } else {
                  return const Text("failed");
                }
              }),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class TVSeriesList extends StatelessWidget {
  final List<TVSeries> tvSeries;

  const TVSeriesList(this.tvSeries, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSerie = tvSeries[index];
          return tvSerie.posterPath == null
              ? null
              : tvSerie.posterPath == null
                  ? null
                  : Container(
                      padding: const EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, TVSeriesDetailPage.ROUTE_NAME,
                              arguments: tvSerie);
                        },
                        child: ClipRRect(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(16),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: '$BASE_IMAGE_URL${tvSerie.posterPath}',
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
