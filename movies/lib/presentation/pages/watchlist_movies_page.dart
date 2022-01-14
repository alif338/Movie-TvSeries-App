import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/bloc/watchlist_movie/watchlist_bloc.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    print("Init State MOVIE PAGE");
    super.initState();
    // Future.microtask(() =>
    //     Provider.of<WatchlistMovieNotifier>(context, listen: false)
    //         .fetchWatchlistMovies());
  }

  @override
  void didChangeDependencies() {
    print("Change Dependency MOVIE PAGE");
    super.didChangeDependencies();
    // routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  // @override
  // void didPopNext() {
  //   Provider.of<WatchlistMovieNotifier>(context, listen: false)
  //       .fetchWatchlistMovies();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistBloc, WatchlistState>(
          builder: (context, state) {
            if (state is WatchlistLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistHasData) {
              return state.result.length == 0 
              ? Center(
                child: Text("Empty"),
              ) : ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return MovieCard(movie);
                },
                itemCount: state.result.length,
              );
            } else if (state is WatchlistError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Center(
                child: Text("Watchlist Movies Empty"),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    print("UNSUBSCRIbe MOVIE PAGE");
    // routeObserver.unsubscribe(this);
    super.dispose();
  }
}
