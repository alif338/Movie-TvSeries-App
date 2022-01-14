import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:ditonton/common_page/search_page.dart';
import 'package:ditonton/common_page/watchlist_page.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:movies/movies.dart';
import 'package:tv_series/tv_series.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _bottomNavIndex = 0;
  List<Widget> _pagesWidget = [HomeMoviePage(), HomeTvPage()];
  List<BottomNavigationBarItem> _navItem = [
    BottomNavigationBarItem(
        icon: Icon(Icons.movie_creation_outlined),
        activeIcon: Icon(Icons.movie),
        label: "Movie"),
    BottomNavigationBarItem(icon: Icon(Icons.tv_outlined), label: "Tv Series"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                // FirebaseCrashlytics.instance.crash();
                // print("CRASSHH");
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: _pagesWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: _navItem,
        currentIndex: _bottomNavIndex,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
          });
        },
        selectedItemColor: kMikadoYellow,
      ),
    );
  }
}
