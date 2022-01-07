import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/data/models/tv_detail_model.dart';
import 'package:ditonton/data/models/tv_model.dart';
import 'package:ditonton/data/repositories/tv_repository_impl.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/tv_test_helper.mocks.dart';

void main() {
  late TvRepositoryImpl repository;
  late MockTvRemoteDataSource mockTvRemoteDataSource;
  late MockTvLocalDataSource mockTvLocalDataSource;

  setUp(() {
    mockTvLocalDataSource = MockTvLocalDataSource();
    mockTvRemoteDataSource = MockTvRemoteDataSource();
    repository = TvRepositoryImpl(
        remoteDataSource: mockTvRemoteDataSource,
        localDataSource: mockTvLocalDataSource);
  });

  final tTvModel = TvModel(
      backdropPath: "/1Zv62x7qDSsbGGE95eR3LuAdpQn.jpg",
      genreIds: [18],
      id: 66776,
      originalName: "微微一笑很傾城",
      overview:
          "What is it that makes a man fall in love with a woman at first sight? Appearance? Aura? Wealth? NO, when campus prince and gaming expert, student Xiao Nai first saw Bei Wei Wei, what made him fall in love was not her extraordinary beauty, but her slim and slender fingers that were flying across the keyboard and her calm and composed manner!!! Embarrassing, no? At the same time, gaming expert Bei Wei Wei, at this time and place is on the computer, methodically commanding a guild war, and won a perfect and glorious victory despite being at a disadvantage, and was completely unaware that cupid is nearby. Soon after basketball player, swimmer, all-around excellent student, and game company president, Xiao Nai, uses both tactics on and off-line to take this beauty’s heart. Therefore this romance slowly bloomed. ~~ Drama adapted from the novel by Gu Man.",
      popularity: 7.090989,
      posterPath: "/d4XLZn21yIyt1cAs6C7U7zNN0Ec.jpg",
      releaseDate: "2016-08-22",
      name: "Love O2O",
      voteAverage: 3,
      voteCount: 6);

  final tTv = Tv(
      backdropPath: "/1Zv62x7qDSsbGGE95eR3LuAdpQn.jpg",
      genreIds: [18],
      id: 66776,
      originalName: "微微一笑很傾城",
      overview:
          "What is it that makes a man fall in love with a woman at first sight? Appearance? Aura? Wealth? NO, when campus prince and gaming expert, student Xiao Nai first saw Bei Wei Wei, what made him fall in love was not her extraordinary beauty, but her slim and slender fingers that were flying across the keyboard and her calm and composed manner!!! Embarrassing, no? At the same time, gaming expert Bei Wei Wei, at this time and place is on the computer, methodically commanding a guild war, and won a perfect and glorious victory despite being at a disadvantage, and was completely unaware that cupid is nearby. Soon after basketball player, swimmer, all-around excellent student, and game company president, Xiao Nai, uses both tactics on and off-line to take this beauty’s heart. Therefore this romance slowly bloomed. ~~ Drama adapted from the novel by Gu Man.",
      popularity: 7.090989,
      posterPath: "/d4XLZn21yIyt1cAs6C7U7zNN0Ec.jpg",
      releaseDate: "2016-08-22",
      name: "Love O2O",
      voteAverage: 3,
      voteCount: 6);

  final tTvModelList = <TvModel>[tTvModel];
  final tTvList = <Tv>[tTv];

  group('tv airing today', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getAiringTodayTvs())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getTvAiringTodays();
      // assert
      verify(mockTvRemoteDataSource.getAiringTodayTvs());
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test(
        'should return server failure when the call to remote data source is uncussessful ',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getAiringTodayTvs())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvAiringTodays();
      // assert
      verify(mockTvRemoteDataSource.getAiringTodayTvs());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when devices disconnected to internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getAiringTodayTvs())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvAiringTodays();
      // assert
      verify(mockTvRemoteDataSource.getAiringTodayTvs());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('popular tv series', () {
    test('should return tv series list when fetching is successful', () async {
      // arrange
      when(mockTvRemoteDataSource.getPopularTvs())
          .thenAnswer((realInvocation) async => tTvModelList);
      // act
      final result = await repository.getPopularTvs();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return server exception when fetching is failed', () async {
      // arrange
      when(mockTvRemoteDataSource.getPopularTvs()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularTvs();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getPopularTvs())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getPopularTvs();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('top rated tv series', () {
    test('should return movie list when call to data source is successful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTopRatedTvs())
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getTopRatedTvs();
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTopRatedTvs())
          .thenThrow(ServerException());
      // act
      final result = await repository.getTopRatedTvs();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTopRatedTvs())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTopRatedTvs();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('get tv series detail', () {
    final tId = 1399;
    final tTvResponse = TvDetailResponse(
        backdropPath: "/suopoADq0k8YZr4dQXcU6pToj6s.jpg",
        genres: [
          GenreModel(id: 10765, name: "Sci-Fi & Fantasy"),
          GenreModel(id: 18, name: "Drama"),
          GenreModel(id: 10759, name: "Action & Adventure"),
          GenreModel(id: 9648, name: "Mystery"),
        ],
        homepage: 'https://google.com',
        id: 1399,
        originalLanguage: 'en',
        originalName: "Game of Thrones",
        overview:
            "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond.",
        popularity: 1,
        posterPath: "/u3bZgnGQ9T01sWNhyveQz0wH0Hl.jpg",
        status: 'status',
        tagline: 'tagline',
        name: "Game of Thrones",
        voteAverage: 8.3,
        voteCount: 11504);

    test(
        'should return tv series data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvDetail(tId))
          .thenAnswer((_) async => tTvResponse);
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockTvRemoteDataSource.getTvDetail(tId));
      expect(result, equals(Right(testTvDetail)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockTvRemoteDataSource.getTvDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvDetail(tId);
      // assert
      verify(mockTvRemoteDataSource.getTvDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('get tv series recommendations', () {
    final tTvList = <TvModel>[];
    final tId = 1;

    test('should return data (tv series list) when the call is successful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvRecommendations(tId))
          .thenAnswer((_) async => tTvList);
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockTvRemoteDataSource.getTvRecommendations(tId));
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getTvRecommendations(tId);
      // assertbuild runner
      verify(mockTvRemoteDataSource.getTvRecommendations(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.getTvRecommendations(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getTvRecommendations(tId);
      // assert
      verify(mockTvRemoteDataSource.getTvRecommendations(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('search tv series', () {
    final tQuery = 'batman';

    test('should return tv series list when call to data source is successful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.searchTvs(tQuery))
          .thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.searchTvs(tQuery);
      // assert
      /* workaround to test List in Right. Issue: https://github.com/spebbe/dartz/issues/80 */
      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockTvRemoteDataSource.searchTvs(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchTvs(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockTvRemoteDataSource.searchTvs(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchTvs(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist tv series', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockTvLocalDataSource.insertWatchlist(testTvTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTvDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockTvLocalDataSource.insertWatchlist(testTvTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist tv series', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockTvLocalDataSource.removeWatchlist(testTvTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(testTvDetail);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockTvLocalDataSource.removeWatchlist(testTvTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockTvLocalDataSource.getTvById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tv series', () {
    test('should return list of Movies', () async {
      // arrange
      when(mockTvLocalDataSource.getWatchlistTvs())
          .thenAnswer((_) async => [testTvTable]);
      // act
      final result = await repository.getWatchlistTvs();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchListTv]);
    });
  });
}
