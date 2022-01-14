import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/usecases/get_watchlist_status.dart';
import 'package:movies/domain/usecases/remove_watchlist.dart';
import 'package:movies/domain/usecases/save_watchlist.dart';

part 'watchlist_status_event.dart';
part 'watchlist_status_state.dart';

class WatchlistStatusBloc
    extends Bloc<WatchlistStatusEvent, WatchlistStatusState> {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';
  final GetWatchListStatus getWatchlistStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  WatchlistStatusBloc(
      {required this.getWatchlistStatus,
      required this.saveWatchlist,
      required this.removeWatchlist})
      : super(WatchlistStatusState(false, '')) {
    on<OnAddToWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.movieDetail);
      String msg = '';
      // bool status = state.status;
      result.fold((failure) {
        msg = failure.message;
      }, (success) async {
        msg = watchlistAddSuccessMessage;
        // status = await getWatchlistStatus.execute(event.movieDetail.id);
      });
      final status = await getWatchlistStatus.execute(event.movieDetail.id);
      emit(WatchlistStatusState(status, msg));
    });

    on<OnRemoveFromWatchlist>((event, emit) async {
      final result = await removeWatchlist.execute(event.movieDetail);
      String msg = '';
      // bool status = state.status;
      result.fold((failure) {
        msg = failure.message;
      }, (success) async {
        msg = watchlistRemoveSuccessMessage;
        // status = await getWatchlistStatus.execute(event.movieDetail.id);
      });
      final status = await getWatchlistStatus.execute(event.movieDetail.id);
      emit(WatchlistStatusState(status, msg));
    });

    on<OnLoadWatclistStatus>((event, emit) async {
      final result = await getWatchlistStatus.execute(event.id);
      emit(WatchlistStatusState(result, ''));
    });
  }
}
