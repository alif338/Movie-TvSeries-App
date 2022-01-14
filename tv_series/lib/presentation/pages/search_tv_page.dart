import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:tv_series/presentation/bloc/search_tvs/search_tvs_bloc.dart';
import 'package:tv_series/presentation/widgets/tv_card_list.dart';

class SearchTvPage extends StatefulWidget {
  const SearchTvPage({Key? key}) : super(key: key);

  @override
  _SearchTvPageState createState() => _SearchTvPageState();
}

class _SearchTvPageState extends State<SearchTvPage> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            onChanged: (query) {
              context.read<SearchTvsBloc>().add(OnQueryChanged(query));
            },
            decoration: InputDecoration(
              hintText: 'Search title',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.search,
          ),
          SizedBox(height: 16),
          Text(
            'Search Result',
            style: kHeading6,
          ),
          BlocBuilder<SearchTvsBloc, SearchTvsState>(
            builder: (context, state) {
              if (state is SearchTvsLoading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SearchTvsHasData) {
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final tv = state.result[index];
                      return TvCard(tv);
                    },
                    itemCount: state.result.length,
                  ),
                );
              } else if (state is SearchTvsError) {
                return Expanded(
                  child: Center(
                    child: Text(state.message),
                  ),
                );
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
