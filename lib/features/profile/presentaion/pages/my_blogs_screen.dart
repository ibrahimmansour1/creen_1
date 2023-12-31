import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/responsive/sizes.dart';
import '../../../../core/utils/widgets/blogs_view.dart';
import '../../../../core/utils/widgets/custom_appbar.dart';
import '../../../subject/viewModel/blogs/blogs_cubit.dart';

class MyBlogsScreen extends StatefulWidget {
  const MyBlogsScreen({Key? key}) : super(key: key);

  @override
  State<MyBlogsScreen> createState() => _MyBlogsScreenState();
}

class _MyBlogsScreenState extends State<MyBlogsScreen> {
  late BlogsCubit blogsCubit;
  @override
  void initState() {
    blogsCubit = context.read<BlogsCubit>()..getBlogs(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
        child: const CustomAppBar(
          title: 'blogs',
          back: true,
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.black, Colors.black45],
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                tileMode: TileMode.clamp)),
        child: BlogsView(
          blogsCubit: blogsCubit,
        ),
      ),
    );
  }
}
