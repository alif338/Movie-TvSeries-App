import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_recommendations/tv_recommendations_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_watchlist_status/tv_watchlist_status_bloc.dart';
import 'package:tv_series/tv_series.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetWatchlistTvStatus,
  SaveTvWatchlist,
  RemoveTvWatchlist
])
void main() {
  late TvDetailBloc tvDetailBloc;
  late TvRecommendationsBloc tvRecommendationsBloc;
  late TvWatchlistStatusBloc tvWatchlistStatusBloc;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchlistTvStatus mockGetWatchlistTvStatus;
  late MockSaveTvWatchlist mockSaveTvWatchlist;
  late MockRemoveTvWatchlist mockRemoveTvWatchlist;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchlistTvStatus = MockGetWatchlistTvStatus();
    mockSaveTvWatchlist = MockSaveTvWatchlist();
    mockRemoveTvWatchlist = MockRemoveTvWatchlist();
    tvDetailBloc = TvDetailBloc(mockGetTvDetail);
    tvRecommendationsBloc = TvRecommendationsBloc(mockGetTvRecommendations);
    tvWatchlistStatusBloc = TvWatchlistStatusBloc(
        saveTvWatchlist: mockSaveTvWatchlist,
        removeTvWatchlist: mockRemoveTvWatchlist,
        getWatchlistTvStatus: mockGetWatchlistTvStatus);
  });

  final tId = 1399;

  final testTv = Tv(
      backdropPath: "/b0BckgEovxYLBbIk5xXyWYQpmlT.jpg",
      genreIds: [18],
      id: 67419,
      originalName: "Victoria",
      overview:
          "The early life of Queen Victoria, from her accession to the throne at the tender age of 18 through to her courtship and marriage to Prince Albert. Victoria went on to rule for 63 years, and was the longest-serving monarch until she was overtaken by Elizabeth II on 9th September 2016. Rufus Sewell was Victoria’s first prime minister; the two immediately connected and their intimate friendship became a popular source of gossip that threatened to destabilise the Government – angering both Tory and Whigs alike.",
      popularity: 11.520271,
      posterPath: "/zra8NrzxaEeunRWJmUm3HZOL4sd.jpg",
      releaseDate: "2016-08-28",
      name: "Victoria",
      voteAverage: 1.39,
      voteCount: 9);
  final tTvs = <Tv>[testTv];

  group('get tv detail and/or movie recommendations:', () {
    blocTest<TvDetailBloc, TvDetailState>(
        'should get data of tv detail from the usecase', build: () {
      when(mockGetTvDetail.execute(tId))
          .thenAnswer((_) async => Right(testTvDetail));
      return tvDetailBloc;
    }, act: (bloc) {
      bloc.add(OnFetchTvDetail(tId));
    }, verify: (bloc) {
      verify(mockGetTvDetail.execute(tId));
    });

    blocTest<TvDetailBloc, TvDetailState>(
        'should emit [Loading, HasData] when usecase tv detail called successfully',
        build: () {
          when(mockGetTvDetail.execute(tId))
              .thenAnswer((_) async => Right(testTvDetail));
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvDetail(tId)),
        expect: () =>
            [TvDetailLoading(), TvDetailHasData(testTvDetail)],
        verify: (bloc) {
          verify(mockGetTvDetail.execute(tId));
        });

    blocTest<TvDetailBloc, TvDetailState>(
        'should emit [Loading, Error] when fetch tv detail is done unsuccessfully',
        build: () {
          when(mockGetTvDetail.execute(tId)).thenAnswer(
              (realInvocation) async => Left(ServerFailure('Bad Request')));
          return tvDetailBloc;
        },
        act: (bloc) => bloc.add(OnFetchTvDetail(tId)),
        expect: () => [TvDetailLoading(), TvDetailError('Bad Request')],
        verify: (bloc) {
          verify(mockGetTvDetail.execute(tId));
        });

    blocTest<TvRecommendationsBloc, TvRecommendationsState>(
        'should emit [Loading, HasData] on usecase tv recommendations after fetch successfully',
        build: () {
          when(mockGetTvRecommendations.execute(67419))
              .thenAnswer((_) async => Right(tTvs));
          return tvRecommendationsBloc;
        },
        act: (bloc) {
          bloc.add(OnFetchTvRecommendations(67419));
        },
        expect: () => [
              TvRecommendationsLoading(),
              TvRecommendationsHasData(tTvs)
            ],
        verify: (mock) {
          verify(mockGetTvRecommendations.execute(67419));
        });

    blocTest<TvRecommendationsBloc, TvRecommendationsState>(
        'should emit [Loading, Error] when fetching tv recommendation is unsuccessfully',
        build: () {
          when(mockGetTvRecommendations.execute(tId)).thenAnswer(
              (realInvocation) async => Left(ServerFailure('Error')));
          return tvRecommendationsBloc;
        },
        act: (bloc) {
          bloc.add(OnFetchTvRecommendations(tId));
        },
        expect: () => [
              TvRecommendationsLoading(),
              TvRecommendationsError('Error')
            ],
        verify: (bloc) {
          verify(mockGetTvRecommendations.execute(tId));
        });
  });

    group('Watchlist Status', () {
    blocTest<TvWatchlistStatusBloc, TvWatchlistStatusState>(
        'should get the watchlist status',
        build: () {
          when(mockGetWatchlistTvStatus.execute(1))
              .thenAnswer((realInvocation) async => false);
          return tvWatchlistStatusBloc;
        },
        act: (bloc) => bloc.add(OnLoadWatchlistTvStatus(1)),
        expect: () => [
          TvWatchlistStatusState(false, '')
        ],
        verify: (bloc) {
          verify(mockGetWatchlistTvStatus.execute(1));
        });

    blocTest<TvWatchlistStatusBloc, TvWatchlistStatusState>(
        'should execute save watchlist when function called', build: () {
      when(mockSaveTvWatchlist.execute(testTvDetail))
          .thenAnswer((realInvocation) async => Right('success'));
      when(mockGetWatchlistTvStatus.execute(tId))
          .thenAnswer((realInvocation) async => true);
      return tvWatchlistStatusBloc;
    }, act: (bloc) {
      bloc.add(OnAddToWatchlistTvs(testTvDetail));
      bloc.add(OnLoadWatchlistTvStatus(tId));
    }, verify: (bloc) {
      verify(mockSaveTvWatchlist.execute(testTvDetail));
      verify(mockGetWatchlistTvStatus.execute(tId));
    });

    blocTest<TvWatchlistStatusBloc, TvWatchlistStatusState>(
      'should execute save watchlist when function called successfully',
      build: () {
        when(mockSaveTvWatchlist.execute(testTvDetail))
          .thenAnswer((realInvocation) async => Right('Added to Watchlist'));
        when(mockGetWatchlistTvStatus.execute(tId))
          .thenAnswer((realInvocation) async => true);
        return tvWatchlistStatusBloc;
      },
      act: (bloc) {
        bloc.add(OnAddToWatchlistTvs(testTvDetail));
      },
      expect: () => [
        TvWatchlistStatusState(true, 'Added to Watchlist'),
      ],
    );

    blocTest<TvWatchlistStatusBloc, TvWatchlistStatusState>(
      'should execute remove watchlist when function called successfully',
      build: () {
        when(mockRemoveTvWatchlist.execute(testTvDetail)).thenAnswer(
            (realInvocation) async => Right('Removed from Watchlist'));
        when(mockGetWatchlistTvStatus.execute(tId))
          .thenAnswer((realInvocation) async => false);
        return tvWatchlistStatusBloc;
      },
      act: (bloc) {
        bloc.add(OnRemoveFromWatchlistTvs(testTvDetail));
      },
      expect: () => [
      TvWatchlistStatusState(false, 'Removed from Watchlist'),
      ],
    );

    blocTest<TvWatchlistStatusBloc, TvWatchlistStatusState>(
      'should raise error message when add to watchlist is failed',
      build: () {
        when(mockSaveTvWatchlist.execute(testTvDetail)).thenAnswer(
            (realInvocation) async =>
                Left(DatabaseFailure('failed add to watchlist')));
        when(mockGetWatchlistTvStatus.execute(tId))
          .thenAnswer((realInvocation) async => false);        
        return tvWatchlistStatusBloc;
      },
      act: (bloc) {
        bloc.add(OnAddToWatchlistTvs(testTvDetail));
      },
      expect: () => [
        TvWatchlistStatusState(false, 'failed add to watchlist'),
      ],
    );
  });
}
