
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/responsive/responsive_service.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/core/utils/widgets/loader_widget.dart';
import 'package:creen/features/chat/all_stories_screen.dart';
import 'package:creen/features/chat/components/home_components/components/story_item.dart';
import 'package:creen/features/chat/components/home_components/components/story_text_screen.dart';
import 'package:creen/features/chat/components/home_components/components/view_story_screen.dart';
import 'package:creen/features/chat/viewModel/stories/stories_cubit.dart';
import 'package:creen/features/localization/manager/app_localization.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../../core/utils/widgets/box_helper.dart';
// import 'package:story_designer/story_designer.dart';
// import 'package:whatsapp_story_editor/whatsapp_story_editor.dart';

class StoryScreenUI extends StatelessWidget {
   StoryScreenUI({
    Key? key,
    required this.storiesCubit,
  }) : super(key: key);
  final StoriesCubit storiesCubit;
  int ColorValue = 0;

  @override
  Widget build(BuildContext context) {
    const color2 = Color(0xFF3B9889);
    return Directionality(
      textDirection: localization.currentLanguage.toString() == "en"
          ? TextDirection.ltr
          : TextDirection.rtl,
      child: SizedBox(
        height:100.r,
        width: ResponsiveService.screenWidth,
        child: Padding(
          padding: const EdgeInsets.symmetric( vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:8.0),
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StoryTextScreenUI(storiesCubit: storiesCubit,)));
//                         List<File>? data = await Navigator.of(context).push(
//                           MaterialPageRoute(
//                             builder: (BuildContext context) => CameraApp(
// //multiple image selection flag
//                                 isMultiple: true),
//                           ),
//                         );
                     /*   List<File>? pickFiles =
                            await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const WhatsappCamera(
                              multiple: false,
                            ),
                          ),
                        );
                        if (pickFiles == null) {
                          return;
                        }
                        var data = await NavigationService.push(
                            page: CreateStoryView(
                          pickedImage: pickFiles.first,
                        ));

                        storiesCubit.createNewStory(
                          image: pickFiles.first,
                          description: data,
                        );
*/
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) =>
                        //           const WhatsappStoryEditor()),
                        // ).then((whatsappStoryEditorResult) {
                        //   if (whatsappStoryEditorResult != null) {
                        //     // Navigator.push(
                        //     //   context,
                        //     //   MaterialPageRoute(
                        //     //       builder: (context) => SavedImageView(
                        //     //             image: whatsappStoryEditorResult.image,
                        //     //             caption:
                        //     //                 whatsappStoryEditorResult.caption,
                        //     //           )),
                        //     // );
                        //   }
                        // });
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => StoryDesigner(
                        //       filePath: pickFiles.first.path,
                        //     ),
                        //   ),
                        // );
                      },
                      child: CircleAvatar(
                        backgroundColor: color2,
                        radius: 26.r,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 25.r,
                        ),
                      ),
                    ),
                    const BoxHelper(height: 5),
                    Text(
                      "add_status".translate,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    )
                  ],
                ),
              ),
              BlocBuilder<StoriesCubit, StoriesState>(
                builder: (context, state) {
                  if (state is StoriesLoading) {
                    return const LoaderWidget(
                      color: Colors.white,
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        primary: false,
                        shrinkWrap: true,
                        itemCount: storiesCubit.stories.length + 1,
                        itemBuilder: (context, index) {
                          // storiesCubit.stories.length //

                          if (index == storiesCubit.stories.length) {
                            return Visibility(
                              visible: storiesCubit.stories.length > 4,
                              child: InkWell(
                                onTap: () {
                                  NavigationService.push(
                                    page: BlocProvider.value(
                                        value: context.read<StoriesCubit>(),
                                        child: const AllStoriesScreen()),
                                  );
                                },
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.r),
                                  child: Column(
                                    children: [
                                      Text(
                                        'more'.translate,
                                        style: TextStyle(
                                          color: color2,
                                          fontSize: 20.r,
                                        ),
                                      ),
                                      Icon(
                                        Icons.more_horiz,
                                        color: color2,
                                        size: 20.r,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                          var story = storiesCubit.stories[index];
                          var isMe =
                              story.id == HelperFunctions.currentUser?.id;
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
                            child: Stack(
                              children: [
                                StoryItem(
                                  userName: story.name!,
                                  seen: false,
                                  profileImage: story.profile,
                                    ColorValue:     ColorValue = ColorValue >= 17 ? 0 : ColorValue += 1,
                                ),
                                if (isMe && state is CreateNewStoryLoading)
                                  Positioned(
                                    top: 0,
                                    // left: 2.r,
                                    right: 6.r,
                                    bottom: 30.r,
                                    child: Center(
                                      child: Transform.scale(
                                        scale: 0.7,
                                        child: const LoaderWidget(
                                            // color: Colors.white,
                                            ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        }),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
