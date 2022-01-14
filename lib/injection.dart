import 'package:core/core.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:http/io_client.dart';
import 'package:movies/movies.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_recommendations/movie_recommendations_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail/watchlist_status/watchlist_status_bloc.dart';
import 'package:movies/presentation/bloc/search_movie/search_bloc.dart';
import 'package:movies/presentation/bloc/watchlist_movie/watchlist_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movies/presentation/bloc/movie_list/now_playing_list/now_playing_list_bloc.dart';
import 'package:movies/presentation/bloc/movie_list/popular_list/popular_list_bloc.dart';
import 'package:movies/presentation/bloc/movie_list/top_rated_list/top_rated_list_bloc.dart';
import 'package:tv_series/presentation/bloc/search_tvs/search_tvs_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_recommendations/tv_recommendations_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_watchlist_status/tv_watchlist_status_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_list/popular_tvs/popular_tvs_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_list/top_rated_tvs/top_rated_tvs_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_list/tv_airing_today/tv_airing_today_bloc.dart';
import 'package:tv_series/presentation/bloc/watchlist_tvs/watchlist_tvs_bloc.dart';
import 'package:tv_series/tv_series.dart';

final locator = GetIt.instance;

void init() {
  // provider
  // locator.registerFactory(
  //   () => MovieListNotifier(
  //     getNowPlayingMovies: locator(),
  //     getPopularMovies: locator(),
  //     getTopRatedMovies: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => MovieDetailNotifier(
  //     getMovieDetail: locator(),
  //     getMovieRecommendations: locator(),
  //     getWatchListStatus: locator(),
  //     saveWatchlist: locator(),
  //     removeWatchlist: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => MovieSearchNotifier(
  //     searchMovies: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => PopularMoviesNotifier(
  //     locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => TopRatedMoviesNotifier(
  //     getTopRatedMovies: locator(),
  //   ),
  // );
  // locator.registerFactory(
  //   () => WatchlistMovieNotifier(
  //     getWatchlistMovies: locator(),
  //   ),
  // );
  // bloc
  locator.registerFactory(() => SearchBloc(locator()));
  locator.registerFactory(() => WatchlistBloc(locator()));
  locator.registerFactory(
    () => MovieDetailBloc(
      getMovieDetail: locator(),
    ),
  );
  locator.registerFactory(() => MovieRecommendationsBloc(locator()));
  locator.registerFactory(() => WatchlistStatusBloc(
      getWatchlistStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator()));
  locator.registerFactory(() => NowPlayingListBloc(locator()));
  locator.registerFactory(() => PopularListBloc(locator()));
  locator.registerFactory(() => TopRatedListBloc(locator()));

  // TV Series Provider
  // locator.registerFactory(() => TvListNotifier(
  //     getTvAiringToday: locator(),
  //     getPopularTvs: locator(),
  //     getTopRatedTvs: locator()));
  // locator.registerFactory(() => TvDetailNotifier(
  //     getTvDetail: locator(),
  //     getTvRecommendations: locator(),
  //     getWatchlistTvStatus: locator(),
  //     saveTvWatchlist: locator(),
  //     removeTvWatchlist: locator()));
  // locator.registerFactory(() => TvSearchNotifier(searchTvs: locator()));
  // locator.registerFactory(() => PopularTvNotifier(
  //       locator(),
  //     ));
  // locator.registerFactory(() => TopRatedTvNotifier(
  //       locator(),
  //     ));
  // locator.registerFactory(() => WatchlistTvNotifier(
  //       getWatchlistTvs: locator(),
  //     ));
  // BLoC
  locator.registerFactory(() => TvAiringTodayBloc(locator()));
  locator.registerFactory(() => TvDetailBloc(locator()));
  locator.registerFactory(() => SearchTvsBloc(locator()));
  locator.registerFactory(() => TvRecommendationsBloc(locator()));
  locator.registerFactory(() => TopRatedTvsBloc(locator()));
  locator.registerFactory(() => PopularTvsBloc(locator()));
  locator.registerFactory(() => WatchlistTvsBloc(locator()));
  locator.registerFactory(() => TvWatchlistStatusBloc(
      saveTvWatchlist: locator(),
      removeTvWatchlist: locator(),
      getWatchlistTvStatus: locator()));

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  // TV Series
  locator.registerLazySingleton(() => GetTvAiringToday(locator()));
  locator.registerLazySingleton(() => GetPopularTvs(locator()));
  locator.registerLazySingleton(() => GetTopRatedTvs(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTvs(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvStatus(locator()));
  locator.registerLazySingleton(() => SaveTvWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTvWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTvs(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(() => TvRepositoryImpl(
      remoteDataSource: locator(), localDataSource: locator()));

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
  locator.registerLazySingleton<TvDatabaseHelper>(() => TvDatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton<ApiIOClient>(() => ApiIOClient());
}
