import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movies_state.dart';
part 'top_rated_movies_event.dart';

class TopRatedMoviesBloc extends Bloc<TopRatedMoviesEvent, TopRatedMoviesState> {
  final GetTopRatedMovies getTopRatedMovies;
  
  TopRatedMoviesBloc({required this.getTopRatedMovies}) : super(TopRatedMoviesEmpty()) {
    on<OnTopRatedInitialization>((event, emit) async {
      emit(TopRatedMoviesLoading());
      final result = await getTopRatedMovies.execute();

      result.fold(
        (failure) {
          emit(TopRatedMoviesError(failure.message));
        },
        (data) {
          emit(TopRatedMoviesHasData(data));
        },
      );
    });
  }
}