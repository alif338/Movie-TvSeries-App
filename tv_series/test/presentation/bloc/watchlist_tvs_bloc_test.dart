import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_watchlist_tvs.dart';
import 'package:tv_series/presentation/bloc/watchlist_tvs/watchlist_tvs_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_tvs_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistTvs])
void main() {
  late WatchlistTvsBloc watchlistTvsBloc;
  late MockGetWatchlistTvs mockGetWatchlistTvs;

  setUp(() {
    mockGetWatchlistTvs = MockGetWatchlistTvs();
    watchlistTvsBloc = WatchlistTvsBloc(mockGetWatchlistTvs);
  });

  blocTest<WatchlistTvsBloc, WatchlistTvsState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTvs.execute())
            .thenAnswer((realInvocation) async => Right([testWatchListTv]));
        return watchlistTvsBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistTvs()),
      expect: () => [
            WatchlistTvsLoading(),
            WatchlistTvsHasData([testWatchListTv])
          ],
      verify: (bloc) {
        verify(mockGetWatchlistTvs.execute());
      });

  blocTest<WatchlistTvsBloc, WatchlistTvsState>(
    'should emit [Loading, Error] when data is gotten unsuccessfully',
    build: () {
      when(mockGetWatchlistTvs.execute()).thenAnswer(
          (realInvocation) async => Left(DatabaseFailure("Can't get data")));
      return watchlistTvsBloc;
    },
    act: (bloc) => bloc.add(OnFetchWatchlistTvs()),
    expect: () => [
      WatchlistTvsLoading(),
      WatchlistTvsError("Can't get data")
    ],
    verify: (bloc) {
      verify(mockGetWatchlistTvs.execute());
    },
  );


}
