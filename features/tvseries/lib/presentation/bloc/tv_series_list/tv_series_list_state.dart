part of 'tv_series_list_bloc.dart';

class TVSeriesListState extends Equatable {
  final List<TVSeries> airingTodayTVSeries;
  final List<TVSeries> topRatedTVSeries;
  final List<TVSeries>  onTheAirTVSeries;
  final List<TVSeries>  popularTVSeries;

  final RequestState airingTodayTVSeriesState;
  final RequestState topRatedTVSeriesState;
  final RequestState  onTheAirTVSeriesState;
  final RequestState  popularTVSeriesState;

  final String errorMessage;

  const TVSeriesListState({
    required this.airingTodayTVSeries,
    required this.topRatedTVSeries,
    required this.onTheAirTVSeries,
    required this.popularTVSeries,
    required this.airingTodayTVSeriesState,
    required this.topRatedTVSeriesState,
    required this.onTheAirTVSeriesState,
    required this.popularTVSeriesState,
    required this.errorMessage,
  });

  factory TVSeriesListState.initial() => const TVSeriesListState(
    airingTodayTVSeries: [],
    topRatedTVSeries: [],
    onTheAirTVSeries: [],
    popularTVSeries: [],
    airingTodayTVSeriesState: RequestState.Empty,
    topRatedTVSeriesState: RequestState.Empty,
    onTheAirTVSeriesState: RequestState.Empty,
    popularTVSeriesState: RequestState.Empty,
    errorMessage: '',
  );


  @override
  List<Object?> get  props => [
    airingTodayTVSeries,
    topRatedTVSeries,
    onTheAirTVSeries,
    popularTVSeries,
    airingTodayTVSeriesState,
    topRatedTVSeriesState,
    onTheAirTVSeriesState,
    popularTVSeriesState,
    errorMessage,
  ];


  TVSeriesListState copyWith({
    List<TVSeries>? airingTodayTVSeries,
    List<TVSeries>? topRatedTVSeries,
    List<TVSeries>? onTheAirTVSeries,
    List<TVSeries>? popularTVSeries,
    RequestState? airingTodayTVSeriesState,
    RequestState? topRatedTVSeriesState,
    RequestState? onTheAirTVSeriesState,
    RequestState? popularTVSeriesState,
    String? errorMessage,
  }) {
    return TVSeriesListState(
      airingTodayTVSeries: airingTodayTVSeries ?? this.airingTodayTVSeries,
      topRatedTVSeries: topRatedTVSeries ?? this.topRatedTVSeries,
      onTheAirTVSeries: onTheAirTVSeries ?? this.onTheAirTVSeries,
      popularTVSeries: popularTVSeries ?? this.popularTVSeries,
      airingTodayTVSeriesState: airingTodayTVSeriesState ?? this.airingTodayTVSeriesState,
      topRatedTVSeriesState: topRatedTVSeriesState ?? this.topRatedTVSeriesState,
      onTheAirTVSeriesState: onTheAirTVSeriesState ?? this.onTheAirTVSeriesState,
      popularTVSeriesState: popularTVSeriesState ?? this.popularTVSeriesState,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
