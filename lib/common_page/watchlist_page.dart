import 'package:core/core.dart';
import 'package:ditonton/common/utils.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:movies/presentation/bloc/watchlist_movie/watchlist_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/presentation/bloc/watchlist_tvs/watchlist_tvs_bloc.dart';
import 'package:tv_series/tv_series.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> with RouteAware {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future.microtask(() =>
    //     Provider.of<WatchlistMovieNotifier>(context, listen: false)
    //         .fetchWatchlistMovies());
    context.read<WatchlistBloc>().add(OnFetchWatchlistMovie());
    context.read<WatchlistTvsBloc>().add(OnFetchWatchlistTvs());
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    // TODO: implement didPopNext
    super.didPopNext();
    context.read<WatchlistTvsBloc>().add(OnFetchWatchlistTvs());
    // Provider.of<WatchlistMovieNotifier>(context, listen: false)
    //     .fetchWatchlistMovies();
    context.read<WatchlistBloc>().add(OnFetchWatchlistMovie());
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Watchlist'),
          bottom: TabBar(
            indicatorColor: kMikadoYellow,
            tabs: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("Movies"),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("TV Series"),
              )
            ],
          ),
        ),
        body: TabBarView(children: [WatchlistMoviesPage(), WatchlistTvPage()]),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
