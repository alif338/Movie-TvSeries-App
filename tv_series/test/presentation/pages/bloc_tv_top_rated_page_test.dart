import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/presentation/bloc/tv_list/top_rated_tvs/top_rated_tvs_bloc.dart';
import 'package:tv_series/tv_series.dart';

class MockTopRatedTvsBloc extends MockBloc<TopRatedTvsEvent, TopRatedTvsState>
    implements TopRatedTvsBloc {}

class FakeTopRatedTvsEvent extends Fake implements TopRatedTvsEvent {}

class FakeTopRatedTvsState extends Fake implements TopRatedTvsState {}

void main() {
  late MockTopRatedTvsBloc mockTopRatedTvsBloc;

  setUpAll(() {
    registerFallbackValue(FakeTopRatedTvsEvent());
    registerFallbackValue(FakeTopRatedTvsState());
  });

  setUp(() {
    mockTopRatedTvsBloc = MockTopRatedTvsBloc();
  });

  tearDown(() {
    mockTopRatedTvsBloc.close();
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<TopRatedTvsBloc>(
      create: (_) => mockTopRatedTvsBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvsBloc.add(OnFetchTopRatedTvs()))
        .thenAnswer((invocation) {});
    when(() => mockTopRatedTvsBloc.state)
        .thenAnswer((invocation) => TopRatedTvsLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is loaded',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvsBloc.add(OnFetchTopRatedTvs()))
        .thenAnswer((invocation) {});
    when(() => mockTopRatedTvsBloc.state)
        .thenAnswer((invocation) => TopRatedTvsHasData(<Tv>[]));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => mockTopRatedTvsBloc.add(OnFetchTopRatedTvs()))
        .thenAnswer((invocation) {});
    when(() => mockTopRatedTvsBloc.state)
        .thenAnswer((invocation) => TopRatedTvsError('Error Message'));

    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(TopRatedTvPage()));

    expect(textFinder, findsOneWidget);
  });
}
