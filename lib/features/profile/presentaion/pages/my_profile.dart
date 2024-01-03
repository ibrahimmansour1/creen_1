import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/core/utils/routing/route_paths.dart';
import 'package:creen/core/utils/widgets/app_loader.dart';
import 'package:creen/core/utils/widgets/chat_screen.dart';
import 'package:creen/core/utils/widgets/custom_appbar.dart';
import 'package:creen/core/utils/widgets/custom_awesome_dialog.dart';
import 'package:creen/core/utils/widgets/live_button.dart';
import 'package:creen/features/Auth/viewModel/deleteAccount/delete_account_cubit.dart';
import 'package:creen/features/Auth/viewModel/logout/logout_cubit.dart';
import 'package:creen/features/drawer/presentaion/pages/naviigation_drawer.dart';
import 'package:creen/features/follow/viewModel/followers/followers_cubit.dart';
import 'package:creen/features/follow/viewModel/following/following_cubit.dart';
import 'package:creen/features/profile/presentaion/widgets/follow_item.dart';
import 'package:creen/features/profile/presentaion/widgets/profile_item.dart';
import 'package:creen/features/profile/presentaion/widgets/profile_photo.dart';
import 'package:creen/features/profile/viewModel/profile/profile_cubit.dart';
import 'package:creen/features/videos/presentaion/pages/add_video.dart';
import 'package:creen/features/videos/viewModel/videos/videos_cubit.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

import '../../../chat/components/chat_components/components/all_messages_screend.dart';
import '../../../chat/viewModel/allConversations/all_conversations_cubit.dart';
import '../../../start_live/presentation/pages/main_start_live.dart';
import 'edit_profile_screen.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  late FollowingCubit followingCubit;
  late FollowersCubit followersCubit;
  late ProfileCubit profileCubit;
  late bool canPop;

  @override
  void initState() {
    canPop = Navigator.canPop(context);
    profileCubit = context.read<ProfileCubit>()..getProfile(context);
    followersCubit = context.read<FollowersCubit>()
      ..getFollowers(
        context,
      );
    followingCubit = context.read<FollowingCubit>()
      ..getFollowing(
        context,
      );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("user id ${profileCubit.isMe}");
    return SafeArea(
      child: Scaffold(
        drawer: const NavigationDrawer(),
      
        // appBar: PreferredSize(
        //     preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
        //     child: CustomAppBar(
        //       back: canPop,
        //       title: 'profile',
        //     )),
        //backgroundColor: Colors.amber,
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const AppLoader();
            }
            return ListView(
              children: [
                ProfilePhoto(
                  name: profileCubit.profileData?.name ?? '',
                  bgImage: profileCubit.profileData?.cover,
                  prImage: profileCubit.profileData?.profile,
                  mail: profileCubit.profileData?.email,
                  isMe: profileCubit.isMe,
                  userId: profileCubit.userId,
                  isFollow: profileCubit.profileData?.isFollow??false,
                  profileCubit: profileCubit,
                  blocked: profileCubit.blocked,
                  blockId: profileCubit.blockId,
                ),
                const SizedBox(
                  height: 20,
                ),
                FollowItem(
                  followersCubit: followersCubit,
                  followingCubit: followingCubit,
                  //TODO: deep link to profile screen
                  link: HelperFunctions.currentUser!.name!,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.r, vertical: 30.r),
                  child: Column(
                    children: [
                      Wrap(
                        runSpacing: 10.r,
                        spacing: 5.r,
                        children: [
                          ProfileItem(
                              ImageIcon(
                                const AssetImage('assets/images/posts.png'),
                                // height: 40.r,
                                size: 35.r,
                              ),
                              'blogs', () {
                            NavigationService.push(
                              page: RoutePaths.myBlogs,
                              isNamed: true,
                              arguments: profileCubit.profileData?.id,
                            );
                          }),
                          ProfileItem(
                            // Image.asset(
                            //   ('assets/images/khater.png'),
                            //   height: 35.r,
                            //   width: 35.r,
                            //   fit: BoxFit.cover,
                            // ),
                            const LiveButton(
                              backgroundColor: Colors.red, textColor: Colors.white,
                            ),
                            'live',
                            () {
                              Navigator.push(context,MaterialPageRoute(builder: (context)=> MainStartLive()));
      
                              // HelperFunctions.showComingSoonDialog(context);
                            },
                            showSizedBox: false,
                          ),
                          ProfileItem(
                            const Icon(Icons.play_circle_fill_outlined),
                            'video',
                            () {
                              NavigationService.push(
                                  page: BlocProvider(
                                    create: (context) => VideosCubit(
                                      userId: profileCubit.profileData?.id,
                                    ),
                                    child: const UserVideoScreen(),
                                  ),
                                  isNamed: false);
                            },
                          ),
                          ProfileItem(
                              const ImageIcon(AssetImage('assets/images/bag.png')),
                              profileCubit.isMe?'my_products'
                              :"prod"
      
                              , () {
                            // HelperFunctions.showComingSoonDialog(context);
                            // return;
                            // print("ggggggggg ${profileCubit.profileData?.id.runtimeType}");
                            NavigationService.push(
                              // page: RoutePaths.myProducts,
                              page: RoutePaths.myProducts,
                              isNamed: true,
                              arguments: profileCubit.isMe?1:0,
                            );
                            // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyProductsScreen(isMe:profileCubit.isMe)));
                          }),
                          ProfileItem(
                              const ImageIcon(AssetImage('assets/images/14.png')),
                              profileCubit.isMe?'my_ads':"advertise", () {
                            NavigationService.push(
                              page: RoutePaths.myAds,
                              isNamed: true,
                              arguments: profileCubit.profileData?.id,
                            );
      
                            // HelperFunctions.showComingSoonDialog(context);
                          }),
                          ProfileItem(
                              const ImageIcon(AssetImage('assets/images/15.png')),
                              'services', () {
                            // HelperFunctions.showComingSoonDialog(context);
                          }),
                          ProfileItem(
                              Image(
                                image: const AssetImage(
                                    'assets/images/chat_icon.png'),
                                // color: Colors.black,
                                height: 27.r,
                                width: 27.r,
                              ),
                              'chats', () {
                            if (!profileCubit.isMe) {
                              NavigationService.push(
                                page: AllMessagesScreen(
                                  conversationId: null,
                                  timeAgo: null,
                                  allConversationsCubit: AllConversationsCubit(),
                                  profilePic: profileCubit.profileData?.profile,
                                  userName: profileCubit.profileData?.name,
                                  recieverId: profileCubit.profileData?.id,
                                ),
                              );
                              return;
                            }
                            NavigationService.push(
                              page: const AllConversationsScreen(),
                            );
                          }),
                          if (profileCubit.isMe) ...[
                            ProfileItem(
                              const ImageIcon(
                                  AssetImage('assets/images/wallet.png')),
                              'wallet',
                              () {
                                NavigationService.push(
                                  page: RoutePaths.myWallets,
                                  isNamed: true,
                                );
                              },
                            ),
                            ProfileItem(
                                const Icon(Icons.shopping_cart_rounded), 'cart',
                                () {
                              // HelperFunctions.showComingSoonDialog(context);
                              NavigationService.push(
                                page: RoutePaths.cart,
                                isNamed: true,
                              );
                            }),
                          ],
                          Visibility(
                            visible: profileCubit.isMe,
                            child: ProfileItem(
                              const Icon(Icons.edit),
                              'edit_account',
                              () {
                                NavigationService.push(
                                  page: BlocProvider.value(
                                      value: profileCubit,
                                      child: const EditProfileScreen()),
                                );
                              },
                            ),
                          ),
                          ProfileItem(const Icon(Icons.share), 'share_link', () {
                            Share.share(
                                'https://www.creen-program.com/register/invitation/${HelperFunctions.currentUser?.id}');
                          }),
                          Visibility(
                            visible: profileCubit.isMe,
                            child: ProfileItem(
                                const Icon(Icons.logout_outlined), 'logout', () {
                              CustomAwesomeDialog().showOptionsDialog(
                                context: context,
                                message: 'logout_confirm'.translate,
                                btnOkText: 'logout',
                                btnCancelText: 'cancel',
                                onConfirm: () {
                                  context.read<LogoutCubit>().logout(
                                        context: context,
                                      );
                                },
                                type: DialogType.warning,
                              );
                            }),
                          ),
                          Visibility(
                            visible: profileCubit.isMe,
                            child: ProfileItem(
                              const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              'delete_account',
                              () {
                                CustomAwesomeDialog().showOptionsDialog(
                                  context: context,
                                  message: 'delete_account_confirm'.translate,
                                  btnOkText: 'delete_account',
                                  btnCancelText: 'cancel',
                                  onConfirm: () {
                                    context
                                        .read<DeleteAccountCubit>()
                                        .deleteAccount(context: context);
                                  },
                                  type: DialogType.warning,
                                );
                                // context.read<LogoutCubit>().logout(
                                //       context: context,
                                //     );
                              },
                              // textColor: Colors.red,
                            ),
                          ),
                        ],
                      ),
                      /*  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ProfileItem(
                              ImageIcon(
                                const AssetImage('assets/images/posts.png'),
                                // height: 40.r,
                                size: 35.r,
                              ),
                              'blogs', () {
                            NavigationService.push(
                              page: RoutePaths.myBlogs,
                              isNamed: true,
                            );
                          }),
                          ProfileItem(
                            // Image.asset(
                            //   ('assets/images/khater.png'),
                            //   height: 35.r,
                            //   width: 35.r,
                            //   fit: BoxFit.cover,
                            // ),
                            const LiveButton(
                              backgroundColor: Colors.red,
                            ),
                            'بث مباشر',
                            () {},
                            showSizedBox: false,
                          ),
                          ProfileItem(
                            const Icon(Icons.play_circle_fill_outlined),
                            'video',
                            () {
                              NavigationService.push(
                                  page: const UserVideoScreen(), isNamed: false);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ProfileItem(
                              const ImageIcon(AssetImage('assets/images/13.png')),
                              'my_products', () {
                            NavigationService.push(
                              page: RoutePaths.myProducts,
                              isNamed: true,
                            );
                          }),
                          ProfileItem(
                              const ImageIcon(AssetImage('assets/images/14.png')),
                              'my_ads', () {
                            NavigationService.push(
                              page: RoutePaths.myAds,
                              isNamed: true,
                            );
                          }),
                          ProfileItem(
                              const ImageIcon(AssetImage('assets/images/15.png')),
                              'services',
                              () {}),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ProfileItem(
                              Image(
                                image: const AssetImage(
                                    'assets/images/chat_icon.png'),
                                // color: Colors.black,
                                height: 27.r,
                                width: 27.r,
                              ),
                              'chats', () {
                            NavigationService.push(
                              page: const AllConversationsScreen(),
                            );
                          }),
                          ProfileItem(
                            const ImageIcon(
                                AssetImage('assets/images/wallet.png')),
                            'wallet',
                            () {
                              NavigationService.push(
                                page: RoutePaths.myWallets,
                                isNamed: true,
                              );
                            },
                          ),
                          ProfileItem(const Icon(Icons.shopping_cart_rounded),
                              'cart', () {}),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ProfileItem(
                              const Icon(Icons.edit), 'edit_account', () {}),
                          ProfileItem(const Icon(Icons.share), 'share_link', () {
                            Share.share(
                                'https://www.creen-program.com/register/invitation/${HelperFunctions.currentUser?.id}');
                          }),
                          ProfileItem(const Icon(Icons.logout_outlined), 'logout',
                              () {
                            context.read<LogoutCubit>().logout(
                                  context: context,
                                );
                          }),
                        ],
                      ),*/
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
