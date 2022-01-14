import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_top_rated_movies.dart';

part 'top_rated_list_event.dart';
part 'top_rated_list_state.dart';

class TopRatedListBloc extends Bloc<TopRatedListEvent, TopRatedListState> {
  final GetTopRatedMovies getTopRatedMovies;
  TopRatedListBloc(this.getTopRatedMovies) : super(TopRatedListEmpty()) {
    on<OnFetchTopRatedList>((event, emit) async {
      emit(TopRatedListLoading());

      final result = await getTopRatedMovies.execute();
      result.fold(
        (failure) {
          emit(TopRatedListError(failure.message));
        }, 
        (data) {
          emit(TopRatedListHasData(data));
        }
      );
    });
  }
}
