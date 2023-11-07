// Mocks generated by Mockito 5.4.2 from annotations
// in movies/test/presentation/bloc/movie_list/movie_list_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:flutter_bloc/flutter_bloc.dart' as _i7;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movies/domain/usecases/get_now_playing_movies.dart' as _i2;
import 'package:movies/domain/usecases/get_popular_movies.dart' as _i3;
import 'package:movies/domain/usecases/get_top_rated_movies.dart' as _i4;
import 'package:movies/presentation/bloc/movie_list/movie_list_bloc.dart'
    as _i5;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeGetNowPlayingMovies_0 extends _i1.SmartFake
    implements _i2.GetNowPlayingMovies {
  _FakeGetNowPlayingMovies_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetPopularMovies_1 extends _i1.SmartFake
    implements _i3.GetPopularMovies {
  _FakeGetPopularMovies_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeGetTopRatedMovies_2 extends _i1.SmartFake
    implements _i4.GetTopRatedMovies {
  _FakeGetTopRatedMovies_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeMovieListState_3 extends _i1.SmartFake
    implements _i5.MovieListState {
  _FakeMovieListState_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MovieListBloc].
///
/// See the documentation for Mockito's code generation for more information.
class MockMovieListBloc extends _i1.Mock implements _i5.MovieListBloc {
  MockMovieListBloc() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.GetNowPlayingMovies get getNowPlayingMovies => (super.noSuchMethod(
        Invocation.getter(#getNowPlayingMovies),
        returnValue: _FakeGetNowPlayingMovies_0(
          this,
          Invocation.getter(#getNowPlayingMovies),
        ),
      ) as _i2.GetNowPlayingMovies);

  @override
  _i3.GetPopularMovies get getPopularMovies => (super.noSuchMethod(
        Invocation.getter(#getPopularMovies),
        returnValue: _FakeGetPopularMovies_1(
          this,
          Invocation.getter(#getPopularMovies),
        ),
      ) as _i3.GetPopularMovies);

  @override
  _i4.GetTopRatedMovies get getTopRatedMovies => (super.noSuchMethod(
        Invocation.getter(#getTopRatedMovies),
        returnValue: _FakeGetTopRatedMovies_2(
          this,
          Invocation.getter(#getTopRatedMovies),
        ),
      ) as _i4.GetTopRatedMovies);

  @override
  _i5.MovieListState get state => (super.noSuchMethod(
        Invocation.getter(#state),
        returnValue: _FakeMovieListState_3(
          this,
          Invocation.getter(#state),
        ),
      ) as _i5.MovieListState);

  @override
  _i6.Stream<_i5.MovieListState> get stream => (super.noSuchMethod(
        Invocation.getter(#stream),
        returnValue: _i6.Stream<_i5.MovieListState>.empty(),
      ) as _i6.Stream<_i5.MovieListState>);

  @override
  bool get isClosed => (super.noSuchMethod(
        Invocation.getter(#isClosed),
        returnValue: false,
      ) as bool);

  @override
  void add(_i5.MovieListEvent? event) => super.noSuchMethod(
        Invocation.method(
          #add,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onEvent(_i5.MovieListEvent? event) => super.noSuchMethod(
        Invocation.method(
          #onEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void emit(_i5.MovieListState? state) => super.noSuchMethod(
        Invocation.method(
          #emit,
          [state],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void on<E extends _i5.MovieListEvent>(
    _i7.EventHandler<E, _i5.MovieListState>? handler, {
    _i7.EventTransformer<E>? transformer,
  }) =>
      super.noSuchMethod(
        Invocation.method(
          #on,
          [handler],
          {#transformer: transformer},
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onTransition(
          _i7.Transition<_i5.MovieListEvent, _i5.MovieListState>? transition) =>
      super.noSuchMethod(
        Invocation.method(
          #onTransition,
          [transition],
        ),
        returnValueForMissingStub: null,
      );

  @override
  _i6.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i6.Future<void>.value(),
        returnValueForMissingStub: _i6.Future<void>.value(),
      ) as _i6.Future<void>);

  @override
  void onChange(_i7.Change<_i5.MovieListState>? change) => super.noSuchMethod(
        Invocation.method(
          #onChange,
          [change],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void addError(
    Object? error, [
    StackTrace? stackTrace,
  ]) =>
      super.noSuchMethod(
        Invocation.method(
          #addError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );

  @override
  void onError(
    Object? error,
    StackTrace? stackTrace,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #onError,
          [
            error,
            stackTrace,
          ],
        ),
        returnValueForMissingStub: null,
      );
}