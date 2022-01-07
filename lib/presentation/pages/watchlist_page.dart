import 'package:ditonton/common/constants.dart';
import 'package:ditonton/presentation/pages/tv_series/watchlist_tv_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/material.dart';

class WatchlistPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist';
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  _WatchlistPageState createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Future.microtask(() {
  //     Provider.of<WatchlistMovieNotifier>(context, listen: false)
  //         .fetchWatchlistMovies();
  //     Provider.of<WatchlistTvNotifier>(context, listen: false)
  //         .fetchWatchlistTvs();
  //   });
  // }

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   routeObserver.subscribe(this, ModalRoute.of(context)!);
  // }

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
        body: TabBarView(
          children: [
            WatchlistMoviesPage(),
            WatchlistTvPage()
          ]),
      ),
    );
  }

  // @override
  // void dispose() {
  //   routeObserver.unsubscribe(this);
  //   super.dispose();
  // }
}
