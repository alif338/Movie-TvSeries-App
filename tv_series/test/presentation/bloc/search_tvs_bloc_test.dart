import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/search_tvs.dart';
import 'package:tv_series/presentation/bloc/search_tvs/search_tvs_bloc.dart';

import 'search_tvs_bloc_test.mocks.dart';

@GenerateMocks([SearchTvs])
void main() {
  late SearchTvsBloc searchTvsBloc;
  late MockSearchTvs mockSearchTvs;

  setUp(() {
    mockSearchTvs = MockSearchTvs();
    searchTvsBloc = SearchTvsBloc(mockSearchTvs);
  });

  final tTvModel = Tv(
      backdropPath: "/k5c2BlteWTYXffuBpUo5UGwmINJ.jpg",
      genreIds: [16, 10765, 9648, 10759],
      id: 2022,
      originalName: "The Batman",
      overview:
          "Bruce Wayne, The Batman -- billionaire by day, crime fighter by night -- joined on occasion by Robin and Batgirl.",
      popularity: 57.333,
      posterPath: "/t5mbrd79o89pYB8OQ4QPFNkIRPm.jpg",
      releaseDate: "2004-09-11",
      name: "The Batman",
      voteAverage: 7.8,
      voteCount: 304);
  final tTvList = <Tv>[tTvModel];
  final tQuery = 'batman';

  blocTest<SearchTvsBloc, SearchTvsState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTvs.execute(tQuery))
          .thenAnswer((realInvocation) async => Right(tTvList));
      return searchTvsBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvsLoading(),
      SearchTvsHasData(tTvList)
    ],
    verify: (bloc) {
      verify(mockSearchTvs.execute(tQuery));
    }
  );

  blocTest<SearchTvsBloc, SearchTvsState>(
    'Should emit [Loading, Error] when get search is unsuccessful', 
    build: () {
      when(mockSearchTvs.execute(tQuery))
        .thenAnswer((realInvocation) async => Left(ServerFailure('Server Failure')));
      return searchTvsBloc;
    },
    act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchTvsLoading(),
      SearchTvsError('Server Failure')
    ],
    verify: (bloc) {
      verify(mockSearchTvs.execute(tQuery));
    },
  );
}
