import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/watchlist_tvs/watchlist_tvs_bloc.dart';
import 'package:tv_series/presentation/widgets/tv_card_list.dart';

class WatchlistTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';
  const WatchlistTvPage({Key? key}) : super(key: key);

  @override
  _WatchlistTvPageState createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  void initState() {
    print("Init state TV PAGE");
    super.initState();
    // Future.microtask(() =>
    //     Provider.of<WatchlistTvNotifier>(context, listen: false)
    //         .fetchWatchlistTvs());
  }

  @override
  void didChangeDependencies() {
    print("Changes dependency TV PAGE");
    super.didChangeDependencies();
    // routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  // @override
  // void didPopNext() {
  //   Provider.of<WatchlistTvNotifier>(context, listen: false)
  //     .fetchWatchlistTvs();
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvsBloc, WatchlistTvsState>(
          builder: (context, state) {
            if (state is WatchlistTvsLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is WatchlistTvsHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.result[index];
                  return TvCard(movie);
                },
                itemCount: state.result.length,
              );
            } else if (state is WatchlistTvsError) {
              return Center(
                key: Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    print("UNSUBSCRIbe TV PAGE");
    // routeObserver.unsubscribe(this);
    super.dispose();
  }
}
