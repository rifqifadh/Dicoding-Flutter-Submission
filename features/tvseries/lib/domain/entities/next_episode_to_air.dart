import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class NextEpisodeToAir extends Equatable {
  final int id;
  String name;
  final String airDate;
  final int seasonNumber;
  final int episodeNumber;

  String airDateFormatted() {
    if (airDate.isEmpty) {
      return '-';
    }
    final date = DateTime.parse(airDate);
    return DateFormat('dd MMM yyyy').format(date);
  }

  NextEpisodeToAir({
    required this.id,
    required this.name,
    required this.airDate,
    required this.seasonNumber,
    required this.episodeNumber
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      airDate,
      seasonNumber,
      episodeNumber,
    ];
  }
}
