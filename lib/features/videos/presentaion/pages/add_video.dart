import 'dart:developer';

import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/core/utils/widgets/custom_appbar.dart';
import 'package:creen/core/utils/widgets/loader_widget.dart';
import 'package:creen/features/drawer/presentaion/pages/naviigation_drawer.dart';
import 'package:creen/features/videos/presentaion/pages/video_item.dart';
import 'package:creen/features/videos/presentaion/pages/video_screen.dart';
import 'package:creen/features/videos/viewModel/videos/videos_cubit.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserVideoScreen extends StatefulWidget {
  const UserVideoScreen({Key? key}) : super(key: key);

  @override
  State<UserVideoScreen> createState() => _UserVideoScreenState();
}

class _UserVideoScreenState extends State<UserVideoScreen> {
  late VideosCubit videosCubit;

  @override
  void initState() {
    videosCubit = context.read<VideosCubit>()
      ..initMyController(context)
      ..getVideos(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        //backgroundColor: Theme.of(context).primaryColor,
        drawer: const NavigationDrawer(),

        appBar: PreferredSize(
            preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
            child: const CustomAppBar(
              back: true,
              title: 'videos',
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<VideosCubit>().addNewVideo();
          },
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
        ),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black, Colors.black45],
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  tileMode: TileMode.clamp)),
          child: BlocBuilder<VideosCubit, VideosState>(
            builder: (context, state) {
              if (state is VideosLoading) {
                return const LoaderWidget(
                  color: Colors.white,
                );
              }
              if (videosCubit.videos.isEmpty) {
                return Center(
                  child: Text(
                    'didnt_add_video'.translate,
                    style:
                        MainTheme.authTextStyle.copyWith(color: Colors.white),
                  ),
                );
              }
              return Container(
                width: Sizes.screenWidth(),
                decoration: const BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.r),
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      runAlignment: WrapAlignment.center,
                      alignment: WrapAlignment.center,
                      runSpacing: 10.r,
                      spacing: 10.r,
                      children: List.generate(
                        videosCubit.videos.length,
                        (index) {
                          var videoUrl2 = videosCubit.videos[index].url ?? '';
                          log(videoUrl2, name: 'video_url');
                          return InkWell(
                            onTap: () {
                              NavigationService.push(
                                  page: BlocProvider.value(
                                value: videosCubit,
                                child: VideoScreen(
                                  videoIndex: index,
                                ),
                              ));
                            },
                            child: VideoItem(
                              videoUrl: videoUrl2,
                            ),
                          );
                          // return VTImageView(
                          //   videoUrl: videoUrl2,
                          //   width: 110.r,
                          //   height: 110.r,
                          //   assetPlaceHolder: 'assets/images/product.jpg',
                          // );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
