import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_airing_today.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/tv_test_helper.mocks.dart';

void main() {
  late GetTvAiringToday usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvAiringToday(mockTvRepository);
  });

  final tTvs = <Tv>[];

  test('should get list of tv series (airing today) from the repository',
      () async {
    // arrange
    when(mockTvRepository.getTvAiringTodays())
        .thenAnswer((realInvocation) async => Right(tTvs));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(tTvs));
  });
}
