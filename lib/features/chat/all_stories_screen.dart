import 'package:creen/features/chat/viewModel/stories/stories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/responsive/sizes.dart';
import '../../core/utils/routing/navigation_service.dart';
import '../../core/utils/widgets/custom_appbar.dart';
import 'components/home_components/components/story_item.dart';
import 'components/home_components/components/view_story_screen.dart';

class AllStoriesScreen extends StatefulWidget {
  const AllStoriesScreen({Key? key}) : super(key: key);

  @override
  State<AllStoriesScreen> createState() => _AllStoriesScreenState();
}

class _AllStoriesScreenState extends State<AllStoriesScreen> {
  late StoriesCubit storiesCubit;
int ColorValue = 0;
  @override
  void initState() {
    storiesCubit = context.read<StoriesCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
        child: const CustomAppBar(
          title: 'stories',
          back: true,
          removeBottomBorderColor: true,
        ),
      ),
      body: SingleChildScrollView(
        child: Wrap(
            children: List.generate(
          storiesCubit.stories.length,
          (index) {
            var story = storiesCubit.stories[index];

            return InkWell(
              onTap: () {
                NavigationService.push(
                  page: BlocProvider.value(
                    value: storiesCubit,
                    child: ViewStoryScreen(
                      initStoryPage: index,
                    ),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(4.r),
                child: StoryItem(
                  profileImageSize: 50,
                  // textColor: Colors.black,
                  userName: story.name!,
                  seen: false,
                  profileImage: story.profile ,
                  ColorValue:     ColorValue = ColorValue >= 17 ? 0 : ColorValue += 1
                  ,
                ),
              ),
            );
          },
        )),
      ),
    );
  }
}
