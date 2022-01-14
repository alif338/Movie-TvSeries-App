import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/movies.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_recommendations/movie_recommendations_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail/watchlist_status/watchlist_status_bloc.dart';

import '../../dummy_data/dummy_objects.dart';

// Mock Bloc
class MockMovieDetailBloc extends MockBloc<MovieDetailEvent, MovieDetailState>
    implements MovieDetailBloc {}

class MockMovieRecommendationsBloc
    extends MockBloc<MovieRecommendationsEvent, MovieRecommendationsState>
    implements MovieRecommendationsBloc {}

class MockWatchlistStatusBloc
    extends MockBloc<WatchlistStatusEvent, WatchlistStatusState>
    implements WatchlistStatusBloc {}

// Mock event
class FakeMovieDetailEvent extends Fake implements MovieDetailEvent {}

class FakeMovieRecommendationsEvent extends Fake
    implements MovieRecommendationsEvent {}

class FakeWatchlistStatusEvent extends Fake implements WatchlistStatusEvent {}

// Mock state
class FakeMovieDetailState extends Fake implements MovieDetailState {}

class FakeMovieRecommendationsState extends Fake
    implements MovieRecommendationsState {}

class FakeWatchlistStatusState extends Fake implements WatchlistStatusState {}

void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMovieRecommendationsBloc mockMovieRecommendationsBloc;
  late MockWatchlistStatusBloc mockWatchlistStatusBloc;

  setUpAll(() {
    registerFallbackValue(FakeMovieDetailEvent());
    registerFallbackValue(FakeMovieDetailState());
    registerFallbackValue(FakeMovieRecommendationsEvent());
    registerFallbackValue(FakeMovieRecommendationsState());
    registerFallbackValue(FakeWatchlistStatusEvent());
    registerFallbackValue(FakeWatchlistStatusState());
  });

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMovieRecommendationsBloc = MockMovieRecommendationsBloc();
    mockWatchlistStatusBloc = MockWatchlistStatusBloc();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<MovieDetailBloc>(create: (_) => mockMovieDetailBloc),
          BlocProvider<MovieRecommendationsBloc>(
              create: (_) => mockMovieRecommendationsBloc),
          BlocProvider<WatchlistStatusBloc>(
              create: (_) => mockWatchlistStatusBloc),
        ],
        child: MaterialApp(
          home: body,
        ));
  }

  tearDown(() {
    mockMovieDetailBloc.close();
    mockMovieRecommendationsBloc.close();
    mockWatchlistStatusBloc.close();
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

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.add(OnFetchMovieDetail(tId)))
        .thenAnswer((invocation) {});
    when(() => mockMovieDetailBloc.state)
        .thenAnswer((invocation) => MovieDetailHasData(testMovieDetail));
    when(() =>
            mockMovieRecommendationsBloc.add(OnFetchMovieRecommendations(tId)))
        .thenAnswer((invocation) {});
    when(() => mockMovieRecommendationsBloc.state)
        .thenAnswer((invocation) => MovieRecommendatinsHasData(tMovies));
    when(() => mockWatchlistStatusBloc.add(OnLoadWatclistStatus(tId)))
        .thenAnswer((invocation) {});
    when(() => mockWatchlistStatusBloc.state)
        .thenAnswer((invocation) => WatchlistStatusState(false, ''));

    final watchlistButtonIcon = find.byIcon(Icons.add);
    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));
    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.add(OnFetchMovieDetail(tId)))
        .thenAnswer((invocation) {});
    when(() => mockMovieDetailBloc.state)
        .thenAnswer((invocation) => MovieDetailHasData(testMovieDetail));
    when(() =>
            mockMovieRecommendationsBloc.add(OnFetchMovieRecommendations(tId)))
        .thenAnswer((invocation) {});
    when(() => mockMovieRecommendationsBloc.state)
        .thenAnswer((invocation) => MovieRecommendatinsHasData(tMovies));
    when(() => mockWatchlistStatusBloc.add(OnLoadWatclistStatus(tId)))
        .thenAnswer((invocation) {});
    when(() => mockWatchlistStatusBloc.add(OnAddToWatchlist(testMovieDetail)))
        .thenAnswer((invocation) {});
    when(() => mockWatchlistStatusBloc.state).thenAnswer(
        (invocation) => WatchlistStatusState(true, 'Added to Watchlist'));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.add(OnFetchMovieDetail(tId)))
        .thenAnswer((invocation) {});
    when(() => mockMovieDetailBloc.state)
        .thenAnswer((invocation) => MovieDetailHasData(testMovieDetail));
    when(() =>
            mockMovieRecommendationsBloc.add(OnFetchMovieRecommendations(tId)))
        .thenAnswer((invocation) {});
    when(() => mockMovieRecommendationsBloc.state)
        .thenAnswer((invocation) => MovieRecommendatinsHasData(tMovies));
    when(() => mockWatchlistStatusBloc.add(OnLoadWatclistStatus(tId)))
        .thenAnswer((invocation) {});
    when(() => mockWatchlistStatusBloc.state)
        .thenAnswer((invocation) => WatchlistStatusState(false, ''));

    final watchlistButton = find.byType(ElevatedButton);
    final expectedStates = [
      WatchlistStatusState(false, ''),
      WatchlistStatusState(true, 'Added to Watchlist')
    ];

    whenListen(mockWatchlistStatusBloc, Stream.fromIterable(expectedStates));
    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: tId)));

    expect(find.byIcon(Icons.add), findsOneWidget);
    await tester.tap(watchlistButton);

    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockMovieDetailBloc.add(OnFetchMovieDetail(tId)))
        .thenAnswer((invocation) {});
    when(() => mockMovieDetailBloc.state)
        .thenAnswer((invocation) => MovieDetailHasData(testMovieDetail));
    when(() =>
            mockMovieRecommendationsBloc.add(OnFetchMovieRecommendations(tId)))
        .thenAnswer((invocation) {});
    when(() => mockMovieRecommendationsBloc.state)
        .thenAnswer((invocation) => MovieRecommendatinsHasData(tMovies));
    when(() => mockWatchlistStatusBloc.add(OnLoadWatclistStatus(tId)))
        .thenAnswer((invocation) {});
    when(() => mockWatchlistStatusBloc.state)
        .thenAnswer((invocation) => WatchlistStatusState(false, ''));

    final watchlistButton = find.byType(ElevatedButton);
    whenListen(
        mockWatchlistStatusBloc,
        Stream.fromIterable([
          WatchlistStatusState(false, ''),
          WatchlistStatusState(false, 'Failed')
        ]));
    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text('Failed'), findsNothing);
    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
