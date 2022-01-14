part of 'popular_list_bloc.dart';

abstract class PopularListState extends Equatable {
  const PopularListState();

  @override
  List<Object> get props => [];
}

class PopularListEmpty extends PopularListState {}

class PopularListLoading extends PopularListState {}

class PopularListError extends PopularListState {
  final String message;

  PopularListError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularListHasData extends PopularListState {
  final List<Movie> result;

  PopularListHasData(this.result);

  @override
  List<Object> get props => [result];
}
