import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tvs.dart';

part 'top_rated_tvs_event.dart';
part 'top_rated_tvs_state.dart';

class TopRatedTvsBloc extends Bloc<TopRatedTvsEvent, TopRatedTvsState> {
  final GetTopRatedTvs getTopRatedTvs;
  TopRatedTvsBloc(this.getTopRatedTvs) : super(TopRatedTvsEmpty()) {
    on<OnFetchTopRatedTvs>((event, emit) async {
      emit(TopRatedTvsLoading());

      final result = await getTopRatedTvs.execute();
      result.fold((failure) => emit(TopRatedTvsError(failure.message)),
          (data) => emit(TopRatedTvsHasData(data)));
    });
  }
}
