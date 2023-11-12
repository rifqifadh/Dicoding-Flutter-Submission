import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:tvseries/tvseries.dart';

class TVSeriesCard extends StatelessWidget {
  final TVSeries tvSeries;

  const TVSeriesCard(this.tvSeries, {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    var nextAirDetailWidget = [
      Text(
        tvSeries.name ?? '-',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: kHeading6,
      ),
      if (tvSeries.nextEpisodeToAir != null && tvSeries.nextEpisodeToAir!.airDate.isNotEmpty)
        Row(
          children: [
            tvSeries.nextEpisodeToAir!.name.length > 24
                ? SizedBox(
                    width: screenWidth * 0.3,
                    child: NextEpisodeWidget(tvSeries: tvSeries))
                : NextEpisodeWidget(tvSeries: tvSeries),
            Text(' | ${tvSeries.nextEpisodeToAir!.airDateFormatted()}',
                style: kBodyText, maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      const SizedBox(height: 8),
      Text(
        tvSeries.overview.isEmpty ? '-' : tvSeries.overview,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            TVSeriesDetailPage.ROUTE_NAME,
            arguments: tvSeries,
          );
        },
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            Card(
              child: Container(
                width: screenWidth,
                margin: const EdgeInsets.only(
                  left: 16 + 80 + 16,
                  bottom: 8,
                  right: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: nextAirDetailWidget,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 16,
                bottom: 16,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvSeries.posterPath}',
                  width: 80,
                  height: 80 * 1.5,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NextEpisodeWidget extends StatelessWidget {
  const NextEpisodeWidget({
    Key? key,
    required this.tvSeries,
  }) : super(key: key);

  final TVSeries tvSeries;

  @override
  Widget build(BuildContext context) {
    return Text(
        'S${tvSeries.nextEpisodeToAir!.seasonNumber} x ${tvSeries.nextEpisodeToAir!.name}',
        style: kBodyText,
        maxLines: 1,
        overflow: TextOverflow.ellipsis);
  }
}
