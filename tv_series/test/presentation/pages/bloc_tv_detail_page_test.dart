import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_recommendations/tv_recommendations_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_watchlist_status/tv_watchlist_status_bloc.dart';
import 'package:tv_series/presentation/pages/tv_detail_page.dart';

import '../../dummy_data/dummy_objects.dart';

class MockTvDetailBloc extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}

class MockTvRecommendationsBloc
    extends MockBloc<TvRecommendationsEvent, TvRecommendationsState>
    implements TvRecommendationsBloc {}

class MockTvWatchlistStatusBloc
    extends MockBloc<TvWatchlistStatusEvent, TvWatchlistStatusState>
    implements TvWatchlistStatusBloc {}

//  Mock event
class FakeTvDetailEvent extends Fake implements TvDetailEvent {}

class FakeTvRecommendationsEvent extends Fake
    implements TvRecommendationsEvent {}

class FakeTvWatchlistStatusEvent extends Fake
    implements TvWatchlistStatusEvent {}

// Mock State
class FakeTvDetailState extends Fake implements TvDetailState {}

class FakeTvRecommendationsState extends Fake
    implements TvRecommendationsState {}

class FakeTvWatchlistStatusState extends Fake
    implements TvWatchlistStatusState {}

void main() {
  late MockTvDetailBloc mockTvDetailBloc;
  late MockTvRecommendationsBloc mockTvRecommendationsBloc;
  late MockTvWatchlistStatusBloc mockTvWatchlistStatusBloc;

  setUpAll(() {
    registerFallbackValue(FakeTvDetailEvent());
    registerFallbackValue(FakeTvDetailState());
    registerFallbackValue(FakeTvRecommendationsEvent());
    registerFallbackValue(FakeTvRecommendationsState());
    registerFallbackValue(FakeTvWatchlistStatusEvent());
    registerFallbackValue(FakeTvWatchlistStatusState());
  });

  setUp(() {
    mockTvDetailBloc = MockTvDetailBloc();
    mockTvRecommendationsBloc = MockTvRecommendationsBloc();
    mockTvWatchlistStatusBloc = MockTvWatchlistStatusBloc();
  });

  tearDown(() {
    mockTvDetailBloc.close();
    mockTvRecommendationsBloc.close();
    mockTvWatchlistStatusBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<TvDetailBloc>(create: (_) => mockTvDetailBloc),
          BlocProvider<TvRecommendationsBloc>(
              create: (_) => mockTvRecommendationsBloc),
          BlocProvider<TvWatchlistStatusBloc>(
              create: (_) => mockTvWatchlistStatusBloc),
        ],
        child: MaterialApp(
          home: body,
        ));
  }

  final tId = 1399;
  final tTv = Tv(
      backdropPath: 'backdropPath',
      genreIds: [1, 2, 3],
      id: 1399,
      originalName: 'originalName',
      overview: 'overview',
      popularity: 1,
      posterPath: 'posterPath',
      releaseDate: 'releaseDate',
      name: 'name',
      voteAverage: 1,
      voteCount: 1);
  final tTvs = <Tv>[tTv];

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.add(OnFetchTvDetail(tId)))
        .thenAnswer((invocation) {});
    when(() => mockTvDetailBloc.state)
        .thenAnswer((invocation) => TvDetailHasData(testTvDetail));
    when(() =>
            mockTvRecommendationsBloc.add(OnFetchTvRecommendations(tId)))
        .thenAnswer((invocation) {});
    when(() => mockTvRecommendationsBloc.state)
        .thenAnswer((invocation) => TvRecommendationsHasData(tTvs));
    when(() => mockTvWatchlistStatusBloc.add(OnLoadWatchlistTvStatus(tId)))
        .thenAnswer((invocation) {});
    when(() => mockTvWatchlistStatusBloc.state)
        .thenAnswer((invocation) => TvWatchlistStatusState(false, ''));

    final watchlistButtonIcon = find.byIcon(Icons.add);
    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));
    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.add(OnFetchTvDetail(tId)))
        .thenAnswer((invocation) {});
    when(() => mockTvDetailBloc.state)
        .thenAnswer((invocation) => TvDetailHasData(testTvDetail));
    when(() =>
            mockTvRecommendationsBloc.add(OnFetchTvRecommendations(tId)))
        .thenAnswer((invocation) {});
    when(() => mockTvRecommendationsBloc.state)
        .thenAnswer((invocation) => TvRecommendationsHasData(tTvs));
    when(() => mockTvWatchlistStatusBloc.add(OnLoadWatchlistTvStatus(tId)))
        .thenAnswer((invocation) {});
    when(() => mockTvWatchlistStatusBloc.add(OnAddToWatchlistTvs(testTvDetail)))
        .thenAnswer((invocation) {});
    when(() => mockTvWatchlistStatusBloc.state).thenAnswer(
        (invocation) => TvWatchlistStatusState(true, 'Added to Watchlist'));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

   testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.add(OnFetchTvDetail(tId)))
        .thenAnswer((invocation) {});
    when(() => mockTvDetailBloc.state)
        .thenAnswer((invocation) => TvDetailHasData(testTvDetail));
    when(() =>
            mockTvRecommendationsBloc.add(OnFetchTvRecommendations(tId)))
        .thenAnswer((invocation) {});
    when(() => mockTvRecommendationsBloc.state)
        .thenAnswer((invocation) => TvRecommendationsHasData(tTvs));
    when(() => mockTvWatchlistStatusBloc.add(OnLoadWatchlistTvStatus(tId)))
        .thenAnswer((invocation) {});
    when(() => mockTvWatchlistStatusBloc.state)
        .thenAnswer((invocation) => TvWatchlistStatusState(false, ''));

    final watchlistButton = find.byType(ElevatedButton);
    final expectedStates = [
      TvWatchlistStatusState(false, ''),
      TvWatchlistStatusState(true, 'Added to Watchlist')
    ];

    whenListen(mockTvWatchlistStatusBloc, Stream.fromIterable(expectedStates));
    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: tId)));

    expect(find.byIcon(Icons.add), findsOneWidget);
    await tester.tap(watchlistButton);

    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(() => mockTvDetailBloc.add(OnFetchTvDetail(tId)))
        .thenAnswer((invocation) {});
    when(() => mockTvDetailBloc.state)
        .thenAnswer((invocation) => TvDetailHasData(testTvDetail));
    when(() =>
            mockTvRecommendationsBloc.add(OnFetchTvRecommendations(tId)))
        .thenAnswer((invocation) {});
    when(() => mockTvRecommendationsBloc.state)
        .thenAnswer((invocation) => TvRecommendationsHasData(tTvs));
    when(() => mockTvWatchlistStatusBloc.add(OnLoadWatchlistTvStatus(tId)))
        .thenAnswer((invocation) {});
    when(() => mockTvWatchlistStatusBloc.state)
        .thenAnswer((invocation) => TvWatchlistStatusState(false, ''));

    final watchlistButton = find.byType(ElevatedButton);
    whenListen(
        mockTvWatchlistStatusBloc,
        Stream.fromIterable([
          TvWatchlistStatusState(false, ''),
          TvWatchlistStatusState(false, 'Failed')
        ]));
    await tester.pumpWidget(_makeTestableWidget(TvDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.text('Failed'), findsNothing);
    await tester.tap(watchlistButton, warnIfMissed: false);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });
}
