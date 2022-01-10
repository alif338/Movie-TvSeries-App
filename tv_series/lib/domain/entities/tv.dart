import 'package:equatable/equatable.dart';

class Tv extends Equatable {
  Tv({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  Tv.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  String? backdropPath;
  List<int>? genreIds;
  int id;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? name;
  double? voteAverage;
  int? voteCount;

  @override
  // TODO: implement props
  List<Object?> get props => [
      backdropPath,
      genreIds,
      id,
      originalName,
      overview,
      popularity,
      posterPath,
      releaseDate,
      name,
      voteAverage,
      voteCount,
  ];
}
