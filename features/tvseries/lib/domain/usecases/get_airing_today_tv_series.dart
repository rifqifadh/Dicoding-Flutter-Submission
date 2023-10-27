

import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import 'package:tvseries/tvseries.dart';

class GetAirTodayTVSeries {
  final TVSeriesRepository repository;

  GetAirTodayTVSeries(this.repository);

  Future<Either<Failure, List<TVSeries>>> execute() {
    return repository.getAiringTodayTVSeries();
  }
}