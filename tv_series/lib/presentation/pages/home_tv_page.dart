import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/domain/entities/tv.dart';
import 'package:tv_series/presentation/bloc/tv_list/popular_tvs/popular_tvs_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_list/top_rated_tvs/top_rated_tvs_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_list/tv_airing_today/tv_airing_today_bloc.dart';
import 'package:tv_series/presentation/pages/popular_tv_page.dart';
import 'package:tv_series/presentation/pages/top_rated_tv_page.dart';
import 'package:tv_series/presentation/pages/tv_detail_page.dart';

class HomeTvPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-airing-today';
  const HomeTvPage({Key? key}) : super(key: key);

  @override
  _HomeTvPageState createState() => _HomeTvPageState();
}

class _HomeTvPageState extends State<HomeTvPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future.microtask(() => Provider.of<TvListNotifier>(context, listen: false)
    //   ..fetchAiringTodayTvs()
    //   ..fetchPopularTvs()
    //   ..fetchTopRatedTvs());
    context.read<TvAiringTodayBloc>().add(OnFetchTvAiringToday());
    context.read<PopularTvsBloc>().add(OnFetchPopularTvs());
    context.read<TopRatedTvsBloc>().add(OnFetchTopRatedTvs());
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
              BlocBuilder<TvAiringTodayBloc, TvAiringTodayState>(
                  builder: (context, state) {
                if (state is TvAiringTodayLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TvAiringTodayHasData) {
                  return TvList(state.result);
                } else if (state is TvAiringTodayError) {
                  return Text('Failed');
                } else {
                  return Container();
                }
              }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularTvPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularTvsBloc, PopularTvsState>(
                  builder: (context, state) {
                if (state is PopularTvsLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is PopularTvsHasData) {
                  return TvList(state.result);
                } else if (state is PopularTvsError) {
                  return Text('Failed');
                } else {
                  return Container();
                }
              }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedTvPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedTvsBloc, TopRatedTvsState>(
                  builder: (context, state) {
                if (state is TopRatedTvsLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is TopRatedTvsHasData) {
                  return TvList(state.result);
                } else if (state is TopRatedTvsError) {
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

class TvList extends StatelessWidget {
  final List<Tv> tv;
  TvList(this.tv);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = tv[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  TvDetailPage.ROUTE_NAME,
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
        itemCount: tv.length,
      ),
    );
  }
}
