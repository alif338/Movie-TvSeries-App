import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_popular_tvs.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tvs.dart';
import 'package:tv_series/domain/usecases/get_tv_airing_today.dart';
import 'package:tv_series/presentation/bloc/tv_list/popular_tvs/popular_tvs_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_list/top_rated_tvs/top_rated_tvs_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_list/tv_airing_today/tv_airing_today_bloc.dart';

import 'tv_list_bloc_test.mocks.dart';

@GenerateMocks([GetTvAiringToday, GetPopularTvs, GetTopRatedTvs])
void main() {
  late TvAiringTodayBloc tvAiringTodayBloc;
  late PopularTvsBloc popularTvsBloc;
  late TopRatedTvsBloc topRatedTvsBloc;
  late MockGetTvAiringToday mockGetTvAiringToday;
  late MockGetPopularTvs mockGetPopularTvs;
  late MockGetTopRatedTvs mockGetTopRatedTvs;

  setUp(() {
    mockGetTvAiringToday = MockGetTvAiringToday();
    mockGetPopularTvs = MockGetPopularTvs();
    mockGetTopRatedTvs = MockGetTopRatedTvs();
    tvAiringTodayBloc = TvAiringTodayBloc(mockGetTvAiringToday);
    popularTvsBloc = PopularTvsBloc(mockGetPopularTvs);
    topRatedTvsBloc = TopRatedTvsBloc(mockGetTopRatedTvs);
  });

  final tTv = Tv(
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3],
      id: 1,
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      name: 'name',
      voteAverage: 1,
      voteCount: 1);
  final tTvList = <Tv>[tTv];

  group('tv airing today', () {
    test('initial state must be empty', () {
      expect(tvAiringTodayBloc.state, isA<TvAiringTodayEmpty>());
    });
    blocTest<TvAiringTodayBloc, TvAiringTodayState>(
      'initialstate should be empty', 
      build: () {
        return tvAiringTodayBloc;
      },
      expect: () => []
    );

    blocTest<TvAiringTodayBloc, TvAiringTodayState>(
      'should get data from the usecase', 
      build: () {
        when(mockGetTvAiringToday.execute())
          .thenAnswer((realInvocation) async => Right(tTvList));
        return tvAiringTodayBloc;
      },
      act: (bloc) => bloc.add(OnFetchTvAiringToday()),
      verify: (bloc) {
        verify(mockGetTvAiringToday.execute());
      }
    );

    blocTest<TvAiringTodayBloc, TvAiringTodayState>(
      'should change movies when data is gotten successfully', 
        build: () {
        when(mockGetTvAiringToday.execute())
          .thenAnswer((realInvocation) async => Right(tTvList));
        return tvAiringTodayBloc;
      },
      act: (bloc) => bloc.add(OnFetchTvAiringToday()),
      expect: () => [
        TvAiringTodayLoading(),
        TvAiringTodayHasData(tTvList)
      ]
    );

    blocTest<TvAiringTodayBloc, TvAiringTodayState>(
      'should return error when data is unsuccessful', 
      build: () {
        when(mockGetTvAiringToday.execute())
          .thenAnswer((realInvocation) async => Left(ServerFailure('Server Failure')));
        return tvAiringTodayBloc;
      },
      act: (bloc) => bloc.add(OnFetchTvAiringToday()),
      expect: () => [
        TvAiringTodayLoading(),
        TvAiringTodayError('Server Failure')
      ]
    );
  });

  group('popular tv series', () {

    test('initial state must be empty', () {
      expect(popularTvsBloc.state, isA<PopularTvsEmpty>());
    });

    blocTest<PopularTvsBloc, PopularTvsState>(
      'should get data from the usecase', 
      build: () {
        when(mockGetPopularTvs.execute())
          .thenAnswer((realInvocation) async => Right(tTvList));
        return popularTvsBloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularTvs()),
      verify: (bloc) {
        verify(mockGetPopularTvs.execute());
      }
    );

    blocTest<PopularTvsBloc, PopularTvsState>(
      'should change tv series when data is gotten successfully', 
        build: () {
        when(mockGetPopularTvs.execute())
          .thenAnswer((realInvocation) async => Right(tTvList));
        return popularTvsBloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularTvs()),
      expect: () => [
        PopularTvsLoading(),
        PopularTvsHasData(tTvList)
      ]
    );

    blocTest<PopularTvsBloc, PopularTvsState>(
      'should return error when data is unsuccessful', 
      build: () {
        when(mockGetPopularTvs.execute())
          .thenAnswer((realInvocation) async => Left(ServerFailure('Server Failure')));
        return popularTvsBloc;
      },
      act: (bloc) => bloc.add(OnFetchPopularTvs()),
      expect: () => [
        PopularTvsLoading(),
        PopularTvsError('Server Failure')
      ]
    );
  });

  group('top rated tv series', () {

    test('initial state must be empty', () {
      expect(topRatedTvsBloc.state, isA<TopRatedTvsEmpty>());
    });

    blocTest<TopRatedTvsBloc, TopRatedTvsState>(
      'should get data from the usecase', 
      build: () {
        when(mockGetTopRatedTvs.execute())
          .thenAnswer((realInvocation) async => Right(tTvList));
        return topRatedTvsBloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedTvs()),
      verify: (bloc) {
        verify(mockGetTopRatedTvs.execute());
      }
    );

    blocTest<TopRatedTvsBloc, TopRatedTvsState>(
      'should change movies when data is gotten successfully', 
        build: () {
        when(mockGetTopRatedTvs.execute())
          .thenAnswer((realInvocation) async => Right(tTvList));
        return topRatedTvsBloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedTvs()),
      expect: () => [
        TopRatedTvsLoading(),
        TopRatedTvsHasData(tTvList)
      ]
    );

    blocTest<TopRatedTvsBloc, TopRatedTvsState>(
      'should return error when data is unsuccessful', 
      build: () {
        when(mockGetTopRatedTvs.execute())
          .thenAnswer((realInvocation) async => Left(ServerFailure('Server Failure')));
        return topRatedTvsBloc;
      },
      act: (bloc) => bloc.add(OnFetchTopRatedTvs()),
      expect: () => [
        TopRatedTvsLoading(),
        TopRatedTvsError('Server Failure')
      ]
    );
  });
}
