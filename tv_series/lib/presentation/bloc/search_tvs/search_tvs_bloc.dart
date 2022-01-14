import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/tv_series.dart';
import 'package:rxdart/rxdart.dart';

part 'search_tvs_event.dart';
part 'search_tvs_state.dart';

class SearchTvsBloc extends Bloc<SearchTvsEvent, SearchTvsState> {
  final SearchTvs searchTvs;
  SearchTvsBloc(this.searchTvs) : super(SearchTvsEmpty()) {
    on<OnQueryChanged>((event, emit) async {
      final query = event.query;
      print(query);

      emit(SearchTvsLoading());
      final result = await searchTvs.execute(query);

      result.fold((failure) {
        emit(SearchTvsError(failure.message));
      }, (data) {
        emit(SearchTvsHasData(data));
      });
    }, transformer: debounce(Duration(milliseconds: 500)));
  }

  // Transformasi input (mengurangi hit api)
  EventTransformer<T> debounce<T>(Duration duration) =>
      (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}
