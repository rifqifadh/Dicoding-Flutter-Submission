import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/genre.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final int id;
  const MovieDetailPage({super.key, required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<MovieDetailBloc>(context).add(
      OnLoadMovieDetail(widget.id),
    );
    BlocProvider.of<MovieDetailBloc>(context).add(
      OnLoadMovieRecommendation(widget.id),
    );
    BlocProvider.of<MovieDetailBloc>(context).add(
      OnLoadWatchlistStatus(widget.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
      builder: (context, state) {
        if (state.movieDetailState == RequestState.Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state.movieDetailState == RequestState.Loaded) {
          final movie = state.movie;
          return SafeArea(
            child: DetailContent(
              movie,
              state.movieRecommendations,
              state.isAddedToWatchlist,
            ),
          );
        } else {
          return Text(state.message);
        }
      },
    ));
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  final List<Movie> recommendations;
  final bool isAddedWatchlist;

  const DetailContent(this.movie, this.recommendations, this.isAddedWatchlist,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
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
                              movie.title,
                              style: kHeading5,
                            ),
                            BlocListener<MovieDetailBloc, MovieDetailState>(
                                listenWhen: (previous, current) {
                                  return current.watchlistMessage !=
                                      previous.watchlistMessage;
                                },
                                listener: (context, state) {
                                  if (state.watchlistMessage ==
                                          MovieDetailState
                                              .watchlistAddSuccessMessage ||
                                      state.watchlistMessage ==
                                          MovieDetailState
                                              .watchlistRemoveSuccessMessage) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content:
                                                Text(state.watchlistMessage)));
                                  } else {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content:
                                                Text(state.watchlistMessage),
                                          );
                                        });
                                  }
                                },
                                child: ElevatedButton(
                                  key: const Key('watchlist_button'),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        isAddedWatchlist
                                            ? const Icon(Icons.check)
                                            : const Icon(Icons.add),
                                        const Text('Watchlist'),
                                      ],
                                    ),
                                    onPressed: () async {
                                        BlocProvider.of<MovieDetailBloc>(
                                                context,
                                                listen: false)
                                            .add(OnButtonWatchlistTapped(movie));
                                    })),
                            Text(
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<MovieDetailBloc, MovieDetailState>(
                                builder: (context, state) {
                              if (state.movieRecommendationsState ==
                                  RequestState.Loading) {
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (state.movieRecommendationsState ==
                                  RequestState.Error) {
                                return Text(state.message);
                              } else if (state.movieRecommendationsState ==
                                  RequestState.Loaded) {
                                return SizedBox(
                                  height: 150,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      final movie = recommendations[index];
                                      return Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.pushReplacementNamed(
                                              context,
                                              MovieDetailPage.ROUTE_NAME,
                                              arguments: movie.id,
                                            );
                                          },
                                          child: ClipRRect(
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                              placeholder: (context, url) =>
                                                  const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    itemCount: recommendations.length,
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            })
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
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
        )
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

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
