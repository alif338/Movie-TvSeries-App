part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

// Movie Detail State
class MovieDetailEmpty extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieDetailHasData extends MovieDetailState {
  final MovieDetail movieDetail;

  MovieDetailHasData(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

// // Movie Recommendations State
// class MovieRecommendationsEmpty extends MovieDetailState {}

// class MovieRecommendationsLoading extends MovieDetailState {}

// class MovieRecommendationsError extends MovieDetailState {
//   final String message;

//   MovieRecommendationsError(this.message);

//   @override
//   List<Object> get props => [message];
// }

// class MovieRecommendatinsHasData extends MovieDetailState {
//   final List<Movie> result;

//   MovieRecommendatinsHasData(this.result);

//   @override
//   List<Object> get props => [result];
// }

// // Add/Remove Watchlist State
// class AddOrRemoveWatchlistMessage extends MovieDetailState {
//   final String message;

//   AddOrRemoveWatchlistMessage(this.message);

//   @override
//   List<Object> get props => [message];
// }

// // Check watchlist status state
// class IsAddedToWatchlistState extends MovieDetailState {
//   final bool result;

//   IsAddedToWatchlistState(this.result);

//   @override
//   List<Object> get props => [result];
// }
