import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';

part 'now_playing_list_event.dart';
part 'now_playing_list_state.dart';

class NowPlayingListBloc
    extends Bloc<NowPlayingListEvent, NowPlayingListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  NowPlayingListBloc(this.getNowPlayingMovies) : super(NowPlayingListEmpty()) {
    on<OnFetchNowPlayingMovies>((event, emit) async {
      emit(NowPlayingListLoading());

      final result = await getNowPlayingMovies.execute();
      result.fold(
        (failure) {
          emit(NowPlayingListError(failure.message));
        }, 
        (data)  {
          emit(NowPlayingListHasData(data));
        }
      );
    });
  }
}
