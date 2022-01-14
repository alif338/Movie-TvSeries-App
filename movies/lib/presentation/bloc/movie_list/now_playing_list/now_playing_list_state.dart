part of 'now_playing_list_bloc.dart';

abstract class NowPlayingListState extends Equatable {
  const NowPlayingListState();

  @override
  List<Object> get props => [];
}

class NowPlayingListEmpty extends NowPlayingListState {}

class NowPlayingListLoading extends NowPlayingListState {}

class NowPlayingListError extends NowPlayingListState {
  final String message;

  NowPlayingListError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingListHasData extends NowPlayingListState {
  final List<Movie> result;

  NowPlayingListHasData(this.result);

  @override
  List<Object> get props => [result];
}
