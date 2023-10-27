import 'package:ditonton/data/models/tv_series_model.dart';
import 'package:equatable/equatable.dart';

class TVSeriesResponse extends Equatable {
  final List<TVSeriesModel> results;

  TVSeriesResponse({required this.results});

  factory TVSeriesResponse.fromJson(Map<String, dynamic> json) {
    return TVSeriesResponse(
        results: List<TVSeriesModel>.from((json["results"] as List)
            .map((x) => TVSeriesModel.fromJson(x)))
            // .where((element) => element.posterPath != null)),
      );
  }
  
  @override
  List<Object> get props => [results];
}
