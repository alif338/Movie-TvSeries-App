part of 'top_rated_list_bloc.dart';

abstract class TopRatedListState extends Equatable {
  const TopRatedListState();

  @override
  List<Object> get props => [];
}

class TopRatedListEmpty extends TopRatedListState {}

class TopRatedListLoading extends TopRatedListState {}

class TopRatedListError extends TopRatedListState {
  final String message;

  TopRatedListError(this.message);

  @override
  List<Object> get props => [message];
}

class TopRatedListHasData extends TopRatedListState {
  final List<Movie> result;

  TopRatedListHasData(this.result);

  @override
  List<Object> get props => [result];
}
