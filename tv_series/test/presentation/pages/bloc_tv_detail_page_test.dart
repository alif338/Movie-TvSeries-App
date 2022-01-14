import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_recommendations/tv_recommendations_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_watchlist_status/tv_watchlist_status_bloc.dart';

class MockTvDetailBloc extends MockBloc<TvDetailEvent, TvDetailState>
    implements TvDetailBloc {}

class MockTvRecommendationsBloc
    extends MockBloc<TvRecommendationsEvent, TvRecommendationsState>
    implements TvRecommendationsBloc {}

class MockTvWatchlistStatusBloc extends MockBloc<TvWatchlistStatusEvent, TvWatchlistStatusState> implements TvWatchlistStatusBloc {}

//  Mock event
class FakeTvDetailEvent extends Fake implements TvDetailEvent {}
class FakeTvRecommendationsEvent extends Fake implements TvRecommendationsEvent {}
class FakeTvWatchlistStatusEvent extends Fake implements TvWatchlistStatusEvent {}

// Mock State
class FakeTvDetailState extends Fake implements TvDetailState {}
class FakeTvRecommendationsState extends Fake implements TvRecommendationsState {}
class FakeTvWatchlistStatusState extends Fake implements TvWatchlistStatusState {}

void main() {
  
}