import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../city/presentation/blocs/saved_cities_bloc/saved_cities_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<SavedCitiesBloc, SavedCitiesState>(
          buildWhen: (previous, current) =>
              current.status == SavedCitiesStatus.loaded,
          builder: (context, state) {
            return ListView.builder(
              padding: const EdgeInsets.all(AppDimensions.paddingRegular),
              itemCount: state.cityWeatherList.length,
              itemBuilder: (context, index) {},
            );
          },
        ),
      ),
    );
  }
}
