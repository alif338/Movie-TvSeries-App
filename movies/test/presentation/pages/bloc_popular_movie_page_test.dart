import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/movies.dart';
import 'package:movies/presentation/bloc/movie_list/popular_list/popular_list_bloc.dart';

class MockPopularListBloc extends MockBloc<PopularListEvent, PopularListState>
    implements PopularListBloc {}

class FakePopularListEvent extends Fake implements PopularListEvent {}

class FakePopularListState extends Fake implements PopularListState {}

void main() {
  late MockPopularListBloc mockPopularListBloc;

  setUpAll(() {
    registerFallbackValue(FakePopularListEvent());
    registerFallbackValue(FakePopularListState());
  });

  setUp(() {
    mockPopularListBloc = MockPopularListBloc();
  });

  tearDown(() {
    mockPopularListBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularListBloc>(
      create: (_) => mockPopularListBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularListBloc.add(OnFetchPopularList()))
        .thenAnswer((invocation) {});
    when(() => mockPopularListBloc.state)
        .thenAnswer((invocation) => PopularListLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularListBloc.add(OnFetchPopularList()))
        .thenAnswer((invocation) {});
    when(() => mockPopularListBloc.state)
        .thenAnswer((invocation) => PopularListHasData(<Movie>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularListBloc.add(OnFetchPopularList()))
        .thenAnswer((invocation) {});
    when(() => mockPopularListBloc.state)
        .thenAnswer((invocation) => PopularListError('Error Message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
