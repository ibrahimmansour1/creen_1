import 'package:creen/features/market/view/pages/sections/products_sections_view.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../viewModel/allProducts/all_products_cubit.dart';
import '../../../viewModel/reaction/reaction_cubit.dart';

class SpecificProductSection extends StatelessWidget {
  const SpecificProductSection({
    Key? key,
    required this.section,
    this.categoryId,
    this.page,
  }) : super(key: key);
  final String section;
  final int? categoryId;
  final Widget? page;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      // key: key,
      providers: [
        BlocProvider(
          create: (_) => AllProductsCubit(
            productsSection: section,
            categoryId: categoryId,
          ),
        ),
        BlocProvider(
          create: (context) => ReactionCubit(),
        ),
      ],
      child: page ??
          ProductsSectionsView(
            key: key,
          ),
    );
  }
}
