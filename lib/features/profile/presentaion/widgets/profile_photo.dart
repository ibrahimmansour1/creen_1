import 'dart:developer';

import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/routing/route_paths.dart';
import 'package:creen/core/utils/widgets/follow_button.dart';
import 'package:creen/core/utils/widgets/loader_widget.dart';
import 'package:creen/core/utils/widgets/register_button.dart';
import 'package:creen/features/block/cubit/bloc_cubit.dart';
import 'package:creen/features/follow/viewModel/follow/follow_cubit.dart';
import 'package:creen/features/profile/viewModel/profile/profile_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/themes/enums.dart';
import '../../../../core/utils/functions/helper_functions.dart';
import '../../../../core/utils/routing/navigation_service.dart';
import '../../../../core/utils/widgets/box_helper.dart';
import '../../../../core/utils/widgets/custom_awesome_dialog.dart';
import '../../../../core/utils/widgets/report_dialog.dart';
import '../../../reports/viewModel/createReport/create_report_cubit.dart';

class ProfilePhoto extends ConsumerWidget {
  final String? name, prImage, bgImage, mail;
  final bool? isMe;
  final bool isFollow;
  final int? userId;
  final ProfileCubit profileCubit;
  final bool blocked;
  final int? blockId;

  const ProfilePhoto({
    Key? key,
    this.name,
    this.prImage,
    this.bgImage,
    this.mail,
    this.isMe,
    this.userId,
    this.isFollow = false,
    this.blocked = false,
    this.blockId ,
    required this.profileCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    log('isFollow $isFollow');
    log("block $blocked  && block id $blockId");
    return BlocConsumer<ProfileCubit,ProfileState>( builder: (context, state) {
      return SizedBox(
        height: Sizes.screenHeight() * 0.42,
        width: Sizes.screenHeight(),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Image(
              image: profileCubit.pickedCoverImage != null
                  ? FileImage(profileCubit.pickedCoverImage!)
                  : bgImage == null
                  ? const AssetImage('assets/images/2.jpeg')
                  : NetworkImage(bgImage!) as ImageProvider,
              height: Sizes.screenHeight() * 0.27,
              width: Sizes.screenHeight(),
              fit: BoxFit.fill,
            ),
            // Positioned(
            //   left: 120.r,
            //   right: 120.r,
            //   top: 2.r,
            //   child:
            // ),
            Positioned(
                left: 10,
                right: 10,
                bottom: 104.r,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if(!isMe!)
                      PopupMenuButton(
                        onSelected: (value) {
                          if (value == 'block') {
                            print("block");
                            CustomAwesomeDialog().showOptionsDialog(
                              context: context,
                              message: profileCubit.blocked?'block_delete_user_confirm'.translate:'block_user_confirm'.translate,
                              btnOkText: profileCubit.blocked?'delete_block':'block',
                              btnCancelText: 'cancel',
                              onConfirm: () {

                                submitBlock(blockType: ReportType.user, blockTypeId: profileCubit.blocked?profileCubit.blockId!:profileCubit.userId!,block: profileCubit.blocked);
                                // print("ui block ${profileCubit.blocked}");

                              },
                              type: DialogType.warning,
                            );
                            // deleteIconTap();
                          }
                          else if(value == 'report'){
                            print("report");
                            showDialog(
                              context: context,
                              builder: (context) =>
                                  BlocProvider(
                                    create: (context) => CreateReportCubit(),
                                    child: ReportDialog(
                                      reportType: ReportType.user,
                                      reportTypeId: userId,
                                    ),
                                  ),
                            );
                          }
                        },
                        position: PopupMenuPosition.under,
                        itemBuilder: (_) {
                          /* var isMe = userId ==
                              HelperFunctions.currentUser?.id;
*/
                          return [

                            HelperFunctions.buildPopupMenu(
                              icons: Icons.block,
                              title: 'block',
                              value: 'block',
                            ),



                            HelperFunctions.buildPopupMenu(
                              icons: Icons.report,
                              title: 'report',
                              value: 'report',
                            ),

                          ];
                        },
                        child: const CircleAvatar(
                          backgroundColor: Colors.black26,
                          child: Icon(
                            Icons.report,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    // CircleAvatar(
                    //   backgroundColor: Colors.black26,
                    //   child: Icon(
                    //     Icons.share,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    Visibility(
                      visible: isMe!,
                      child: Row(
                        textDirection: TextDirection.rtl,
                        children: [
                          Visibility(
                            visible: profileCubit.showSubmitButton,
                            child: state is UpdateProfileLoading
                                ? const LoaderWidget(
                              color: Colors.white,
                            )
                                : BoxHelper(
                              height: 40,
                              width: 60,
                              child: RegisterButton(
                                onPressed: () =>
                                    profileCubit.updateProfile(context),
                                title: 'save',
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              profileCubit.pickCoverImage();
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: const BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            Positioned(
              top: Sizes.screenHeight() * 0.18,
              child: Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 48,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 45,
                          backgroundColor: Colors.white,
                          backgroundImage: profileCubit.pickedProfileImage !=
                              null
                              ? FileImage(profileCubit.pickedProfileImage!)
                              : prImage == null
                              ? const AssetImage(personProfile)
                              : NetworkImage(prImage!) as ImageProvider,
                        ),
                      ),
                      Visibility(
                        visible: isMe!,
                        child: Positioned(
                          right: 0,
                          bottom: 0,
                          child: InkWell(
                            onTap: () {
                              profileCubit.pickProfileImage();
                            },
                            child: const CircleAvatar(
                              radius: 17,
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.mode_edit_outlined,
                                color: MainStyle.primaryColor,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    name!,
                    style: MainTheme.authTextStyle.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 18),
                  ),
                  Text(
                    mail ?? '',
                    style: MainTheme.authTextStyle.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.normal,
                        fontSize: 12),
                  ),
                ],
              ),
            ),
            Positioned(
              top: Sizes.screenHeight() * 0.30,
              right: !HelperFunctions.isArabic?Sizes.screenHeight() * 0.05:null,
              left: HelperFunctions.isArabic?Sizes.screenHeight() * 0.05:null,
              child: isMe == true
                  ? InkWell(
                onTap: () {
                  // log('nnnnnnannananan');
                  NavigationService.push(
                    page: RoutePaths.bmiTabs,
                    isNamed: true,
                  );
                  // NavigationService.push(
                  //   page: const BMICalcScreen(),
                  //   isNamed: false,
                  // );

                  // HelperFunctions.showComingSoonDialog(context);
                },
                child: Icon(
                  Icons.run_circle_outlined,
                  size: ScreenUtil().radius(50),
                  color: Theme.of(context).primaryColor,
                ),
              )
                  : BlocBuilder<FollowCubit, FollowState>(
                builder: (context, state) {
                  if (state is FollowLoading) {
                    return const LoaderWidget();
                  }
                  return BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      if (kDebugMode) {
                        print("isFollow $isFollow");
                      }

                      return FollowButton(
                        isFollow: isFollow,
                        onPressed: () {
                          // print("userId ${userId}");
                          context.read<FollowCubit>().follow(
                            context,
                            isFollow: isFollow,
                            userId: userId,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Positioned(
                top: Sizes.screenHeight() * 0.30,
                right: !HelperFunctions.isArabic?Sizes.screenHeight() * 0.38:null,
                left: HelperFunctions.isArabic?Sizes.screenHeight() * 0.38:null,
                child: Row(
                  children: [
                    Switch(value: profileCubit.darkMode, onChanged: (bool value) {
                      profileCubit.changeDarkMode(isDarkMode: value);
                    },activeColor: Colors.green,),

                    Image.asset('assets/images/dark_mode.jpeg',width: 30,height: 30,),
                  ],
                )
            ),
          ],
        ),
      );
    },listener: (context, state) {});
  }
}
