import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/domain/usecases/get_tv_airing_today.dart';

part 'tv_airing_today_event.dart';
part 'tv_airing_today_state.dart';

class TvAiringTodayBloc extends Bloc<TvAiringTodayEvent, TvAiringTodayState> {
  final GetTvAiringToday getTvAiringToday;
  TvAiringTodayBloc(this.getTvAiringToday) : super(TvAiringTodayEmpty()) {
    on<OnFetchTvAiringToday>((event, emit) async {
      emit(TvAiringTodayLoading());

      final result = await getTvAiringToday.execute();
      result.fold(
        (failure) => emit(TvAiringTodayError(failure.message)), 
        (data) => emit(TvAiringTodayHasData(data))
      );
    });
  }
}
