import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/movies.dart';
import 'package:movies/presentation/bloc/movie_list/top_rated_list/top_rated_list_bloc.dart';

class MockTopRatedListBloc
    extends MockBloc<TopRatedListEvent, TopRatedListState>
    implements TopRatedListBloc {}

class FakeTopRatedListEvent extends Fake implements TopRatedListEvent {}

class FakeTopRatedListState extends Fake implements TopRatedListState {}

void main() {
  late MockTopRatedListBloc mockTopRatedListBloc;

  setUpAll(() {
    registerFallbackValue(FakeTopRatedListEvent());
    registerFallbackValue(FakeTopRatedListState());
  });

  setUp(() {
    mockTopRatedListBloc = MockTopRatedListBloc();
  });

  tearDown(() {
    mockTopRatedListBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedListBloc>(
      create: (_) => mockTopRatedListBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedListBloc.add(OnFetchTopRatedList()))
        .thenAnswer((invocation) {});
    when(() => mockTopRatedListBloc.state)
        .thenAnswer((invocation) => TopRatedListLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedListBloc.add(OnFetchTopRatedList()))
        .thenAnswer((invocation) {});
    when(() => mockTopRatedListBloc.state)
        .thenAnswer((invocation) => TopRatedListHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedListBloc.add(OnFetchTopRatedList()))
        .thenAnswer((invocation) {});
    when(() => mockTopRatedListBloc.state)
        .thenAnswer((invocation) => TopRatedListError('Error Message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
