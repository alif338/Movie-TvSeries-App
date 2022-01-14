part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();

  @override
  List<Object> get props => [];
}

class OnFetchMovieDetail extends MovieDetailEvent {
  final int id;

  OnFetchMovieDetail(this.id);
  @override
  List<Object> get props => [id];
}

// class OnFetchMovieRecommendations extends MovieDetailEvent {
//   final int id;

//   OnFetchMovieRecommendations(this.id);

//   @override
//   List<Object> get props => [id];
// }

// class OnAddToWatchlist extends MovieDetailEvent {
//   final MovieDetail movieDetail;

//   OnAddToWatchlist(this.movieDetail);

//   @override
//   List<Object> get props => [movieDetail];
// }

// class OnRemoveFromWatchlist extends MovieDetailEvent {
//   final MovieDetail movieDetail;

//   OnRemoveFromWatchlist(this.movieDetail);

//   @override
//   List<Object> get props => [movieDetail];
// }

// class OnLoadWatclistStatus extends MovieDetailEvent {
//   final int id;

//   OnLoadWatclistStatus(this.id);

//   @override
//   List<Object> get props => [id];
// }
