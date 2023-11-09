import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tvseries/presentation/bloc/tv_series_more/tv_series_more_bloc.dart';
import 'package:tvseries/presentation/widgets/tv_series_card.dart';

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
    BlocProvider.of<TVSeriesMoreBloc>(context).add(OnInitialFetchTVSeriesMore(widget.type));
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
          child: 
          BlocBuilder<TVSeriesMoreBloc, TVSeriesMoreState>(
            builder: (context, state) {
              if (state is TVSeriesMoreLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is TVSeriesMoreLoaded) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tvSeries = state.tvSeries[index];
                    return TVSeriesCard(tvSeries);
                  },
                  itemCount: state.tvSeries.length,
                );
              } else if (state is TVSeriesMoreError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Column(
                children: <Widget>[
                  Expanded(
                    child: Container(),
                  ),
                ],
              );
            }
            },
          ),
          ),
      ),
    );
  }
}