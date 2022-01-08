import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/tv_local_datas_source.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/tv_test_helper.mocks.dart';

void main() {
  late TvLocalDataSourceImpl dataSource;
  late MockTvDatabaseHelper mockTvDatabaseHelper;

  setUp(() {
    mockTvDatabaseHelper = MockTvDatabaseHelper();
    dataSource = TvLocalDataSourceImpl(databaseHelper: mockTvDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success',
        () async {
      // arrange
      when(mockTvDatabaseHelper.insertWatchlist(testTvTable))
          .thenAnswer((realInvocation) async => 1);
      //act
      final result = await dataSource.insertWatchlist(testTvTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw error message when insert to database is failed',
        () async {
      // arrange
      when(mockTvDatabaseHelper.insertWatchlist(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success',
        () async {
      // arrange
      when(mockTvDatabaseHelper.removeWatchlist(testTvTable))
          .thenAnswer((realInvocation) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testTvTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });
    test('should throw exception message when remove from database is failed',
        () async {
      // arrange
      when(mockTvDatabaseHelper.removeWatchlist(testTvTable))
          .thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testTvTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get tv series detail by id', () {
    final tId = 1;

    test('should return tv series detail when data is found', () async {
      // arrange
      when(mockTvDatabaseHelper.getTvById(tId))
          .thenAnswer((realInvocation) async => testTvMap);
      // act
      final result = await dataSource.getTvById(tId);
      // assert
      expect(result, testTvTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockTvDatabaseHelper.getTvById(tId))
          .thenAnswer((realInvocation) async => null);
      // act
      final result = await dataSource.getTvById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist tv series', () {
    test('should return list of Tv Series from database', () async {
      // arrange
      when(mockTvDatabaseHelper.getWatchlistTvs())
          .thenAnswer((_) async => [testTvMap]);
      // act
      final result = await dataSource.getWatchlistTvs();
      // assert
      expect(result, [testTvTable]);
    });
  });
}
