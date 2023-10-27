import 'package:tvseries/domain/repositories/tv_series_repository.dart';

class GetWatchListStatusTVSeries {
  final TVSeriesRepository repository;

  GetWatchListStatusTVSeries(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
