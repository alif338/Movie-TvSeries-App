import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/tv_model.dart';
import 'package:tv_series/data/models/tv_response.dart';

import '../../json_reader.dart';

void main() {
  final tTvModel = TvModel(
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

  final tTvResponseModel = TvResponse(tvList: <TvModel>[tTvModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/tv_airing_today.json'));
      // act
      final result = TvResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/b0BckgEovxYLBbIk5xXyWYQpmlT.jpg",
            "genre_ids": [18],
            "id": 67419,
            "original_name": "Victoria",
            "overview": "The early life of Queen Victoria, from her accession to the throne at the tender age of 18 through to her courtship and marriage to Prince Albert. Victoria went on to rule for 63 years, and was the longest-serving monarch until she was overtaken by Elizabeth II on 9th September 2016. Rufus Sewell was Victoria’s first prime minister; the two immediately connected and their intimate friendship became a popular source of gossip that threatened to destabilise the Government – angering both Tory and Whigs alike.",
            "popularity": 11.520271,
            "poster_path": "/zra8NrzxaEeunRWJmUm3HZOL4sd.jpg",
            "first_air_date": "2016-08-28",
            "name": "Victoria",
            "vote_average": 1.39,
            "vote_count": 9
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
