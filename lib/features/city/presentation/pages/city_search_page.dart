import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';
import '../widgets/city_search_input.dart';

class CitySearchPage extends StatelessWidget {
  const CitySearchPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
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
            ],
          ),
        ),
      ),
    );
  }
}
