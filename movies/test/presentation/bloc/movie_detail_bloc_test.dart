import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/movies.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_recommendations/movie_recommendations_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail/watchlist_status/watchlist_status_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MovieRecommendationsBloc movieRecommendationsBloc;
  late WatchlistStatusBloc watchlistStatusBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieDetailBloc = MovieDetailBloc(getMovieDetail: mockGetMovieDetail,);
    movieRecommendationsBloc =
        MovieRecommendationsBloc(mockGetMovieRecommendations);
    watchlistStatusBloc = WatchlistStatusBloc(
        getWatchlistStatus: mockGetWatchlistStatus,
        saveWatchlist: mockSaveWatchlist,
        removeWatchlist: mockRemoveWatchlist);
  });

  final tId = 1;

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
  final tMovies = <Movie>[tMovie];

  group('get movie detail and/or movie recommendations:', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
        'should get data of movie detail from the usecase', build: () {
      when(mockGetMovieDetail.execute(tId))
          .thenAnswer((_) async => Right(testMovieDetail));
      return movieDetailBloc;
    }, act: (bloc) {
      bloc.add(OnFetchMovieDetail(tId));
    }, verify: (bloc) {
      verify(mockGetMovieDetail.execute(tId));
    });

    blocTest<MovieDetailBloc, MovieDetailState>(
        'should emit [Loading, HasData] when usecase movie detail called successfully',
        build: () {
          when(mockGetMovieDetail.execute(tId))
              .thenAnswer((_) async => Right(testMovieDetail));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieDetail(tId)),
        expect: () =>
            [MovieDetailLoading(), MovieDetailHasData(testMovieDetail)],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tId));
        });

    blocTest<MovieDetailBloc, MovieDetailState>(
        'should emit [Loading, Error] when fetch movie detail is done unsuccessfully',
        build: () {
          when(mockGetMovieDetail.execute(tId)).thenAnswer(
              (realInvocation) async => Left(ServerFailure('Bad Request')));
          return movieDetailBloc;
        },
        act: (bloc) => bloc.add(OnFetchMovieDetail(tId)),
        expect: () => [MovieDetailLoading(), MovieDetailError('Bad Request')],
        verify: (bloc) {
          verify(mockGetMovieDetail.execute(tId));
        });

    blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
        'should emit [Loading, HasData] on usecase movies recommendations after fetch successfully',
        build: () {
          when(mockGetMovieRecommendations.execute(tId))
              .thenAnswer((_) async => Right(tMovies));
          return movieRecommendationsBloc;
        },
        act: (bloc) {
          bloc.add(OnFetchMovieRecommendations(tId));
        },
        expect: () => [
              MovieRecommendationsLoading(),
              MovieRecommendatinsHasData(tMovies)
            ],
        verify: (mock) {
          verify(mockGetMovieRecommendations.execute(tId));
        });

    blocTest<MovieRecommendationsBloc, MovieRecommendationsState>(
        'should emit [Loading, Error] when fetching movies recommendation is unsuccessfully',
        build: () {
          when(mockGetMovieRecommendations.execute(tId)).thenAnswer(
              (realInvocation) async => Left(ServerFailure('Error')));
          return movieRecommendationsBloc;
        },
        act: (bloc) {
          bloc.add(OnFetchMovieRecommendations(tId));
        },
        expect: () => [
              MovieRecommendationsLoading(),
              MovieRecommendationsError('Error')
            ],
        verify: (bloc) {
          verify(mockGetMovieRecommendations.execute(tId));
        });
  });

  group('Watchlist Status', () {
    blocTest<WatchlistStatusBloc, WatchlistStatusState>(
        'should get the watchlist status',
        build: () {
          when(mockGetWatchlistStatus.execute(1))
              .thenAnswer((realInvocation) async => false);
          return watchlistStatusBloc;
        },
        act: (bloc) => bloc.add(OnLoadWatclistStatus(1)),
        expect: () => [
          WatchlistStatusState(false, '')
        ],
        verify: (bloc) {
          verify(mockGetWatchlistStatus.execute(tId));
        });

    blocTest<WatchlistStatusBloc, WatchlistStatusState>(
        'should execute save watchlist when function called', build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((realInvocation) async => Right('success'));
      when(mockGetWatchlistStatus.execute(tId))
          .thenAnswer((realInvocation) async => true);
      return watchlistStatusBloc;
    }, act: (bloc) {
      bloc.add(OnAddToWatchlist(testMovieDetail));
      bloc.add(OnLoadWatclistStatus(tId));
    }, verify: (bloc) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
      verify(mockGetWatchlistStatus.execute(tId));
    });

    blocTest<WatchlistStatusBloc, WatchlistStatusState>(
      'should execute save watchlist when function called successfully',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((realInvocation) async => Right('Added to Watchlist'));
        when(mockGetWatchlistStatus.execute(tId))
          .thenAnswer((realInvocation) async => true);
        return watchlistStatusBloc;
      },
      act: (bloc) {
        bloc.add(OnAddToWatchlist(testMovieDetail));
      },
      expect: () => [
        WatchlistStatusState(false, 'Added to Watchlist'),
      ],
    );

    blocTest<WatchlistStatusBloc, WatchlistStatusState>(
      'should execute remove watchlist when function called successfully',
      build: () {
        when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer(
            (realInvocation) async => Right('Removed from Watchlist'));
        when(mockGetWatchlistStatus.execute(tId))
          .thenAnswer((realInvocation) async => false);
        return watchlistStatusBloc;
      },
      act: (bloc) {
        bloc.add(OnRemoveFromWatchlist(testMovieDetail));
      },
      expect: () => [
        WatchlistStatusState(false, 'Removed from Watchlist'),
      ],
    );

    blocTest<WatchlistStatusBloc, WatchlistStatusState>(
      'should raise error message when add to watchlist is failed',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer(
            (realInvocation) async =>
                Left(DatabaseFailure('failed add to watchlist')));
        when(mockGetWatchlistStatus.execute(tId))
          .thenAnswer((realInvocation) async => false);        
        return watchlistStatusBloc;
      },
      act: (bloc) {
        bloc.add(OnAddToWatchlist(testMovieDetail));
      },
      expect: () => [
        WatchlistStatusState(false, 'failed add to watchlist'),
      ],
    );
  });
}
