import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';
import 'package:movies/presentation/bloc/watchlist_movie/watchlist_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies])
void main() {
  late WatchlistBloc watchlistBloc;
  late MockGetWatchlistMovies mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    watchlistBloc = WatchlistBloc(mockGetWatchlistMovies);
  });

  blocTest<WatchlistBloc, WatchlistState>(
      'should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((realInvocation) async => Right([testWatchlistMovie]));
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(OnFetchWatchlistMovie()),
      expect: () => [
            WatchlistLoading(),
            WatchlistHasData([testWatchlistMovie])
          ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      });

  blocTest<WatchlistBloc, WatchlistState>(
    'should emit [Loading, Error] when data is gotten unsuccessfully',
    build: () {
      when(mockGetWatchlistMovies.execute()).thenAnswer(
          (realInvocation) async => Left(DatabaseFailure("Can't get data")));
      return watchlistBloc;
    },
    act: (bloc) => bloc.add(OnFetchWatchlistMovie()),
    expect: () => [
      WatchlistLoading(),
      WatchlistError("Can't get data")
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );
}
