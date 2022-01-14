part of 'watchlist_status_bloc.dart';

// ignore: must_be_immutable
class WatchlistStatusState extends Equatable {
  final bool status;
  final String message;
  const WatchlistStatusState(this.status, this.message);

  @override
  List<Object> get props => [status, message];
}

