import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tvseries/tvseries.dart';

class TVSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series-detail';
  final int id;

  const TVSeriesDetailPage({
    super.key,
    required this.id,
  });

  @override
  State<TVSeriesDetailPage> createState() => _TVSeriesDetailPageState();
}

class _TVSeriesDetailPageState extends State<TVSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TVSeriesDetailBloc>(context)
        .add(OnLoadTVSeriesDetail(widget.id));
    BlocProvider.of<TVSeriesDetailBloc>(context)
        .add(OnLoadTVSeriesRecommendation(widget.id));
    BlocProvider.of<TVSeriesDetailBloc>(context)
        .add(OnLoadWatchlistStatus(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<TVSeriesDetailBloc, TVSeriesDetailState>(
      builder: (context, state) {
        if (state.tvSeriesDetailState == RequestState.Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.tvSeriesDetailState == RequestState.Loaded) {
          return TVSeriesDetailContent(
              tvSeries: state.tvSeries,
              isAddedWatchlist: state.isAddedToWatchlist);
        } else {
          return Text(state.message);
        }
      },
    ));
  }
}

class TVSeriesDetailContent extends StatelessWidget {
  final TVSeriesDetail tvSeries;
  final bool isAddedWatchlist;

  const TVSeriesDetailContent(
      {super.key, required this.tvSeries, required this.isAddedWatchlist});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 40),
          child: DraggableScrollableSheet(
            maxChildSize: 0.9,
            minChildSize: 0.4,
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                    color: kRichBlack,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(16))),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvSeries.name,
                              style: kHeading5Bold,
                            ),
                            addWishlist(context, tvSeries),
                            Text(
                              _showGenres(tvSeries.genres),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeries.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text(tvSeries.voteAverage.toStringAsFixed(1))
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvSeries.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Latest Season',
                              style: kHeading6,
                            ),
                            const SizedBox(height: 8),
                            if (tvSeries.seasons.isEmpty &&
                                tvSeries.nextEpisodeToAir == null) ...[
                              const Text('No Season')
                            ] else ...[
                              SeasonDetailCard(
                                season: tvSeries.seasons.last,
                                nextEpisodeToAir: tvSeries.nextEpisodeToAir,
                              ),
                            ],
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<TVSeriesDetailBloc,
                                TVSeriesDetailState>(builder: (context, state) {
                              if (state.tvSeriesRecommendationsState ==
                                  RequestState.Loading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state.tvSeriesRecommendationsState ==
                                  RequestState.Loaded) {
                                return RecommendationsTVSeriesList(
                                    state.tvSeriesRecommendations);
                              } else {
                                return const Text('Failed');
                              }
                            })
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SafeArea(
            child: CircleAvatar(
              backgroundColor: kRichBlack,
              foregroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  Widget addWishlist(BuildContext context, TVSeriesDetail tvSeries) {
    return BlocListener<TVSeriesDetailBloc, TVSeriesDetailState>(
      listenWhen: (previous, current) {
        return previous.watchlistMessage != current.watchlistMessage;
      },
      listener: (context, state) {
        if (state.watchlistMessage ==
                TVSeriesDetailState.watchlistAddSuccessMessage ||
            state.watchlistMessage ==
                TVSeriesDetailState.watchlistRemoveSuccessMessage) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.watchlistMessage)));
        } else {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Error'),
                  content: Text(state.watchlistMessage),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('OK'))
                  ],
                );
              });
        }
      },
      child: ElevatedButton(
        onPressed: () async {
          BlocProvider.of<TVSeriesDetailBloc>(context)
              .add(OnButtonWatchlistTapped(tvSeries));
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            isAddedWatchlist ? const Icon(Icons.check) : const Icon(Icons.add),
            const Text('Watchlist'),
          ],
        ),
      ),
    );
  }
}

class SeasonDetailCard extends StatelessWidget {
  final Season season;
  final NextEpisodeToAir? nextEpisodeToAir;

  const SeasonDetailCard(
      {super.key, required this.season, required this.nextEpisodeToAir});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: season.posterPath.isEmpty
                  ? const SizedBox(
                      width: 80,
                      height: 80 * 1.5,
                      child: Center(
                        child: Text('No Image'),
                      ),
                    )
                  : CachedNetworkImage(
                      width: 80,
                      height: 80 * 1.5,
                      placeholder: (context, url) {
                        return const Center(
                          child: SizedBox(
                            width: 80,
                            height: 80 * 1.5,
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          ),
                        );
                      },
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500${season.posterPath}',
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(season.name, style: kSubtitleBold),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.star,
                      color: kMikadoYellow,
                      size: 16,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text(
                      season.voteAverage.toStringAsFixed(1),
                      style: kBodyText,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Text(
                      season.airDateYear(),
                      style: kBodyText,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 6),
                      child: Icon(
                        Icons.circle,
                        size: 6,
                      ),
                    ),
                    Text(
                      '${season.episodeCount} Episode',
                      style: kBodyText,
                    ),
                  ],
                ),
                Text(
                  season.overview.isEmpty ? '-' : season.overview,
                  style: kBodyText,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                if (nextEpisodeToAir != null)
                  Row(
                    children: [
                      nextEpisodeToAir!.name.length > 16
                          ? SizedBox(
                              width: screenWidth / 3,
                              child: Text(nextEpisodeToAir!.name,
                                  style: kBodyTextBold,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis))
                          : Text(nextEpisodeToAir!.name,
                              style: kBodyTextBold,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                      Text(
                        ' | ${nextEpisodeToAir!.airDateFormatted()}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: kBodyTextBold,
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RecommendationsTVSeriesList extends StatelessWidget {
  final List<TVSeries> tvSeries;

  const RecommendationsTVSeriesList(this.tvSeries, {super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SizedBox(
        height: 170,
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
                            Navigator.pushReplacementNamed(
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
      ),
    );
  }
}
