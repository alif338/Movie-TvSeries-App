part of 'watchlist_status_bloc.dart';

abstract class WatchlistStatusEvent extends Equatable {
  const WatchlistStatusEvent();

  @override
  List<Object> get props => [];
}

class OnAddToWatchlist extends WatchlistStatusEvent {
  final MovieDetail movieDetail;

  OnAddToWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnRemoveFromWatchlist extends WatchlistStatusEvent {
  final MovieDetail movieDetail;

  OnRemoveFromWatchlist(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class OnLoadWatclistStatus extends WatchlistStatusEvent {
  final int id;

  OnLoadWatclistStatus(this.id);

  @override
  List<Object> get props => [id];
}
