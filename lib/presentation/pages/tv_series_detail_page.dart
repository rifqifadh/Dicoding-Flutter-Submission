import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/next_episode_to_air.dart';
import 'package:ditonton/domain/entities/season.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/presentation/provider/tv_series_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TVSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series-detail';
  final int id;

  const TVSeriesDetailPage({
    required this.id,
  });

  @override
  State<TVSeriesDetailPage> createState() => _TVSeriesDetailPageState();
}

class _TVSeriesDetailPageState extends State<TVSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<TVSeriesDetailNotifier>(context, listen: false)
          .onInitialization(widget.id);
      Provider.of<TVSeriesDetailNotifier>(context, listen: false)
          .loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer<TVSeriesDetailNotifier>(
      builder: (context, data, child) {
        final state = data.tvSeriesDetailState;
        if (state == RequestState.Loading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state == RequestState.Loaded) {
          return TVSeriesDetailContent(tvSeries: data.tvSeriesDetail, isAddedWatchlist: data.isAddedToWatchlist);
        } else {
          return Text(data.message);
        }
      },
    ));
  }
}

class TVSeriesDetailContent extends StatelessWidget {
  final TVSeriesDetail tvSeries;
  final bool isAddedWatchlist;

  const TVSeriesDetailContent(
      {required this.tvSeries, required this.isAddedWatchlist});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 40),
          child: DraggableScrollableSheet(
            maxChildSize: 0.9,
            minChildSize: 0.4,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
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
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text(
                                    '${tvSeries.voteAverage.toStringAsFixed(1)}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvSeries.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Latest Season',
                              style: kHeading6,
                            ),
                            SizedBox(height: 8),
                            SeasonDetailCard(
                              season: tvSeries.seasons.last.airDate.isEmpty
                                  ? tvSeries
                                      .seasons[tvSeries.seasons.length - 2]
                                  : tvSeries.seasons.last,
                              nextEpisodeToAir: tvSeries.nextEpisodeToAir,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            Consumer<TVSeriesDetailNotifier>(
                                builder: (context, data, child) {
                              if (data.tvSeriesRecommendationsState ==
                                  RequestState.Loading) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (data.tvSeriesRecommendationsState ==
                                  RequestState.Loaded) {
                                return RecommendationsTVSeriesList(
                                    data.tvSeriesRecommendations);
                              } else {
                                return Text('Failed');
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
                icon: Icon(Icons.arrow_back),
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
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  Widget addWishlist(BuildContext context, TVSeriesDetail tvSeries) {
    return ElevatedButton(
      onPressed: () async {
        if (!isAddedWatchlist) {
          await Provider.of<TVSeriesDetailNotifier>(context, listen: false)
              .addWatchlist(tvSeries);
        } else {
          await Provider.of<TVSeriesDetailNotifier>(context, listen: false)
              .removeFromWatchlist(tvSeries);
        }

        final message =
            Provider.of<TVSeriesDetailNotifier>(context, listen: false)
                .watchlistMessage;

        if (message == TVSeriesDetailNotifier.watchlistAddSuccessMessage ||
            message == TVSeriesDetailNotifier.watchlistRemoveSuccessMessage) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(message)));
        }
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          isAddedWatchlist ? Icon(Icons.check) : Icon(Icons.add),
          Text('Watchlist'),
        ],
      ),
    );
  }
}

class SeasonDetailCard extends StatelessWidget {
  final Season season;
  final NextEpisodeToAir? nextEpisodeToAir;

  SeasonDetailCard({required this.season, required this.nextEpisodeToAir});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: season.posterPath.isEmpty
                  ? SizedBox(
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
                        return Center(
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
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${season.name}', style: kSubtitleBold),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      color: kMikadoYellow,
                      size: 16,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Text(
                      '${season.voteAverage.toStringAsFixed(1)}',
                      style: kBodyText,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Text(
                      season.airDateYear(),
                      style: kBodyText,
                    ),
                    Padding(
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
                          ? Container(
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

  const RecommendationsTVSeriesList(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
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
                            borderRadius: BorderRadius.all(
                              Radius.circular(16),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: '$BASE_IMAGE_URL${tvSerie.posterPath}',
                              placeholder: (context, url) => Center(
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
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
