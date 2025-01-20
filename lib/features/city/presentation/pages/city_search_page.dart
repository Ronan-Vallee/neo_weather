import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/city_search_bloc/city_search_bloc.dart';
import '../blocs/saved_cities_bloc/saved_cities_bloc.dart';

class CitySearchPage extends StatelessWidget {
  const CitySearchPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const SizedBox.shrink(),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Column(
          children: [
            SearchBar(
              onSubmitted: (value) => context
                  .read<CitySearchBloc>()
                  .add(CitySearchSubmitted(query: value)),
            ),
            Expanded(
              child: BlocBuilder<CitySearchBloc, CitySearchState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.citySearchResults.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(state.citySearchResults[index].name),
                        trailing: Text(
                          "${state.citySearchResults[index].country}, ${state.citySearchResults[index].state}",
                        ),
                        onTap: () => context.read<SavedCitiesBloc>().add(
                              SavedCitiesCitySelected(
                                city: state.citySearchResults[index],
                              ),
                            ),
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
