import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies/domain/entities/movie_detail.dart';
import 'package:movies/domain/usecases/get_movie_detail.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  MovieDetailBloc({
    required this.getMovieDetail, 
  }) : super(MovieDetailEmpty()) {
    on<OnFetchMovieDetail>((event, emit) async {
      emit(MovieDetailLoading());

      final result = await getMovieDetail.execute(event.id);

      result.fold((failure) {
        emit(MovieDetailError(failure.message));
      }, (data) {
        emit(MovieDetailHasData(data));
      });
    });

    // on<OnFetchMovieRecommendations>((event, emit) async {
    //   emit(MovieRecommendationsLoading());

    //   final result = await getMovieRecommendations.execute(event.id);

    //   result.fold((failure) {
    //     emit(MovieRecommendationsError(failure.message));
    //   }, (data) {
    //     emit(MovieRecommendatinsHasData(data));
    //   });
    // });

    // on<OnAddToWatchlist>((event, emit) async {
    //   final result = await saveWatchlist.execute(event.movieDetail);

    //   result.fold((failure) {
    //     emit(AddOrRemoveWatchlistMessage(failure.message));
    //   }, (success) {
    //     emit(AddOrRemoveWatchlistMessage(success));
    //   });
    // });

    // on<OnRemoveFromWatchlist>((event, emit) async {
    //   final result = await removeWatchlist.execute(event.movieDetail);

    //   result.fold((failure) {
    //     emit(AddOrRemoveWatchlistMessage(failure.message));
    //   }, (success) {
    //     emit(AddOrRemoveWatchlistMessage(success));
    //   });
    // });

    // on<OnLoadWatclistStatus>((event, emit) async {
    //   final result = await getWatchlistStatus.execute(event.id);

    //   emit(IsAddedToWatchlistState(result));
    // });
  }
}
