import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_series_more_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_series_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum TVSeriesMoreType { popular, topRated, onTheAir, airingToday }
extension TVSeriesMoreTypeEx on TVSeriesMoreType {
  String name() {
    switch (this) {
      case TVSeriesMoreType.popular:
        return 'Popular';
      case TVSeriesMoreType.topRated:
        return 'Top Rated';
      case TVSeriesMoreType.airingToday:
        return 'Airing Today';
      default: 
        return 'On The Air';
    }
  }
}


class TVSeriesMorePage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series-list';

  final TVSeriesMoreType type;

  const TVSeriesMorePage({
    Key? key,
    required this.type,
  }) : super(key: key);

  @override
  State<TVSeriesMorePage> createState() => _TVSeriesMorePageState();
}

class _TVSeriesMorePageState extends State<TVSeriesMorePage> {

  @override
  void initState() {
    Future.microtask(() {
      Provider.of<TVSeriesMoreNotifier>(context, listen: false)
        .fetchTVSeries(widget.type);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.type.name()),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<TVSeriesMoreNotifier>(
            builder: (context, data, child) {
              if (data.state == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (data.state == RequestState.Loaded) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tvSeries = data.tvSeriesList[index];
                    return TVSeriesCard(tvSeries);
                  },
                  itemCount: data.tvSeriesList.length,
                );
              } else {
                return Center(
                  key: Key('error_message'),
                  child: Text(data.message),
                );
              }
            },
          ),
          ),
      ),
    );
  }
}