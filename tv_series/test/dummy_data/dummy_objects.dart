import 'package:tv_series/data/models/tv_table.dart';
import 'package:tv_series/domain/entities/genre.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/entities/tv_detail.dart';

///////// TV SERIES DUMMY DATA //////////////////

final testTv = Tv(
    backdropPath: "/b0BckgEovxYLBbIk5xXyWYQpmlT.jpg",
    genreIds: [18],
    id: 67419,
    originalName: "Victoria",
    overview:
        "The early life of Queen Victoria, from her accession to the throne at the tender age of 18 through to her courtship and marriage to Prince Albert. Victoria went on to rule for 63 years, and was the longest-serving monarch until she was overtaken by Elizabeth II on 9th September 2016. Rufus Sewell was Victoria’s first prime minister; the two immediately connected and their intimate friendship became a popular source of gossip that threatened to destabilise the Government – angering both Tory and Whigs alike.",
    popularity: 11.520271,
    posterPath: "/zra8NrzxaEeunRWJmUm3HZOL4sd.jpg",
    releaseDate: "2016-08-28",
    name: "Victoria",
    voteAverage: 1.39,
    voteCount: 9);

final testTvList = [testTv];

final testTvDetail = TvDetail(
    backdropPath: "/suopoADq0k8YZr4dQXcU6pToj6s.jpg",
    genres: [
      Genre(id: 10765, name: "Sci-Fi & Fantasy"),
      Genre(id: 18, name: "Drama"),
      Genre(id: 10759, name: "Action & Adventure"),
      Genre(id: 9648, name: "Mystery")
    ],
    id: 1399,
    originalName: "Game of Thrones",
    overview:
        "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
    posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
    name: "Game of Thrones",
    voteAverage: 8.3,
    voteCount: 11504);

final testWatchListTv = Tv.watchlist(
    id: 1399, 
    overview: "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.", 
    posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg", 
    name: "Game of Thrones"
  );

final testTvTable = TvTable(
    id: 1399, 
    name: "Game of Thrones", 
    posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg", 
    overview: "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond."
  );

final testTvMap = {
  'id': 1399,
  'overview': "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
  'posterPath': "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
  'name': "Game of Thrones"
};
