import 'package:flutter/material.dart';

class WatchlistTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-tv';
  const WatchlistTvPage({ Key? key }) : super(key: key);

  @override
  _WatchlistTvPageState createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Hello watchlist"),
    );
  }
}