import 'package:core/core.dart';
import 'package:ditonton/common/utils.dart';
import 'package:about/about_page.dart';
import 'package:ditonton/common_page/home.dart';
import 'package:ditonton/common_page/search_page.dart';
import 'package:ditonton/common_page/watchlist_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/movies.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_recommendations/movie_recommendations_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail/watchlist_status/watchlist_status_bloc.dart';
import 'package:movies/presentation/bloc/search_movie/search_bloc.dart';
import 'package:movies/presentation/bloc/watchlist_movie/watchlist_bloc.dart';
import 'package:movies/presentation/bloc/movie_detail/movie_detail_bloc.dart';
import 'package:movies/presentation/bloc/movie_list/now_playing_list/now_playing_list_bloc.dart';
import 'package:movies/presentation/bloc/movie_list/popular_list/popular_list_bloc.dart';
import 'package:movies/presentation/bloc/movie_list/top_rated_list/top_rated_list_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:tv_series/presentation/bloc/search_tvs/search_tvs_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_detail_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_recommendations/tv_recommendations_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail/tv_watchlist_status/tv_watchlist_status_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_list/popular_tvs/popular_tvs_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_list/top_rated_tvs/top_rated_tvs_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_list/tv_airing_today/tv_airing_today_bloc.dart';
import 'package:tv_series/presentation/bloc/watchlist_tvs/watchlist_tvs_bloc.dart';
import 'package:tv_series/tv_series.dart';

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<NowPlayingListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieRecommendationsBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<SearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularListBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistStatusBloc>(),
        ),
        // TV Series
        BlocProvider(
          create: (_) => di.locator<TvAiringTodayBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<TvRecommendationsBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<SearchTvsBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<TopRatedTvsBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvsBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<WatchlistTvsBloc>()
        ),
        BlocProvider(
          create: (_) => di.locator<TvWatchlistStatusBloc>()
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          accentColor: kMikadoYellow,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: Home(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => Home());
            case POPULAR_MOVIES_ROUTE:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TOP_RATED_ROUTE:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MOVIE_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case TV_DETAIL_ROUTE:
              final id = settings.arguments as int;
              return MaterialPageRoute(builder: (_) => TvDetailPage(id: id),
              settings: settings
            );
            case SEARCH_ROUTE:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WATCHLIST_ROUTE:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case ABOUT_ROUTE:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case POPULAR_TV_ROUTE:
              return MaterialPageRoute(builder: (_) => PopularTvPage());
            case TOP_RATED_TV_ROUTE:
              return MaterialPageRoute(builder: (_) => TopRatedTvPage());
            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
