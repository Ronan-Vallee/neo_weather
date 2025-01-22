import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../../../../service_locator.dart' as di;
import '../blocs/city_search_bloc/city_search_bloc.dart';
import '../widgets/city_search_input.dart';
import '../widgets/city_search_result_section.dart';

class CitySearchPage extends StatelessWidget {
  const CitySearchPage();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.locator<CitySearchBloc>(),
      child: const Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingRegular,
              vertical: AppDimensions.paddingLarge,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: AppDimensions.paddingRegular,
              children: [
                BackButton(),
                CitySearchInput(),
                CitySearchResultSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
