import 'package:creen/core/utils/widgets/custom_appbar.dart';
import 'package:creen/features/market/view/pages/sections/products_sections_view.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;

import '../../../../core/utils/responsive/sizes.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  const ProductsByCategoryScreen({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String? title;

  @override
  Widget build(BuildContext context) {
    // var title = (ModalRoute.of(context)?.settings.arguments as String?) ?? '';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
        child: CustomAppBar(
          title: title,
          back: true,
        ),
      ),
      body: const ProductsSectionsView(),
    );
  }
}
