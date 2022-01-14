part of 'search_tvs_bloc.dart';

abstract class SearchTvsState extends Equatable {
  const SearchTvsState();
  
  @override
  List<Object> get props => [];
}

class SearchTvsEmpty extends SearchTvsState {}

class SearchTvsLoading extends SearchTvsState {}

class SearchTvsError extends SearchTvsState {
  final String message;

  SearchTvsError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchTvsHasData extends SearchTvsState {
  final List<Tv> result;

  SearchTvsHasData(this.result);

  @override
  List<Object> get props => [result];
}
