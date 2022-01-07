import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_popular_tvs.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/tv_test_helper.mocks.dart';

void main() {
  late MockTvRepository mockTvRepository;
  late GetPopularTvs usecase;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetPopularTvs(mockTvRepository);
  });

  final tTvs = <Tv>[];

  group('GetPopularTvs Test', () {
    group('execute', () {
      test(
          'should get list of tv series from the repository when excute function is called',
          () async {
        // arrange
        when(mockTvRepository.getPopularTvs())
            .thenAnswer((realInvocation) async => Right(tTvs));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTvs));
      });
    });
  });
}
