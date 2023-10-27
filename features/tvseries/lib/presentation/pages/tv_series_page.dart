import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    Future.microtask(
        () => Provider.of<TVSeriesListNotifier>(context, listen: false)
          ..fetchAirTodayTVSeries()
          ..fetchOnTheAirTVSeries()
          ..fetchPopularTVSeries()
          ..fetchTopRatedTVSeries());
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
              Consumer<TVSeriesListNotifier>(builder: (context, data, child) {
                final state = data.onTheAirTVSeriesState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TVSeriesList(data.onTheAirTVSeries);
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
              Consumer<TVSeriesListNotifier>(builder: (context, data, child) {
                final state = data.topRatedTVSeriesState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TVSeriesList(data.topRatedTVSeries);
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
              Consumer<TVSeriesListNotifier>(builder: (context, data, child) {
                final state = data.popularTVSeriesState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TVSeriesList(data.popularTVSeries);
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
              Consumer<TVSeriesListNotifier>(builder: (context, data, child) {
                final state = data.airingTodayTVSeriesState;
                if (state == RequestState.Loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TVSeriesList(data.airingTodayTVSeries);
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