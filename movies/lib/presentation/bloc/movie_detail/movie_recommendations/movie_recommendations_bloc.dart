import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/domain/usecases/get_movie_recommendations.dart';

part 'movie_recommendations_event.dart';
part 'movie_recommendations_state.dart';

class MovieRecommendationsBloc extends Bloc<MovieRecommendationsEvent, MovieRecommendationsState> {
    final GetMovieRecommendations getMovieRecommendations;
  MovieRecommendationsBloc(this.getMovieRecommendations) : super(MovieRecommendationsEmpty()) {
    on<OnFetchMovieRecommendations>((event, emit) async {
      emit(MovieRecommendationsLoading());

      final result = await getMovieRecommendations.execute(event.id);

      result.fold((failure) {
        emit(MovieRecommendationsError(failure.message));
      }, (data) {
        emit(MovieRecommendatinsHasData(data));
      });
    });
  }
}
