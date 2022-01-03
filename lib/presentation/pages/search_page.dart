import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/pages/search_movie_page.dart';
import 'package:ditonton/presentation/pages/tv_series/search_tv_page.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  static const ROUTE_NAME = '/search';

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Search'),
          bottom: TabBar(
            indicatorColor: kMikadoYellow,
            tabs: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text("Movie"),
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
            SearchMoviePage(),
            SearchTvPage()
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
