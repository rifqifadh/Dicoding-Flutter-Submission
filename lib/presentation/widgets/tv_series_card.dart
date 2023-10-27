import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:flutter/material.dart';

class TVSeriesCard extends StatelessWidget {
  final TVSeries tvSeries;

  TVSeriesCard(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    var nextAirDetailWidget = [
      Text(
        '${tvSeries.name ?? '-'}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: kHeading6,
      ),
      if (tvSeries.nextEpisodeToAir != null && !tvSeries.nextEpisodeToAir!.airDate.isEmpty)
        Row(
          children: [
            tvSeries.nextEpisodeToAir!.name.length > 24
                ? Container(
                    width: screenWidth * 0.3,
                    child: nextEpisodeWidget(tvSeries: tvSeries))
                : nextEpisodeWidget(tvSeries: tvSeries),
            Text(' | ${tvSeries.nextEpisodeToAir!.airDateFormatted()}',
                style: kBodyText, maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      SizedBox(height: 8),
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
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${tvSeries.posterPath}',
                  width: 80,
                  height: 80 * 1.5,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class nextEpisodeWidget extends StatelessWidget {
  const nextEpisodeWidget({
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
