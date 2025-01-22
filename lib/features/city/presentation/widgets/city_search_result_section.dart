import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/city_search_bloc/city_search_bloc.dart';
import '../widgets/city_search_result_tile.dart';

class CitySearchResultSection extends StatelessWidget {
  const CitySearchResultSection();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<CitySearchBloc, CitySearchState>(
        builder: (context, state) {
          if (state.citySearchResults.isEmpty) {
            return const Center(child: Text("Aucun résultat"));
          }
          return ListView.builder(
            itemCount: state.citySearchResults.length,
            itemBuilder: (context, index) {
              return CitySearchResultTile(city: state.citySearchResults[index]);
            },
          );
        },
      ),
    );
  }
}
