import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/presentation/bloc/tv_list/popular_tvs/popular_tvs_bloc.dart';
import 'package:tv_series/tv_series.dart';

class MockPopularTvsBloc extends MockBloc<PopularTvsEvent, PopularTvsState>
    implements PopularTvsBloc {}

class FakePopularTvsEvent extends Fake implements PopularTvsEvent {}

class FakePopularTvsState extends Fake implements PopularTvsState {}

void main() {
  late MockPopularTvsBloc mockPopularTvsBloc;

  setUpAll(() {
    registerFallbackValue(FakePopularTvsEvent());
    registerFallbackValue(FakePopularTvsState());
  });

  setUp(() {
    mockPopularTvsBloc = MockPopularTvsBloc();
  });

  tearDown(() {
    mockPopularTvsBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvsBloc>(
      create: (_) => mockPopularTvsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockPopularTvsBloc.add(OnFetchPopularTvs()))
        .thenAnswer((invocation) {});
    when(() => mockPopularTvsBloc.state)
        .thenAnswer((invocation) => PopularTvsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockPopularTvsBloc.add(OnFetchPopularTvs()))
        .thenAnswer((invocation) {});
    when(() => mockPopularTvsBloc.state)
        .thenAnswer((invocation) => PopularTvsHasData(<Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockPopularTvsBloc.add(OnFetchPopularTvs()))
        .thenAnswer((invocation) {});
    when(() => mockPopularTvsBloc.state)
        .thenAnswer((invocation) => PopularTvsError('Error Message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
