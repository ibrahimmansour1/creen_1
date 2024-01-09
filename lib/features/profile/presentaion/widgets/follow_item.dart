import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/core/utils/widgets/chat_screen.dart';
import 'package:creen/core/utils/widgets/custom_awesome_dialog.dart';
import 'package:creen/core/utils/widgets/loader_widget.dart';
import 'package:creen/core/utils/widgets/star.dart';
import 'package:creen/features/follow/viewModel/followers/followers_cubit.dart';
import 'package:creen/features/follow/viewModel/following/following_cubit.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../core/utils/widgets/box_helper.dart';
import '../../../../core/utils/widgets/follow_button.dart';
import '../../../follow/model/user_following_model.dart';
import '../../../follow/viewModel/follow/follow_cubit.dart';
import '../../viewModel/profile/profile_cubit.dart';
import '../pages/my_profile.dart';
import 'package:qr_flutter/qr_flutter.dart';
final double _width =  80.r;

class FollowItem extends StatelessWidget {
  final String? likes;

  const FollowItem({
    Key? key,
    this.likes,
    required this.followingCubit,
    required this.followersCubit, required this.link,
  }) : super(key: key);
  final FollowingCubit followingCubit;
  final FollowersCubit followersCubit;
final String link;
final background = const Color(0xff0e2b33);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
              onTap: () {
                AwesomeDialog(
                  width: 500.r,
                  context: context,
                  customHeader: Container(
                    width: _width,
                    height: _width,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                          HelperFunctions.currentUser!.profile!
                        )
                      )
                    ),

                  ),
                  animType: AnimType.scale,
                  // btnOkText: 'اعاده توجيه'.translate,
                  dialogType: DialogType.info,
                  // btnCancelText: 'مشاركه',
                  // buttonsTextStyle: TextStyle(color: Colors.transparent),
                  // btnCancelIcon: Icons.share,
                  btnOkColor: Colors.transparent,
                  btnCancelColor: Colors.transparent,
                  btnOk: SizedBox(
                    width: 500.r,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            Share.share(
                              link,
                            );
                          },
                          child: SizedBox(width:_width,child: const Icon(Icons.share,color: Colors.white,)),
                        ),

                        InkWell(
                          onTap: (){
                            Clipboard.setData(ClipboardData(
                                text: link));
                          },
                          child: SizedBox(
                              width:_width,child: const Icon(Icons.copy,color: Colors.white,)),
                        ),
                        InkWell(
                          onTap: (){
                            NavigationService.push(
                              page: AllConversationsScreen(
                                link: link,
                              ),
                            );

                          },
                          child: SizedBox(width:_width,child: const Icon(Icons.redo,color: Colors.white,)),
                        ),


                      ],
                    ),
                  ),
                  dialogBackgroundColor: liveBackground,

                  /*btnCancelOnPress: (){

                  },*/
                  body: Center(
                      child: QrImageView(
                    data: 'creen-Program',
                    size: 300,
                        eyeStyle: const QrEyeStyle(color: Colors.white,eyeShape: QrEyeShape.square),
                        dataModuleStyle: const QrDataModuleStyle(color: Colors.white,dataModuleShape: QrDataModuleShape.square),

                        /*embeddedImage: HelperFunctions.currentUser!.profile != null
                        ? NetworkImage(HelperFunctions.currentUser!.profile!)
                        : const AssetImage('assets/images/person_default.png')
                            as ImageProvider<Object>,*/
embeddedImageStyle:  const QrEmbeddedImageStyle(size: Size(100,100)),
gapless: false,
                      )),
              /*    btnOkOnPress: () {
                  },*/
                ).show();
              },
              child: QrImageView(
                data: 'creen-Program',
                size: 60,
              )),
          Column(
            children: [
              Text(
                'likes'.translate,
                style: TextStyle(
                    color: Colors.grey[700],
                    fontFamily: 'Arial',
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                likes ?? '0',
                style: const TextStyle(
                  color: MainStyle.primaryColor,
                  fontFamily: 'Arial',
                  fontSize: 15,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 8,
            ),
            child: Container(
              height: 25,
              width: 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              if (followingCubit.following.isEmpty) {
                return;
              }
              showDialog(
                context: context,
                builder: (context) => FollowerDialog(
                    followingCubit: followingCubit,
                    followersCubit: followersCubit,
                    initialIndex: 0),
              );
            },
            child: Column(
              children: [
                Text(
                  'following'.translate,
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontFamily: 'Arial',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                BlocBuilder<FollowingCubit, FollowingState>(
                  builder: (context, state) {
                    // if (state is FollowersLoading) {
                    //   return const LoaderWidget();
                    // }
                    return Text(
                      followingCubit.followingCounter.toString(),
                      style: const TextStyle(
                        color: MainStyle.primaryColor,
                        fontFamily: 'Arial',
                        fontSize: 15,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 8,
            ),
            child: Container(
              height: 25,
              width: 1,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              // if (followersCubit.followers.isEmpty) {
              //   return;
              // }
              showDialog(
                context: context,
                builder: (context) => FollowerDialog(
                  followingCubit: followingCubit,
                  followersCubit: followersCubit,
                  initialIndex: 1,
                ),
                //  BlocProvider.value(
                //   value: followersCubit,
                //   child: FollowersDialog(
                //     following: followersCubit.followers
                //         .where((element) => element.userFollowers != null)
                //         .map((e) => e.userFollowers!)
                //         .toList(),
                //   ),
                // ),
              );
            },
            child: Column(
              children: [
                Text(
                  'followers'.translate,
                  style: TextStyle(
                      color: Colors.grey[700],
                      fontFamily: 'Arial',
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                BlocBuilder<FollowersCubit, FollowersState>(
                  builder: (context, state) {
                    return Text(
                      followersCubit.followersCounter.toString(),
                      style: const TextStyle(
                        color: MainStyle.primaryColor,
                        fontFamily: 'Arial',
                        fontSize: 15,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const StarIcon(
            size: 100,
          ),
        ],
      ),
    );
  }
}

class FollowerDialog extends StatelessWidget {
  const FollowerDialog({
    super.key,
    required this.followingCubit,
    required this.followersCubit,
    required this.initialIndex,
  });

  final FollowingCubit followingCubit;
  final FollowersCubit followersCubit;
  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: followingCubit,
        ),
        BlocProvider.value(
          value: followersCubit,
        ),
      ],
      child: FollowersDialog(
        initialIndex: initialIndex,
        following: followingCubit.following
            .where((element) => element.userFollowing != null)
            .map((e) => e.userFollowing!)
            .toList(),
        followers: followersCubit.followers
            .where((element) => element.userFollowers != null)
            .map((e) => e.userFollowers!)
            .toList(),
      ),
    );
  }
}

class FollowersDialog extends StatefulWidget {
  const FollowersDialog({
    Key? key,
    required this.following,
    required this.followers,
    required this.initialIndex,
  }) : super(key: key);
  final List<UserFollowers> following;
  final List<UserFollowers> followers;
  final int initialIndex;

  @override
  State<FollowersDialog> createState() => _FollowersDialogState();
}

class _FollowersDialogState extends State<FollowersDialog>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  bool fullScreen = false;

  @override
  void initState() {
    controller = TabController(
      length: 2,
      vsync: this,
    )..index = widget.initialIndex;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return Dialog(
        insetPadding: !fullScreen
            ? EdgeInsets.symmetric(horizontal: 40.0.r, vertical: 24.0.r)
            : EdgeInsets.zero,
        child: BoxHelper(
          height: fullScreen ? null : 250,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TabBar(
                      controller: controller,
                      tabs: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            // horizontal: 15.r,
                            vertical: 10.r,
                          ),
                          child: Text(
                            'following'.translate,
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontFamily: 'Arial',
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            // horizontal: 15.r,
                            vertical: 10.r,
                          ),
                          child: Text(
                            'followers'.translate,
                            style: TextStyle(
                                color: Colors.grey[700],
                                fontFamily: 'Arial',
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          setState(() {
                            fullScreen = !fullScreen;
                          });
                        },
                        icon: const Hero(
                          tag: 'full_screen',
                          child: Icon(
                            Icons.fullscreen,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              Expanded(
                child: TabBarView(
                  controller: controller,
                  children: [
                    BlocBuilder<FollowingCubit, FollowingState>(
                      builder: (context, state) {
                        return ListView.builder(
                          itemCount: widget.following.length,
                          itemBuilder: (context, index) {
                            var user = widget.following[index];
                            return FollowerUserItem(user: user);
                          },
                        );
                      },
                    ),
                    BlocBuilder<FollowersCubit, FollowersState>(
                      builder: (context, state) {
                        return ListView.builder(
                          itemCount: widget.followers.length,
                          itemBuilder: (context, index) {
                            var user = widget.followers[index];
                            return FollowerUserItem(
                              user: user,
                              showFollowButton: true,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class FollowerUserItem extends StatelessWidget {
  const FollowerUserItem({
    super.key,
    required this.user,
    this.showFollowButton = false,
  });

  final UserFollowers user;
  final bool showFollowButton;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Visibility(
        visible: showFollowButton,
        child: BlocConsumer<FollowCubit, FollowState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is FollowLoading) {
              return const LoaderWidget();
            }
            return user.isFollow! ? const SizedBox():SizedBox(
              width: MediaQuery.of(context).size.width*.2,
              height: MediaQuery.of(context).size.height*.05,
              child: FollowButton(
                  onPressed: () {
                    context.read<FollowCubit>().follow(
                          context,
                          userId: user.id,
                          isFollow: user.isFollow ?? false,
                        );
                  },
                  isFollow: user.isFollow ?? false),
            );
          },
        ),
      ),
      onTap: () {
        NavigationService.push(
          page: MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) => FollowingCubit(
                  userId: user.id,
                ),
              ),
              BlocProvider(
                create: (_) => FollowersCubit(
                  userId: user.id,
                ),
              ),
              BlocProvider(
                create: (_) => ProfileCubit(
                  userId: user.id,
                ),
              ),
            ],
            child: const MyProfileScreen(),
          ),
          isNamed: false,
        );
      },
      leading: CircleAvatar(
        radius: 25.r,
        backgroundImage: NetworkImage(user.profile ?? ''),
      ),
      title: Text(
        user.name ?? '',
        style: MainTheme.authTextStyle.copyWith(
          fontSize: 15.r,
        ),
      ),
      subtitle: Text(
        user.about ?? '',
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }
}
