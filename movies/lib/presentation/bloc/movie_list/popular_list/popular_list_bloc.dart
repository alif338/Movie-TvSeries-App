import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';

part 'popular_list_event.dart';
part 'popular_list_state.dart';

class PopularListBloc extends Bloc<PopularListEvent, PopularListState> {
  final GetPopularMovies getPopularMovies;
  PopularListBloc(this.getPopularMovies) : super(PopularListEmpty()) {
    on<OnFetchPopularList>((event, emit) async {
      emit(PopularListLoading());

      final result = await getPopularMovies.execute();
      result.fold(
        (failure) {
          emit(PopularListError(failure.message));
        }, 
        (data) {
          emit(PopularListHasData(data));
        }
      );
    });
  }
}
