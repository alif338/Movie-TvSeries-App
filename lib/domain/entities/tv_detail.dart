import 'package:ditonton/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvDetail extends Equatable {
  TvDetail({
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  String? backdropPath;
  List<Genre>? genres;
  int id;
  String? originalName;
  String? overview;
  double? popularity;
  String? posterPath;
  String? name;
  double? voteAverage;
  int? voteCount;

  @override
  // TODO: implement props
  List<Object?> get props => [
      backdropPath,
      genres,
      id,
      originalName,
      overview,
      posterPath,
      name,
      voteAverage,
      voteCount,
  ];
}
