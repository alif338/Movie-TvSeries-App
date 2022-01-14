import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_watchlist_tvs.dart';

part 'watchlist_tvs_event.dart';
part 'watchlist_tvs_state.dart';

class WatchlistTvsBloc extends Bloc<WatchlistTvsEvent, WatchlistTvsState> {
  final GetWatchlistTvs getWatchlistTvs;

  WatchlistTvsBloc(this.getWatchlistTvs) : super(WatchlistTvsEmpty()) {
    on<OnFetchWatchlistTvs>((event, emit) async {
      emit(WatchlistTvsLoading());

      final result = await getWatchlistTvs.execute();
      result.fold(
        (failure) {
          emit(WatchlistTvsError(failure.message));
        }, 
        (data) {
          emit(WatchlistTvsHasData(data));
        }
      );
    });
  }
}
