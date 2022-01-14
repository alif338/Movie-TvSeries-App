import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movies/presentation/bloc/movie_list/now_playing_list/now_playing_list_bloc.dart';
import 'package:movies/presentation/bloc/movie_list/popular_list/popular_list_bloc.dart';
import 'package:movies/presentation/bloc/movie_list/top_rated_list/top_rated_list_bloc.dart';

import 'movie_list_bloc_test.mocks.dart';


@GenerateMocks([GetNowPlayingMovies, GetPopularMovies, GetTopRatedMovies])
void main() {
  late NowPlayingListBloc nowPlayingListBloc;
  late PopularListBloc popularListBloc;
  late TopRatedListBloc topRatedListBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    nowPlayingListBloc = NowPlayingListBloc(mockGetNowPlayingMovies);
    popularListBloc = PopularListBloc(mockGetPopularMovies);
    topRatedListBloc = TopRatedListBloc(mockGetTopRatedMovies);
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );
  final tMovieList = <Movie>[tMovie];

  group('now playing movies', () {
    test('initial state must be empty', () {
      expect(nowPlayingListBloc.state, isA<NowPlayingListEmpty>());
    });
    blocTest<NowPlayingListBloc, NowPlayingListState>(
      'initialstate should be empty', 
      build: () {
        return nowPlayingListBloc;
      },
      expect: () => []
    );

    blocTest<NowPlayingListBloc, NowPlayingListState>(
      'should get data from the usecase', 
      build: () {
        when(mockGetNowPlayingMovies.execute())
          .thenAnswer((realInvocation) async => Right(tMovieList));
        return nowPlayingListBloc;
      },
      act: (bloc) => bloc.add(OnFetchNowPlayingMovies()),
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      }
    );

    blocTest<NowPlayingListBloc, NowPlayingListState>(
      'should change movies when data is gotten successfully', 
        build: () {
        when(mockGetNowPlayingMovies.execute())
          .thenAnswer((realInvocation) async => Right(tMovieList));
        return nowPlayingListBloc;
      },
      act: (bloc) => bloc.add(OnFetchNowPlayingMovies()),
      expect: () => [
        NowPlayingListLoading(),
        NowPlayingListHasData(tMovieList)
      ]
    );

    blocTest<NowPlayingListBloc, NowPlayingListState>(
      'should return error when data is unsuccessful', 
      build: () {
        when(mockGetNowPlayingMovies.execute())
          .thenAnswer((realInvocation) async => Left(ServerFailure('Server Failure')));
        return nowPlayingListBloc;
      },
      act: (bloc) => bloc.add(OnFetchNowPlayingMovies()),
      expect: () => [
        NowPlayingListLoading(),
        NowPlayingListError('Server Failure')
      ]
    );
  });

  group('popular movies', () {

    test('initial state must be empty', () {
      expect(popularListBloc.state, isA<PopularListEmpty>());
    });

    blocTest<PopularListBloc, PopularListState>(
      'should get data from the usecase', 
      build: () {
        when(mockGetPopularMovies.execute())
          .thenAnswer((realInvocation) async => Right(tMovieList));
        return popularListBloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularList()),
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      }
    );

    blocTest<PopularListBloc, PopularListState>(
      'should change movies when data is gotten successfully', 
        build: () {
        when(mockGetPopularMovies.execute())
          .thenAnswer((realInvocation) async => Right(tMovieList));
        return popularListBloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularList()),
      expect: () => [
        PopularListLoading(),
        PopularListHasData(tMovieList)
      ]
    );

    blocTest<PopularListBloc, PopularListState>(
      'should return error when data is unsuccessful', 
      build: () {
        when(mockGetPopularMovies.execute())
          .thenAnswer((realInvocation) async => Left(ServerFailure('Server Failure')));
        return popularListBloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularList()),
      expect: () => [
        PopularListLoading(),
        PopularListError('Server Failure')
      ]
    );
  });

  group('top rated movies', () {

    test('initial state must be empty', () {
      expect(topRatedListBloc.state, isA<TopRatedListEmpty>());
    });

    blocTest<TopRatedListBloc, TopRatedListState>(
      'should get data from the usecase', 
      build: () {
        when(mockGetTopRatedMovies.execute())
          .thenAnswer((realInvocation) async => Right(tMovieList));
        return topRatedListBloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedList()),
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      }
    );

    blocTest<TopRatedListBloc, TopRatedListState>(
      'should change movies when data is gotten successfully', 
        build: () {
        when(mockGetTopRatedMovies.execute())
          .thenAnswer((realInvocation) async => Right(tMovieList));
        return topRatedListBloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedList()),
      expect: () => [
        TopRatedListLoading(),
        TopRatedListHasData(tMovieList)
      ]
    );

    blocTest<TopRatedListBloc, TopRatedListState>(
      'should return error when data is unsuccessful', 
      build: () {
        when(mockGetTopRatedMovies.execute())
          .thenAnswer((realInvocation) async => Left(ServerFailure('Server Failure')));
        return topRatedListBloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedList()),
      expect: () => [
        TopRatedListLoading(),
        TopRatedListError('Server Failure')
      ]
    );
  });
}
