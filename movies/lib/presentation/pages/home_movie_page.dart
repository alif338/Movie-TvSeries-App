import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/entities/movie.dart';
import 'package:movies/presentation/bloc/movie_list/now_playing_list/now_playing_list_bloc.dart';
import 'package:movies/presentation/bloc/movie_list/popular_list/popular_list_bloc.dart';
import 'package:movies/presentation/bloc/movie_list/top_rated_list/top_rated_list_bloc.dart';
import 'package:movies/presentation/pages/movie_detail_page.dart';
import 'package:movies/presentation/pages/popular_movies_page.dart';
import 'package:movies/presentation/pages/top_rated_movies_page.dart';

class HomeMoviePage extends StatefulWidget {
  static const ROUTE_NAME = '/now-playing-movie';
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    // Future.microtask(
    //     () => Provider.of<MovieListNotifier>(context, listen: false)
    //       ..fetchNowPlayingMovies()
    //       ..fetchPopularMovies()
    //       ..fetchTopRatedMovies());
    context.read<NowPlayingListBloc>().add(OnFetchNowPlayingMovies());
    context.read<PopularListBloc>().add(OnFetchPopularList());
    context.read<TopRatedListBloc>().add(OnFetchTopRatedList());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<NowPlayingListBloc, NowPlayingListState>(
                  builder: (context, state) {
                if (state is NowPlayingListLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is NowPlayingListHasData) {
                  return MovieList(state.result);
                } else if (state is NowPlayingListError) {
                  return Text('Failed');
                } else {
                  return Container();
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularListBloc, PopularListState>(
                  builder: (context, state) {
                if (state is PopularListLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularListHasData) {
                  return MovieList(state.result);
                } else if (state is PopularListError) {
                  return Text('Failed');
                } else {
                  return Container();
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedListBloc, TopRatedListState>(
                  builder: (context, state) {
                if (state is TopRatedListLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedListHasData) {
                  return MovieList(state.result);
                } else if (state is TopRatedListError) {
                  return Text('Failed');
                } else {
                  return Container();
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
