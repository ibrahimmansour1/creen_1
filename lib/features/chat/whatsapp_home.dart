import 'dart:io';

import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/features/chat/components/home_components/chat_screen_ui.dart';
import 'package:creen/features/chat/components/home_components/components/story_screen_ui.dart';
import 'package:creen/features/chat/model/group_request_model.dart';
import 'package:creen/features/chat/viewModel/allConversations/all_conversations_cubit.dart';
import 'package:creen/features/chat/viewModel/stories/stories_cubit.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/utils/routing/route_paths.dart';
import '../../core/utils/widgets/box_helper.dart';
late AllConversationsCubit allConversationsCubit;

class WhatsappHome extends StatefulWidget {
   const WhatsappHome({Key? key}) : super(key: key);

  @override
   WhatsappHomeState createState() => WhatsappHomeState();
}

class WhatsappHomeState extends State<WhatsappHome> {
  late StoriesCubit storiesCubit;
  @override
  void initState() {
    super.initState();
    allConversationsCubit = context.read<AllConversationsCubit>()
      ..initScroller()
      ..getAllConversations();

    storiesCubit = context.read<StoriesCubit>()
      ..initListener()
      ..getStories();
  }
  // TabController? _tabController;

  // @override
  // void initState() {
  //   super.initState();
  //   _tabController = TabController(length: 4, vsync: this);
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _tabController!.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainStyle.primaryColor,
      // floatingActionButton:
      //     BlocBuilder<AllConversationsCubit, AllConversationsState>(
      //   builder: (context, state) {
      //     var isLoading = state is CreateTeamLoading;
      //     return FloatingActionButton(
      //       onPressed: isLoading
      //           ? null
      //           : () {
      //               showModalBottomSheet(
      //                 context: context,
      //                 builder: (context) => const AddGroupSheet(),
      //               ).then((value) {
      //                 allConversationsCubit.createNewTeam(
      //                   body: value,
      //                 );
      //               });
      //             },
      //       backgroundColor: Colors.black,
      //       child: isLoading
      //           ? const CircularProgressIndicator(
      //               color: Colors.white,
      //             )
      //           : const Icon(Icons.add),
      //     );
      //   },
      // ),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          onPressed: () {
            // NavigationService.goBack();
            Navigator.pushNamedAndRemoveUntil(context, RoutePaths.mainPage, (route) => false);
          },
          color: Colors.white,
        ),
        elevation: 0,
        title: Text(
          "chats".translate,
          style: MainTheme.appBarTextStyle,
        ),
        centerTitle: true,
        backgroundColor: MainStyle.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
            color: Colors.white,
          ),
          PopupMenuButton(
            itemBuilder: (context) => [
              HelperFunctions.buildPopupMenu(
                icons: Icons.add,
                title: 'create_new_group'.translate,
                value: 'create_group',
              ),
              HelperFunctions.buildPopupMenu(
                icons: Icons.settings,
                title: 'status_settings'.translate,
                value: 'status_settings',
              )
            ],
            onSelected: (value) {
              if (value == 'create_group') {
                showModalBottomSheet(
                  context: context,
                  builder: (_) => BlocProvider<AllConversationsCubit>.value(
                    value: allConversationsCubit,
                    child: const AddGroupSheet(),
                  ),
                ).then((value) {
                  if (value == null) {
                    return;
                  }
                  allConversationsCubit.createNewTeam(
                    body: value,
                  );
                });
              }
              else if(value == "status_settings"){
                showModalBottomSheet(
                  context: context,
                  builder: (_) => BlocProvider<AllConversationsCubit>.value(
                    value: allConversationsCubit,
                    child: const StatusSettings(),
                  ),
                ).then((value) {
                  if (value == null) {
                    return;
                  }
                  /*allConversationsCubit.createNewTeam(
                    body: value,
                  );*/
                });
              }
            },
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => allConversationsCubit.getAllConversations(init: true),
        child: Column(
          children: [
            StoryScreenUI(
              storiesCubit: storiesCubit,
            ),
            const Expanded(child: ChatScreenUI()),
          ],
        ),
      ),

      // floatingActionButton: BottomNavigation(tabController: _tabController),
      // floatingActionButtonLocation:
      //     FloatingActionButtonLocation.miniCenterFloat,
    );
  }
}

class AddGroupSheet extends StatefulWidget {
  const AddGroupSheet({
    super.key,
  });

  @override
  State<AddGroupSheet> createState() => _AddGroupSheetState();
}

class _AddGroupSheetState extends State<AddGroupSheet> {
  final formKey = GlobalKey<FormState>();
  var groupNameController = TextEditingController();
  List<int> selectedIds = [];
  File? pickedImage;

  @override
  void dispose() {
    groupNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var validate = formKey.currentState?.validate() ?? false;
          if (!validate) {
            return;
          }
          NavigationService.goBack(
            result: GroupRequestModel(
              groupName: groupNameController.text,
              image: pickedImage,
            ).toJson(),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.check,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0.r),
              child: Text(
                'create_new_group'.translate,
                style: MainTheme.authTextStyle,
              ),
            ),
            Row(
              textDirection: HelperFunctions.isArabic?TextDirection.rtl:TextDirection.ltr,
              children: [
                StatefulBuilder(builder: (context, setState) {
                  return InkWell(
                    onTap: () async {
                      var selectImages = await HelperFunctions.selectImages(
                        imageCount: 1,
                        showCamera: true,
                      );
                      if (selectImages.isEmpty) {
                        return;
                      }
                      setState(() {
                        pickedImage = selectImages.first;
                      });
                    },
                    child: Container(
                        margin: EdgeInsets.all(8.r),
                        height: 60.r,
                        width: 60.r,
                        decoration: BoxDecoration(
                            color: pickedImage == null
                                ? MainStyle.lightGreyColor
                                : null,
                            border: pickedImage == null ? null : Border.all(),
                            shape: BoxShape.circle),
                        child: pickedImage != null
                            ? ClipOval(
                                child: Image.file(
                                  pickedImage!,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 30.r,
                              )),
                  );
                }),
                Expanded(
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'group_name'.translate,
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 2.r),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: MainStyle.lightGreyColor, width: 2.r),
                        ),
                      ),
                      controller: groupNameController,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'required_group_name'.translate;
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const BoxHelper(
                  width: 25,
                ),
              ],
            ),
            Align(
              alignment: HelperFunctions.appAlignment,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15.r,
                  vertical: 5.r,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'members'.translate,
                      style: MainTheme.appBarTextStyle.copyWith(
                        color: Colors.black,
                      ),
                    ),
                    const BoxHelper(
                      height: 15,
                    ),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: List.generate(
                        allConversationsCubit.conversations.length,
                        (index) {
                          // print("teamstatus =======> ${allConversationsCubit.conversations[index].status}\n\n\n\n\n\n\n");
                          if(allConversationsCubit.conversations[index].recieverm?.name !=null  ) {
                          // if(/*allConversationsCubit.conversations[index].recieverm?.name !=null &&*/ allConversationsCubit.conversations[index].status !=null) {
                            return GroupUserItem(
                          isSelected: selectedIds
                                  .indexWhere((element) => element == index) >=
                              0,
                          onPressed: () {
                            var id = index;
                            var selectedIndex = selectedIds
                                .indexWhere((element) => element == id);
                            if (selectedIndex >= 0) {
                              selectedIds.removeAt(selectedIndex);
                            } else {
                              selectedIds.add(id);
                            }
                            setState(() {});
                          }, name: "${(HelperFunctions.currentUser!.id==allConversationsCubit.conversations[index].recieverm?.id)?allConversationsCubit.conversations[index].sender?.name:allConversationsCubit.conversations[index].recieverm?.name}", profile: (HelperFunctions.currentUser!.id==allConversationsCubit.conversations[index].recieverm?.id)?allConversationsCubit.conversations[index].sender?.profile:allConversationsCubit.conversations[index].recieverm?.profile,
                        );
                          }
                          else{
                            return GroupUserItem(
                              isSelected: false,
                              onPressed: () {

                              }, name: "", profile: "0",
                            );
                          }

                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // BoxHelper(
            //   width: 200,
            //   child: RegisterButton(
            //     radius: 10,
            //     title: 'save',
            //     onPressed: () {

            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}

class StatusSettings extends StatefulWidget {
  const StatusSettings({Key? key}) : super(key: key);

  @override
  State<StatusSettings> createState() => _StatusSettingsState();
}

class _StatusSettingsState extends State<StatusSettings> {
  Key? formKey = GlobalKey<FormState>();
  bool statusShow = false;
  String statusKind ="only_followers".translate;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {  },
      child: const Icon(Icons.save),

      ),
      body: Column(
        children: [
          Row(
            children: [
               Text("status_show".translate),
              Switch.adaptive(value: statusShow, onChanged: (v){
                setState(() {
                  statusShow = v;
                });
                if(!statusShow){

                }
                else{

                }
              })
            ],
          ),
          if(statusShow)
          SizedBox(
            height: 50,
            child: PopupMenuButton(
              itemBuilder: (context) => [
                HelperFunctions.buildPopupMenu(
                  icons: Icons.person,
                  title: 'only_followers'.translate,
                  value: 'only_followers',
                ),
                HelperFunctions.buildPopupMenu(
                  icons: Icons.public,
                  title: 'public'.translate,
                  value: 'public',
                )
              ],
              onSelected: (value) {
                  if(value == 'only_followers'){
                    setState(() {
                    statusKind  ="only_followers".translate;
                    });
                  }
                  else if(value == 'public'){
                    setState(() {
                      statusKind = 'public'.translate;
                    });
                  }
              },
              iconSize: 150,
              icon: Text("status $statusKind"),
            ),
          ),
        ],
      ),
    );
  }
}


class GroupUserItem extends StatelessWidget {
  const GroupUserItem({
    super.key,
    required this.isSelected,
    required this.onPressed,
    required this.name,
    required this.profile,
  });
  final bool isSelected;
  final String  name;
  final String? profile;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if(profile !="0")...[Column(
          children: [
            InkWell(
              onTap: onPressed,
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 24.r,
                    backgroundImage: image(profile),

                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Visibility(
                      visible: isSelected,
                      child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.black38,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ],
              ),
            ),
            const BoxHelper(
              height: 5,
            ),
            Text(
              name,
              style: MainTheme.appBarTextStyle.copyWith(
                color: MainStyle.darkGreyColor,
                fontWeight: FontWeight.normal,
              ),
            ),
            const BoxHelper(
              height: 8,
            ),
          ],
        ),
        const BoxHelper(
          width: 18,
        ),]
      ],
    );
  }
}


ImageProvider<Object> image(String? pr){
  if(pr==null) {
    return const AssetImage(personProfile);
  } else {
    return NetworkImage(pr);
  }
}
