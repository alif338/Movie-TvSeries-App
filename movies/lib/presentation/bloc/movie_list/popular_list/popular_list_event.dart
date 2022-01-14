part of 'popular_list_bloc.dart';

abstract class PopularListEvent extends Equatable {
  const PopularListEvent();

  @override
  List<Object> get props => [];
}

class OnFetchPopularList extends PopularListEvent{
  @override
  List<Object> get props => [];
}