import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/tv_test_helper.mocks.dart';

void main() {
  late MockTvRepository mockTvRepository;
  late GetWatchlistTvs usecase;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetWatchlistTvs(mockTvRepository);
  });

  test('should get list of watchlist tv series from the repository', () async {
    // arrange
    when(mockTvRepository.getWatchlistTvs())
        .thenAnswer((realInvocation) async => Right(testTvList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvList));
  });
}
