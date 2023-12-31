// import 'package:creen_health/core/utils/functions/helper_functions.dart';
// import 'package:creen_health/core/utils/routing/navigation_service.dart';
// import 'package:creen_health/core/utils/widgets/app_loader.dart';
// import 'package:creen_health/features/chat/components/chat_components/components/all_messages_screend.dart';
// import 'package:creen_health/features/chat/viewModel/allConversations/all_conversations_cubit.dart';
// import 'package:creen_health/features/follow/viewModel/followers/followers_cubit.dart';
// import 'package:creen_health/features/follow/viewModel/following/following_cubit.dart';
// import 'package:creen_health/features/profile/presentaion/widgets/follow_item.dart';
// import 'package:creen_health/features/profile/presentaion/widgets/profile_item.dart';
// import 'package:creen_health/features/profile/presentaion/widgets/profile_photo.dart';
// import 'package:creen_health/features/profile/viewModel/profile/profile_cubit.dart';
// import 'package:creen_health/features/videos/presentaion/pages/add_video.dart';
// import 'package:flutter/material.dart' hide NavigationDrawer;
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../../../../core/utils/widgets/chat_screen.dart';

// class OthersProfileScreen extends StatefulWidget {
//   const OthersProfileScreen({Key? key}) : super(key: key);

//   @override
//   State<OthersProfileScreen> createState() => _OthersProfileScreenState();
// }

// class _OthersProfileScreenState extends State<OthersProfileScreen> {
//   late ProfileCubit profileCubit;
//   late FollowingCubit followingCubit;
//   late FollowersCubit followersCubit;

//   @override
//   void initState() {
//     profileCubit = context.read<ProfileCubit>()..getProfile(context);

//     followersCubit = context.read<FollowersCubit>()..getFollowers(context);
//     followingCubit = context.read<FollowingCubit>()..getFollowing(context);
//     super.initState();
//   }

//   @override
//   Widget build(
//     BuildContext context,
//   ) {
//     return Scaffold(
//       //backgroundColor: Colors.amber,
//       // appBar: PreferredSize(
//       //     preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
//       //     child: const CustomAppBar(
//       //       title: 'البروفايل',
//       //     )),
//       body: BlocBuilder<ProfileCubit, ProfileState>(
//         builder: (context, state) {
//           if (state is ProfileLoading) {
//             return const AppLoader();
//           }
//           return Directionality(
//             textDirection: TextDirection.rtl,
//             child: ListView(
//               children: [
//                 ProfilePhoto(
//                   profileCubit: profileCubit,
//                   name: profileCubit.profileData?.name ?? '',
//                   bgImage: profileCubit.profileData?.cover,
//                   prImage: profileCubit.profileData?.profile,
//                   mail: profileCubit.profileData?.email,
//                   isMe: HelperFunctions.currentUser?.id ==
//                       profileCubit.profileData?.id,
//                   isFollow: profileCubit.profileData?.isFollow ?? false,
//                   userId: profileCubit.profileData?.id,
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 // const FollowItem('10', '40', '56'),
//                 FollowItem(
//                   followersCubit: followersCubit,
//                   followingCubit: followingCubit,
//                 ),
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
//                   child: Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           ProfileItem(
//                               const ImageIcon(
//                                   AssetImage('assets/images/10.png')),
//                               'blogs',
//                               () {}),
//                           ProfileItem(
//                               const ImageIcon(
//                                   AssetImage('assets/images/11.png')),
//                               'reflec',
//                               () {}),
//                           ProfileItem(
//                               const Icon(Icons.videocam_rounded), 'الفيديو',
//                               () {
//                             NavigationService.push(
//                                 page: const UserVideoScreen(), isNamed: false);
//                           }),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           ProfileItem(
//                               const ImageIcon(
//                                   AssetImage('assets/images/13.png')),
//                               'shopping',
//                               () {}),
//                           ProfileItem(
//                               const ImageIcon(
//                                   AssetImage('assets/images/14.png')),
//                               'my_ads',
//                               () {}),
//                           ProfileItem(
//                               const ImageIcon(
//                                   AssetImage('assets/images/15.png')),
//                               'services',
//                               () {}),
//                         ],
//                       ),
//                       const SizedBox(
//                         height: 10,
//                       ),
//                       Row(
//                         children: [
//                           ProfileItem(
//                               Image(
//                                 image: const AssetImage(
//                                     'assets/images/chat_icon.png'),
//                                 // color: Colors.black,
//                                 height: 27.r,
//                                 width: 27.r,
//                               ),
//                               'chats', () {
//                             NavigationService.push(
//                               page: AllMessagesScreen(
//                                 conversationId: null,
//                                 timeAgo: null,
//                                 allConversationsCubit: AllConversationsCubit(),
//                                 profilePic: profileCubit.profileData?.profile,
//                                 userName: profileCubit.profileData?.name,
//                                 recieverId: profileCubit.profileData?.id,
//                               ),
//                             );
//                           }),
//                           ProfileItem(
//                               const Icon(Icons.share), 'share_link', () {}),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
