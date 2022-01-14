import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_popular_tvs.dart';

part 'popular_tvs_event.dart';
part 'popular_tvs_state.dart';

class PopularTvsBloc extends Bloc<PopularTvsEvent, PopularTvsState> {
  final GetPopularTvs getPopularTvs;
  PopularTvsBloc(this.getPopularTvs) : super(PopularTvsEmpty()) {
    on<OnFetchPopularTvs>((event, emit) async {
      emit(PopularTvsLoading());

      final result = await getPopularTvs.execute();
      result.fold(
        (failure) => emit(PopularTvsError(failure.message)), 
        (data) => emit(PopularTvsHasData(data))
      );
    });
  }
}
