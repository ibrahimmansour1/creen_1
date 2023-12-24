import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:creen/core/themes/enums.dart';
import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/core/utils/routing/route_paths.dart';
import 'package:creen/core/utils/widgets/chat_screen.dart';
import 'package:creen/core/utils/widgets/custom_awesome_dialog.dart';
import 'package:creen/features/follow/repo/follow_repo.dart';
import 'package:creen/features/live/model/LiveShowModel.dart';
import 'package:creen/features/live/model/MaincommentData.dart';
import 'package:creen/features/live/model/live_model.dart';
import 'package:creen/features/live/presentation/models/live_details_model.dart';
import 'package:creen/features/live/presentation/models/live_sticker_model.dart';
import 'package:creen/features/live/presentation/pages/guests_list_page.dart';
import 'package:creen/features/live/presentation/pages/live_chat.dart';
import 'package:creen/features/live/presentation/widgets/icon_item.dart';
import 'package:creen/features/live/repo/followers_status.dart';
import 'package:creen/features/live/repo/live_comment_destroy.dart';
import 'package:creen/features/live/repo/live_comment_store.dart';
import 'package:creen/features/live/repo/live_destroy_repo.dart';
import 'package:creen/features/live/repo/live_details_show_repo.dart';
import 'package:creen/features/live/repo/live_dislike_repo.dart';
import 'package:creen/features/live/repo/live_like_repo.dart';
import 'package:creen/features/live/repo/live_users_destroy_repo.dart';
import 'package:creen/features/live/repo/live_users_join_repo.dart';
import 'package:creen/features/live/repo/update_image_repo.dart';
import 'package:creen/main.dart';
import 'package:dio/dio.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/utils/functions/helper_functions.dart';
import '../../../../core/utils/network_utils.dart';
import '../../../../core/utils/widgets/mirror_widget.dart';

class LiveStartScreen extends StatefulWidget {
  LiveStartScreen({
    super.key,
    this.liveCreator = false,
    this.gallery = false,
    required this.liveModel,
  });

  final bool liveCreator;

  final bool gallery;
  LiveDataModel liveModel;

  @override
  State<LiveStartScreen> createState() => _LiveStartScreenState();
}

class _LiveStartScreenState
    extends State<LiveStartScreen> /*with WidgetsBindingObserver*/ {
  List<LiveStickerModel> liveStickers = [
    // LiveStickerModel(
    //     userProfile:
    //         'https://www.cdc.gov/diabetes/images/research/reaching-treatment-goals.jpg?_=66821',
    //     sticker:
    //         'https://www.cdc.gov/diabetes/images/research/reaching-treatment-goals.jpg?_=66821',
    //     number: 1,
    //     userName: 'ليون داي',
    //     stickerKind: 'البريدية')
  ];
  bool raiseHand = true;
  bool choicesHidden = true;
  PersistentBottomSheetController? _controller;
  String testImage1 =
      "https://www.cdc.gov/diabetes/images/research/reaching-treatment-goals.jpg?_=66821";
  List<String> raiseHandList = [
    /*  "احمد",
    "محمد",
    "محمود",
    "عبد الله",
    "طه",
    "طه",
    "طه",
    "طه",
    "طه",
    "طه",
    "طه",
    "طه",*/
  ];
  List<bool> deleteShown = [];
  TextEditingController commentController = TextEditingController();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool bottomSheet = false;
  List<bool> selectedItem = [];
  bool micOn = true;
  bool cameraOn = true;
  bool audioOn = true;
  String channelName = "test";
  String token =
      "007eJxTYPgamcTZER+7d7bV5V0v70j27T80vXXL8w97Q5etlFGe3NSuwGCRbGRoaWSelGhhnmxiYGKeaG5hYmRhaG5hZGGcamxi+lFLIbUhkJHhVNEeZkYGCATxWRhKUotLGBgA21Ig5A==";

  int uid = 0; // uid of the local user
  bool shown = false;
  int tabIndex = 0;
  List<Widget> tabWidgets = [];
  late int likes;

  int? _remoteUid; // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel
  bool _isHost =
      true; // Indicates whether the user has joined as a host or audience
  late RtcEngine agoraEngine; // Agora engine instance

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold
  YoutubePlayerController? youtubeController;

  String? _linkMessage;
  bool _isCreatingLink = false;

  FirebaseDynamicLinks dynamicLinks = FirebaseDynamicLinks.instance;
  final String _testString =
      'To test: long press link and then copy and click from a non-browser '
      "app. Make sure this isn't being tested on iOS simulator and iOS xcode "
      'is properly setup. Look at firebase_dynamic_links/README.md for more '
      'details.';

  final String DynamicLink = 'https://com.creen_program?link=helloworld';
  final String Link = 'https://flutterfiretests.page.link/MEGs';
  List<LiveComments> liveComments = [];
  List<LiveComments> liveCommentsListView = [];
  late bool liveType;

  bool ribbonShow = false;
  String? profile;

  bool on = true;

  bool liked = false;
  List<MaincommentData>? comments;
  List<LiveUser>? users;

  int chatTabIndex = 0;
  bool followCreator = false;

  Widget chatTabWidgets({required int index, required dynamic data}) {
    if (index == 0) {
      return ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 4),
        itemBuilder: (BuildContext context, int index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44.r,
                height: 44.r,
                margin: const EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: null /*data[index].profile*/ != null
                        ? NetworkImage(data[index].profile)
                        : const AssetImage(personProfile)
                            as ImageProvider<Object>,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
/*
         Padding(
           padding: const EdgeInsets.symmetric(horizontal: 8.0),
           child: CircleAvatar(
             radius: 22.r,
             backgroundColor: Colors.transparent,
             backgroundImage: null*/
/*data[index].profile*/ /*
 != null?NetworkImage(data[index].profile):const AssetImage(personProfile)as ImageProvider<Object>,
           ),
         ),
*/

              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('data[index].name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                      )),
                  Text('data[index].message',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      )),
                ],
              ),
            ],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            color: Colors.white,
          );
        },
        itemCount: 2 /*data.length*/,
      );
    } else {
      // return const Text('chat',style:TextStyle(color:Colors.white));
      log('chatTabWidgets  ==> ${data.length}');
      return GridView.builder(
/*
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: radius,
          mainAxisExtent: radius+19,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
        ),
*/
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (context, index) {
          LiveUser user = data[index + 1];
          String? userProfile = user.user?.profile;
          return InkWell(
            onTap: () {
              if (user.guest == null) {
                Navigator.pushNamed(context, RoutePaths.liveChat, arguments: {
                  'user': user.user,
                  'liveCreator': widget.liveCreator,
                  'creator': widget.liveModel.creator,
                });
              }
            },
            child: Column(
              children: [
                if (userProfile != null)
                  Container(
                    width: 50.r,
                    height: 50.r,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            userProfile!,
                          ),
                          fit: BoxFit.cover,
                        )),
                  )
                else
                  CircleAvatar(
                    radius: 25.r,
                    backgroundImage: const AssetImage(personProfile),
                    backgroundColor: Colors.transparent,
                  )
/*
                Container(
                  width: 50.r,
                  height: 50.r,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration:  BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(userProfile!,), fit: BoxFit.cover,
                      )),
                ),
*/
                ,
                Text(
                  user.guest ?? user.user!.name!,
                  style: const TextStyle(color: Colors.white),
                )
              ],
            ),
          );
        },
        padding: const EdgeInsets.all(4),
        itemCount: data.length - 1,
      );
    }
  }

  Future<String> createLink({required String refCode}) async {
    String url = 'https://com.creen_program?ref=$refCode';
    final DynamicLinkParameters dynamicLinkParameters = DynamicLinkParameters(
      link: Uri.parse(url),
      uriPrefix: 'https://creenprogram.page.link',
      androidParameters: const AndroidParameters(
          packageName: 'com.creen_program', minimumVersion: 0),
      iosParameters: const IOSParameters(
          bundleId: 'com.creenProgram', minimumVersion: '0'),
    );
    final FirebaseDynamicLinks firebaseDynamicLinks =
        await FirebaseDynamicLinks.instance;
    final refLink =
        await firebaseDynamicLinks.buildShortLink(dynamicLinkParameters);
    return refLink.shortUrl.toString();
  }

  Future<void> initDynamicLink() async {
    final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if (instanceLink != null) {
      final Uri refLink = instanceLink.link;
      log('join the live now ${refLink.data}');
      Share.share('join the live now ${refLink.data}');
      // if(refLink.queryParameters.containsKey(key))
    }
  }

  Future<void> fetchToken(
    int uid,
    String channelName,
    int tokenRole,
  ) async {
    final util = NetworkUtil();
    int tokenExpireTime = 7400; // Expire time in Seconds.
    // channelName = 'test';
    // Prepare the Url
    channelName = widget.liveModel.title;
    String url =
        '$serverUrl/rtc/$channelName/${tokenRole.toString()}/uid/${uid.toString()}?expiry=${tokenExpireTime.toString()}';

    // Send the request
    Response? response;
    await util
        .get(
      url,
    )
        .then((value) {
      response = value;
      log("fetch token response ====> $response");
    });

    if (response?.statusCode == 200) {
      // If the server returns an OK response, then parse the JSON.

      token = response?.data['rtcToken'];
      debugPrint('Token Received: $token');
      // Use the token to join a channel or renew an expiring token
      // setToken(newToken);
    } else {
      // If the server did not return an OK response,
      // then throw an exception.
      throw Exception(
          'Failed to fetch a token. Make sure that your server URL is valid');
    }
  }

  void setToken(String newToken) async {
    token = newToken;

    if (isTokenExpiring) {
      // Renew the token
      agoraEngine.renewToken(token);
      isTokenExpiring = false;
      showMessage("Token renewed");
    } else {
      // Join a channel.
      showMessage("Token received, joining a channel...");
      // Set channel options
      ChannelMediaOptions options;
      log('_isHost $_isHost');
      // Set channel profile and client role
      if (_isHost) {
        options = const ChannelMediaOptions(
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        );
        await agoraEngine
            .startPreview()
            .then((value) => log('startPreview'))
            .catchError(
                (error) => log('startPreview Error ${error.toString()}'));
      } else {
        options = const ChannelMediaOptions(
          clientRoleType: ClientRoleType.clientRoleAudience,
          channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
        );
      }

      // channelName = "test";
      if (channelName.isEmpty) {
        showMessage("Enter a channel name");
        return;
      } else {
        showMessage("Fetching a token ...");
      }

      await fetchToken(uid, channelName, _isHost ? 1 : 2);
    }
  }

  Widget _videoPanel({bool host = false}) {
    if (!_isJoined) {
      return const CircularProgressIndicator();
    } else if (_isHost || host) {
      // Show local video preview
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: agoraEngine,
          canvas: VideoCanvas(uid: uid),
        ),
      );
    } else {
      // Show remote video
      if (_remoteUid != null) {
        return AgoraVideoView(
          controller: VideoViewController.remote(
            rtcEngine: agoraEngine,
            canvas: VideoCanvas(uid: _remoteUid),
            connection: RtcConnection(channelId: channelName),
          ),
        );
      } else {
        log('end end');
/*
if(widget.liveModel.users![0].userPrivelege != 'creator' || widget.liveCreator){
  timer?.cancel();
  opacityTimer?.cancel();
// WidgetsBinding.instance.removeObserver(this);

  agoraEngine.leaveChannel().then((value) {
    agoraEngine.release();
    if (widget.liveCreator) {
      LiveDestroyRepo.destroyLive(liveId: widget.liveModel.id!);
      HelperFunctions.setLiveId(
        null,
      );

      log('finish finish');
    }
  });
// await agoraEngine.leaveChannel();
// agoraEngine.release();
  if (liveType &&
      widget.liveModel.youtube_link != null &&
      (widget.liveModel.youtube_link ?? '').isNotEmpty) {
    log('youtube controller dispose');
    youtubeController!.dispose();
  }
  Navigator.pop(context);

}
*/
        return const Text('The admin left the live');
        /* Navigator.pop(context);
        // Navigator.pop(context);
        return  Dialog(child: Container(width: 300,
        height: 300,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          children: [
            InkWell(onTap: (){
              log('Exit');
              Navigator.pop(context);
            },
            child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey.shade200,
                child: const Icon(Icons.close,color: Colors.black,)),),
            const Expanded(child: Center(child: Text('The admin ended the live'))),
          ],
        ),),);*/
      }
    }
  }

  Future<void> setupVideoSDKEngine() async {
    log('setupVideoSDKEngine');

    // retrieve or request camera and microphone permissions
    // await [Permission.microphone, Permission.camera].request();
    await [Permission.camera, Permission.microphone].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine
        .initialize(const RtcEngineContext(appId: appId))
        .then((value) => log('agoraEngine'))
        .catchError((error) => log('agoraEngine Error  ${error.toString()}'));
    if (!liveType) {
      await agoraEngine
          .disableVideo()
          .then((value) => log('disableVideo'))
          .catchError((error) => log('disableVideo Error ${error.toString()}'));
    } else {
      await agoraEngine
          .enableVideo()
          .then((value) => log('enableVideo'))
          .catchError((error) => log('enableVideo Error ${error.toString()}'));
    }

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        /* onFirstLocalVideoFrame:,
          onFirstLocalVideoFramePublished:,
          onFirstRemoteVideoDecoded:,
          onUserEnableVideo:,
        onActiveSpeaker: ,
        onAudioDeviceStateChanged: ,
        onCameraReady: ,
        onClientRoleChanged: ,
        onClientRoleChangeFailed: ,
        onAudioSubscribeStateChanged: ,
        onConnectionBanned: ,
        onRemoteAudioStateChanged: ,
        onRemoteAudioStats: ,
        onRemoteVideoStats: ,
        onRequestToken: ,
        onRemoteVideoStateChanged: ,
        onRejoinChannelSuccess: ,
        onConnectionLost: ,
        onConnectionInterrupted: ,
        onConnectionStateChanged: ,
          onUserMuteVideo:,
        onUserEnableLocalVideo: ,
        onUserMuteAudio: ,
        onUserStateChanged: ,
        onLocalUserRegistered: ,
        onUserAccountUpdated: ,
        onUserInfoUpdated: ,*/

        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          log("Local user uid: ${connection.localUid} joined the channel");
          showMessage(
              "Local user uid: ${connection.localUid} joined the channel");
          setState(() {
            _isJoined = true;
          });
        },
        onLeaveChannel: (RtcConnection connection, RtcStats stat) {
          log('me left the meeting');
          if (widget.liveCreator) {
            LiveDestroyRepo.destroyLive(liveId: widget.liveModel.id!);
            log('finish finish');
          }
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          log("Remote user uid: $remoteUid joined the channel");
          showMessage("Remote user uid: $remoteUid joined the channel");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          log("Remote user uid:$remoteUid left the channel");
          showMessage("Remote user uid:$remoteUid left the channel");
          setState(() {
            _remoteUid = null;
          });
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          showMessage('Token expiring');
          isTokenExpiring = true;
          setState(() {
            // fetch a new token when the current token is about to expire
            fetchToken(uid, channelName, _isHost ? 1 : 2);
          });
        },
      ),
    );
    await fetchToken(uid, channelName, _isHost ? 1 : 2);
    await join();
  }

  late int u;
  String joinError = '200';

  Future<void> join() async {
    log('join Method');
    // Set channel options
    ChannelMediaOptions options;
    log('_isHost $_isHost');
    // Set channel profile and client role
    if (_isHost) {
      options = const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      );
      await agoraEngine
          .startPreview()
          .then((value) => log('startPreview'))
          .catchError((error) => log('startPreview Error ${error.toString()}'));
    } else {
      options = const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleAudience,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      );
    }

    log("join Method \ntoken $token \nchannelName $channelName \nuid $uid\n");
    await agoraEngine
        .joinChannel(
      token: token,
      channelId: channelName,
      options: options,
      uid: uid,
    )
        .then((value) {
      log('joinChannel');
      if (liveType && widget.liveCreator) {
        agoraEngine
            .takeSnapshot(
                uid: uid,
                filePath:
                    '/storage/emulated/0/Android/data/com.creen_program/files/example.jpg')
            .then((value) async {
          log('take snapshot');

          LiveImageRepo.updateLiveImage(
                  liveId: widget.liveModel.id!,
                  liveImage: await MultipartFile.fromFile(
                      '/storage/emulated/0/Android/data/com.creen_program/files/example.jpg'))
              .then((value) {
            log('Image updated');
          }).catchError((error) {
            log('Image not updated ${error.toString()}');
          });
        }).catchError(
                (error) => log('take snapshot Error ${error.toString()}'));
      }
      if (!widget.liveCreator) {
        do {
          LiveUsersJoinRepo.joinLiveUser(
                  liveId: widget.liveModel.id!,
                  remoteId: _remoteUid,
                  priveleges: 'user')
              .then((value) {
            log('join Live User Response ==> ${value?.status}');
            u = value!.data!.id!;
            joinError = '${value!.status}';
          }).catchError((error) {
            joinError = error.toString();
          });
        } while (joinError != '200');
      }
    }).catchError((error) => log('joinChannel Error ${error.toString()}'));
  }

  Future<void> leave() async {
    setState(() {
      _isJoined = false;
      _remoteUid = null;
    });
    agoraEngine.leaveChannel().then((value) {
      agoraEngine.release();
      if (widget.liveCreator) {
        LiveDestroyRepo.destroyLive(liveId: widget.liveModel.id!);
        log('finish finish');
      } else {
        LiveUsersDestroyRepo.destroyUser(userId: u).then((value) {
          log('join Live User Response ==> success');
        });
      }
    });
  }

  showMessage(String message) {
    log("message show $message");
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  Future<void> initDynamicLinkss() async {
    dynamicLinks.onLink.listen((dynamicLinkData) {
      Navigator.pushNamed(context, dynamicLinkData.link.path);
    }).onError((error) {
      if (kDebugMode) {
        print('onLink error');

        print(error.message);
      }
    });
  }

  Future<void> _createDynamicLink(bool short) async {
    setState(() {
      _isCreatingLink = true;
    });

    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://flutterfiretests.page.link',
      longDynamicLink: Uri.parse(
        'https://flutterfiretests.page.link?efr=0&ibi=io.flutter.plugins.firebase.dynamiclinksexample&apn=io.flutter.plugins.firebase.dynamiclinksexample&imv=0&amv=0&link=https%3A%2F%2Fexample%2Fhelloworld&ofl=https://ofl-example.com',
      ),
      link: Uri.parse(DynamicLink),
      androidParameters: const AndroidParameters(
        packageName: 'io.flutter.plugins.firebase.dynamiclinksexample',
        minimumVersion: 0,
      ),
      iosParameters: const IOSParameters(
        bundleId: 'io.flutter.plugins.firebase.dynamiclinksexample',
        minimumVersion: '0',
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink =
          await dynamicLinks.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await dynamicLinks.buildLink(parameters);
    }

    setState(() {
      _linkMessage = url.toString();
      _isCreatingLink = false;
    });
  }

  Timer? timer;
  Timer? opacityTimer;
  double opacityValue = 1.0;
  int previousLiveCommentsLength = 0;

  @override
  void initState() {
    timer = Timer.periodic(const Duration(seconds: 3), (Timer t) {
      FollowersStatus.followStatus(userId: widget.liveModel.creator.id)
          .then((value) {
        if (value?.status ?? false) {
          setState(() {
            followCreator = value?.data ?? false;
          });
        }
      });

      LiveDetailsShowRepo.showLiveDetails(liveId: widget.liveModel.id!)
          .then((value) {
        log('live details show ${value?.status}');
        List<Comment> commentsItem;
        int? userIdItem;

        if (value?.status ?? false) {
          Data? dataItem = value!.data;
          if(dataItem != null){
            log('dataItem! ${dataItem}');
            log('dataItem.users ${dataItem.users?.userData}');
            log('dataItem.maincomments ${dataItem.maincomments?.maincommentData}');
            // log('dataItem.liveDataModel ${dataItem.liveDataModel}');
            setState(() {
              widget.liveModel = (dataItem!.liveDataModel)!;
              users = dataItem.users!.userData;
              log('users length ${users?.length}');
              comments = dataItem!.maincomments?.maincommentData /*.reversed*/;
              likes = widget.liveModel.likes;
              log('likes likes likes likes ${likes}');
              int difference =
                  (comments ?? []).length - previousLiveCommentsLength;
              if (difference > 0) {
                previousLiveCommentsLength = (comments ?? []).length;
                liveCommentsListView.addAll(List.generate(difference, (index) {
                  userIdItem = comments?[index].userId;
                  LiveUser commenterUser =
                  (dataItem.users!.userData ?? []).firstWhere((element) {
                    return element.userId == userIdItem;
                  });
                  bool isSignedUser = commenterUser.user != null;
                  return LiveComments(
                      id: comments?[index].id,
                      userId: commenterUser.userId,
                      name: (isSignedUser
                          ? commenterUser.user!.name
                          : commenterUser.guest)!,
                      profile: isSignedUser ? commenterUser.user!.profile : null,
                      comment: comments![index].comment!);
                }));

                liveComments.addAll(liveCommentsListView);
              }
            });
            log('likes likes likes ${liveCommentsListView.length}');

          }
          /*   FollowersStatus.followStatus(userId: widget.liveModel.creator.id).then((value){
            if(value?.status??false) {
              setState(() {
                followCreator = value?.data??false;
              });
            }
          });
*/
// log('likes likes likes ${value!.data![0].users![0].user.profile!}');
        }
      });
      log('follow status ${followCreator}');
    });
    // WidgetsBinding.instance.addObserver(this);
    likes = widget.liveModel.likes;
    _isHost = widget.liveCreator;
    liveType = widget.liveModel.type == LiveType.video.name;
    log('Live Id = ${widget.liveModel.id}');
    HelperFunctions.setLiveId(widget.liveModel.id).then((value) {
      log('set Live Id');
    }).catchError((error) {
      log('set Live Id error ${error.toString()}');
    });

    tabWidgets = [
      if (widget.liveModel.privelegeComments == 'public')
        tabCommentWidget(
            liveComments: liveCommentsListView,
            deleteFunction: (index) {
              LiveCommentDestroyRepo.destroyComment(
                      messageId: liveCommentsListView[index].id!)
                  .then((value) {
                setState(() {
                  liveCommentsListView.removeAt(index);
                });
              });
            },
            blockFunction: () {},
            reportFunction: () {}),
      if (widget.liveModel.attendance_view == 'public')
        tabPublicWidget(tabPublicEnable: false),
      if (widget.liveModel.gifts == 'public') tabPublicWidget(),
    ];
    profile = (widget.liveCreator
        ? HelperFunctions.currentUser!.profile
        : widget.liveModel.creator.profile);
    log('widget.liveModel.youtube_link ${widget.liveModel.youtube_link}');
    // initDynamicLinks();
    initDynamicLink();

    if (liveType &&
        widget.liveModel.youtube_link != null &&
        (widget.liveModel.youtube_link ?? '').isNotEmpty) {
      youtubeController = YoutubePlayerController(
          initialVideoId: widget.liveModel.youtube_link!.split('/').last);
    }
    log('initState');
    log("live Profile ===> ${widget.liveModel.creator.profile}");
    selectedItem = List<bool>.generate(50, (index) => false);
    deleteShown = List<bool>.generate(raiseHandList.length, (index) => false);
    channelName = widget.liveModel.title;

    // channelName = 'test';
    // channelName = HelperFunctions.currentUser!.name!;
    // userId = HelperFunctions.currentUser!.id!;

    // Set up an instance of Agora engine
    setupVideoSDKEngine();
    super.initState();
  }

  @override
  void deactivate() {
    if (liveType &&
        widget.liveModel.youtube_link != null &&
        (widget.liveModel.youtube_link ?? '').isNotEmpty) {
      youtubeController!.pause();
    }
    super.deactivate();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        log('app resumed');
        break;
      case AppLifecycleState.paused:
        log('app paused');
        break;
      case AppLifecycleState.inactive:
        log('app inactive');
        // HelperFunctions.setLiveId(widget.liveModel.id!);

        break;
      case AppLifecycleState.detached:
      default:
        log('app detached');
        agoraEngine.leaveChannel().then((value) {
          agoraEngine.release();
          if (widget.liveCreator) {
            LiveDestroyRepo.destroyLive(liveId: widget.liveModel.id!);
            log('finish finish');
          }
        });
        break;
    }
  }

  // Release the resources when you leave
  //10 stories + more
  @override
  void dispose() async {
    log('dispose');
    timer?.cancel();
    opacityTimer?.cancel();
    // WidgetsBinding.instance.removeObserver(this);

    agoraEngine.leaveChannel().then((value) {
      agoraEngine.release();
      if (widget.liveCreator) {
        LiveDestroyRepo.destroyLive(liveId: widget.liveModel.id!);
        HelperFunctions.setLiveId(
          null,
        );

        log('finish finish');
      }
    });
    // await agoraEngine.leaveChannel();
    // agoraEngine.release();
    if (liveType &&
        widget.liveModel.youtube_link != null &&
        (widget.liveModel.youtube_link ?? '').isNotEmpty) {
      log('youtube controller dispose');
      youtubeController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('widget.liveModel.youtube_link ${widget.liveModel.youtube_link}');
    log('profile user ${HelperFunctions.currentUser!.profile}');
    log('liveType $liveType');
    /*LiveDetailsShowRepo.showLiveDetails(liveId: widget.liveModel.id!)
        .then((value) {
      log('live details show $value');
      if (value?.status ?? false) {
        setState(() {
          widget.liveModel = value!.data![0];
        });
      }
    });*/
    // log('future builder connection status ${snapshot.connectionState}');
    // log('future builder data snapshot ${snapshot.data?.data?[0].comments?[0].comment}');
    // log('future builder data snapshot ${snapshot.data?.data?[0].id}');
    if (liveType &&
        widget.liveModel.youtube_link != null &&
        (widget.liveModel.youtube_link ?? '').isNotEmpty) {
      return YoutubePlayerBuilder(
          player: YoutubePlayer(
            controller: youtubeController!,
          ),
          builder: (ctx, player) {
            return WillPopScope(
              onWillPop: () async {
                CustomAwesomeDialog().showOptionsDialog(
                  context: context,
                  message: 'هل تريد الخروج من البث ؟',
                  btnOkText: 'خروج',
                  btnCancelText: 'cancel',
                  onConfirm: () {
                    leave();
                    Navigator.pop(context);
                    if (_isHost) {
                      Navigator.pop(context);
                    }
                  },
                  type: DialogType.warning,
                );
                return false;
              },
              child: Scaffold(
                key: scaffoldKey,
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  leadingWidth: widget.liveCreator ? 130 : 145,
                  toolbarHeight: 86,
                  leading: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: !widget.liveCreator
                        ? CrossAxisAlignment.center
                        : CrossAxisAlignment.end,
                    children: [
/*
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.1),

                        child: Icon(Icons.arrow_back_ios,color: Colors.black,))),
*/
                      if (widget.liveCreator)
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: liveType
                                  ? Colors.black.withOpacity(0.1)
                                  : null,
                              // border: Border.all(color: Colors.black),
                              shape: BoxShape.circle),
                          child: Column(
                            children: [
                              Icon(
                                Icons.groups,
                                size: 35,
                                color: liveType ? Colors.white : null,
                              ),
                              Text(
                                "4",
                                style: TextStyle(
                                    fontSize: 25,
                                    color:
                                        liveType ? Colors.white : Colors.black),
                              ),
                            ],
                          ),
                        )
                      else ...[
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: widget.gallery
                                  ? DecorationImage(
                                      image: FileImage(File(
                                          widget.liveModel.creator.profile!))

                                      // NetworkImage( widget.liveModel.creator.profile) as ImageProvider<Object>
                                      ,
                                      fit: BoxFit.cover)
                                  : null),
                        ),
                        const Text(
                          "احمد",
                          style: TextStyle(fontSize: 20),
                        ),
                        InkWell(
                          onTap: () async {
                            /*await FollowRepo.follow(
                              context,
                              isFollow: isFollow,
                              body: {
                                'user_id': userId,
                              },
                            );*/
                          },
                          child: Container(
                            width: 30,
                            height: 30,
                            // padding: EdgeInsets.symmetric(horizontal: 15,vertical: 2),
                            decoration: const BoxDecoration(
                                color: Colors.red, shape: BoxShape.circle
                                // borderRadius: BorderRadius.circular(30)
                                ),
                            child: const Icon(
                              Icons.send,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ]
                    ],
                  ),
                  title: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),

                        /*border: Border.all(
                    color: Colors.black,
                  ),*/
                        borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(30),
                            left: Radius.circular(30))),
                    child: Text(
                      "1280",
                      style: TextStyle(
                          color: liveType ? Colors.white : Colors.black,
                          fontSize: 25),
                    ),
                  ),
                  centerTitle: true,
                  actions: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.1),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.card_giftcard,
                            size: 30,
                            color: liveType ? Colors.white : Colors.black,
                          ),
                          Text(
                            "1500",
                            style: TextStyle(
                                fontSize: 20,
                                color: liveType ? Colors.white : Colors.black),
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),

                        // border: Border.all(color: Colors.black),
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                        onTap: () {
                          CustomAwesomeDialog().showOptionsDialog(
                            context: context,
                            message: 'هل تريد الخروج من البث ؟',
                            btnOkText: 'خروج',
                            btnCancelText: 'cancel',
                            onConfirm: () {
                              leave();
                              Navigator.pop(context);
                              if (_isHost) {
                                Navigator.pop(context);
                              }
                            },
                            type: DialogType.warning,
                          );
                        },
                        child: Icon(
                          Icons.close,
                          color: liveType ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
                body: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (!liveType && cameraOn)
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Center(child: _videoPanel()),
                      ),
                    SingleChildScrollView(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
/*
                  decoration: BoxDecoration(
                    // color: Colors.white,
                      image: liveType
                          ? ( widget.liveModel.creator.profile == null
                          ? null
                          : DecorationImage(
                          image: widget.gallery
                              ? FileImage(File( widget.liveModel.creator.profile!))
                              : NetworkImage( widget.liveModel.creator.profile!)
                          as ImageProvider<Object>,
                          fit: BoxFit.cover,
                          opacity: 0.2,
                          colorFilter: const ColorFilter.mode(
                              Colors.black87, BlendMode.lighten)))
                          : const DecorationImage(
                          image: NetworkImage(
                            "https://www.cdc.gov/diabetes/images/research/reaching-treatment-goals.jpg?_=66821",
                          ),
                          fit: BoxFit.cover)),
*/
                        alignment: Alignment.centerRight,
                        child: SafeArea(
                          child: Stack(
                            alignment: Alignment.centerLeft,
                            children: [
                              if (liveType)
                                Align(
                                  alignment: const Alignment(0, -1.0),
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height *
                                        0.5,
                                    child: Column(
                                      children: [
                                        player,
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.08,
                                          child: ListView.separated(
                                              scrollDirection: Axis.horizontal,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5),
                                              itemBuilder: (context, index) {
                                                if (index < 5) {
                                                  return Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      InkWell(
                                                        onTap: () async {
                                                          setState(() {
                                                            deleteShown[index] =
                                                                true;
                                                          });
                                                          await Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                      1500),
                                                              () {
                                                            setState(() {
                                                              deleteShown[
                                                                      index] =
                                                                  false;
                                                            });
                                                          });
                                                        },
                                                        child: Stack(
                                                          alignment:
                                                              Alignment.center,
                                                          children: [
                                                            CircleAvatar(
                                                              radius: 15,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      testImage1),
                                                            ),
                                                            if (deleteShown[
                                                                index])
                                                              InkWell(
                                                                onTap: () {
                                                                  setState(() {
                                                                    raiseHandList
                                                                        .removeAt(
                                                                            index);
                                                                  });
                                                                },
                                                                child:
                                                                    const Icon(
                                                                  Icons.close,
                                                                  color: Colors
                                                                      .red,
                                                                ),
                                                              )
                                                          ],
                                                        ),
                                                      ),
                                                      Text(
                                                        raiseHandList[index],
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  );
                                                } else {
                                                  return Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          InkWell(
                                                            onTap: () async {
                                                              setState(() {
                                                                deleteShown[
                                                                        index] =
                                                                    true;
                                                              });
                                                              await Future.delayed(
                                                                  const Duration(
                                                                      milliseconds:
                                                                          1500),
                                                                  () {
                                                                setState(() {
                                                                  deleteShown[
                                                                          index] =
                                                                      false;
                                                                });
                                                              });
                                                            },
                                                            child: Stack(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              children: [
                                                                CircleAvatar(
                                                                  radius: 15,
                                                                  backgroundImage:
                                                                      NetworkImage(
                                                                          testImage1),
                                                                ),
                                                                if (deleteShown[
                                                                    index])
                                                                  InkWell(
                                                                    onTap: () {
                                                                      setState(
                                                                          () {
                                                                        raiseHandList
                                                                            .removeAt(index);
                                                                      });
                                                                    },
                                                                    child:
                                                                        const Icon(
                                                                      Icons
                                                                          .close,
                                                                      color: Colors
                                                                          .red,
                                                                    ),
                                                                  )
                                                              ],
                                                            ),
                                                          ),
                                                          Text(
                                                            raiseHandList[
                                                                index],
                                                            style:
                                                                const TextStyle(
                                                                    color: Colors
                                                                        .white),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          GuestsListPage(
                                                                            guestsData:
                                                                                raiseHandList,
                                                                            liveProfile:
                                                                                widget.liveModel.creator.profile,
                                                                          )));
                                                        },
                                                        child: Container(
                                                          width: 50,
                                                          height: 50,
                                                          color: Colors.blue,
                                                          alignment:
                                                              Alignment.center,
                                                          child: const Text(
                                                            "المزيد",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  );
                                                }
                                              },
                                              separatorBuilder:
                                                  (context, index) =>
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                              itemCount:
                                                  raiseHandList.length > 6
                                                      ? 6
                                                      : raiseHandList.length),
                                        ),
                                        if (widget.liveModel.youtube_link ==
                                                null &&
                                            !cameraOn)
                                          if (widget.gallery)
                                            Image.file(
                                              File(widget
                                                  .liveModel.creator.profile!),
                                              fit: BoxFit.cover,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.4,
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                            )
                                        /*      : Image.network(
                                                   widget.liveModel.creator.profile,
                                                  fit: BoxFit.contain,
                                                )*/
                                        ,
                                      ],
                                    ),
                                  ),
                                ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (liveType) ...[
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.32,
                                      ),
                                      if (widget.liveCreator &&
                                          raiseHand &&
                                          raiseHandList.isNotEmpty)
                                        Container(
                                          margin: const EdgeInsets.only(top: 5),
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.09,
                                          child: CarouselSlider.builder(
                                            options: CarouselOptions(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.09,
                                              viewportFraction: 0.25,
                                              autoPlay: true,
                                            ),
                                            itemCount: raiseHandList.length,
                                            itemBuilder: (BuildContext context,
                                                int index, int realIndex) {
                                              return Column(
                                                children: [
                                                  Container(
                                                    width: 30,
                                                    height: 30,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                            image: NetworkImage(
                                                                testImage1),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                  Text(
                                                    raiseHandList[index],
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  SizedBox(
                                                    width: 50,
                                                    child: Row(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              raiseHandList
                                                                  .removeAt(
                                                                      index);
                                                            });
                                                          },
                                                          child: Container(
                                                            width: 15,
                                                            height: 15,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color:
                                                                  Colors.green,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: const Icon(
                                                              Icons.check,
                                                              color:
                                                                  Colors.white,
                                                              size: 15,
                                                            ),
                                                          ),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              raiseHandList
                                                                  .removeAt(
                                                                      index);
                                                            });
                                                          },
                                                          child: Container(
                                                            width: 15,
                                                            height: 15,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: Colors.red,
                                                              shape: BoxShape
                                                                  .circle,
                                                            ),
                                                            child: const Icon(
                                                              Icons.close,
                                                              color:
                                                                  Colors.white,
                                                              size: 15,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        /* height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.4,*/
                                        child: Row(
                                          mainAxisAlignment: choicesHidden
                                              ? MainAxisAlignment.end
                                              : MainAxisAlignment.spaceEvenly,
                                          children: choicesHidden
                                              ? [
                                                  InkWell(
                                                    onTap: () async {
                                                      setState(() {
                                                        choicesHidden = false;
                                                      });
                                                      await Future.delayed(
                                                          const Duration(
                                                              milliseconds:
                                                                  1500), () {
                                                        setState(() {
                                                          choicesHidden = true;
                                                        });
                                                      });
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: const Icon(
                                                        Icons.more_horiz,
                                                        size: 33,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ]
                                              : [
                                                  IconItem(
                                                    onIcon: Icons.mic_off,
                                                    offIcon: Icons.mic,
                                                    onTap: () async {
                                                      setState(() {
                                                        micOn = !micOn;
                                                      });
                                                      agoraEngine
                                                          .muteLocalAudioStream(
                                                              micOn);
                                                    },
                                                    offTap: () {
                                                      setState(() {
                                                        micOn = !micOn;
                                                      });
                                                      agoraEngine
                                                          .muteLocalAudioStream(
                                                              micOn);
                                                    },
                                                  ),
                                                  IconItem(
                                                    onIcon: Icons
                                                        .videocam_off_outlined,
                                                    offIcon:
                                                        Icons.videocam_outlined,
                                                    onTap: () async {
                                                      log('fffff');
                                                      setState(() {
                                                        cameraOn = !cameraOn;
                                                      });
                                                      agoraEngine.enableVideo();
                                                    },
                                                    offTap: () {
                                                      setState(() {
                                                        cameraOn = !cameraOn;
                                                      });
                                                      agoraEngine
                                                          .disableVideo();
                                                    },
                                                  ),
                                                  IconItem(
                                                    onIcon: Icons.volume_off,
                                                    offIcon: Icons.volume_up,
                                                    onTap: () async {
                                                      setState(() {
                                                        audioOn = !audioOn;
                                                      });
                                                      agoraEngine.enableAudio();
                                                    },
                                                    offTap: () {
                                                      setState(() {
                                                        audioOn = !audioOn;
                                                      });
                                                      agoraEngine
                                                          .disableAudio();
                                                    },
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      await createLink(
                                                              refCode: 'ahmed')
                                                          .then((value) {
                                                        log('share share share');

                                                        Share.share(value);
                                                      });
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: const Icon(
                                                        Icons.share,
                                                        size: 33,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      await createLink(
                                                              refCode: 'ahmed')
                                                          .then((value) {
                                                        log('share share share');

                                                        NavigationService.push(
                                                          page:
                                                              AllConversationsScreen(
                                                            link: value,
                                                          ),
                                                        );
                                                      });
                                                    },
                                                    child: Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8),
                                                      decoration: BoxDecoration(
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: MirrorWidget(
                                                        mirror: HelperFunctions
                                                                    .currentLanguage ==
                                                                'en'
                                                            ? false
                                                            : true,
                                                        child: const SizedBox(
                                                            height: 33,
                                                            width: 33,
                                                            child: Image(
                                                              image: AssetImage(
                                                                'assets/images/share.png',
                                                              ),
                                                              color:
                                                                  Colors.white,
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                        ),
                                      ),
                                    ],
                                    if (!liveType)
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 15),
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.4,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            IconItem(
                                                onIcon: Icons.mic_off,
                                                offIcon: Icons.mic,
                                                onTap: () async {
                                                  agoraEngine
                                                      .muteLocalAudioStream(
                                                          false);
                                                },
                                                offTap: () {
                                                  agoraEngine
                                                      .muteLocalAudioStream(
                                                          true);
                                                }),
                                            IconItem(
                                              onIcon:
                                                  Icons.videocam_off_outlined,
                                              offIcon: Icons.videocam_outlined,
                                              onTap: () async {
                                                log('fffff');

                                                agoraEngine.enableVideo();
                                              },
                                              offTap: () {
                                                agoraEngine.disableVideo();
                                              },
                                            ),
                                            IconItem(
                                              onIcon: Icons.volume_off,
                                              offIcon: Icons.volume_up,
                                              onTap: () async {
                                                agoraEngine.enableAudio();
                                              },
                                              offTap: () {
                                                agoraEngine.disableAudio();
                                              },
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                await createLink(
                                                        refCode: 'ahmed')
                                                    .then((value) {
                                                  log('share share share');

                                                  Share.share(value);
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.share,
                                                  size: 33,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                await createLink(
                                                        refCode: 'ahmed')
                                                    .then((value) {
                                                  log('share share share');

                                                  NavigationService.push(
                                                    page:
                                                        AllConversationsScreen(
                                                      link: value,
                                                    ),
                                                  );
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: MirrorWidget(
                                                  mirror: HelperFunctions
                                                              .currentLanguage ==
                                                          'en'
                                                      ? false
                                                      : true,
                                                  child: const SizedBox(
                                                      height: 33,
                                                      width: 33,
                                                      child: Image(
                                                        image: AssetImage(
                                                          'assets/images/share.png',
                                                        ),
                                                        color: Colors.white,
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.2,
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: ListView.separated(
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.5,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                decoration: BoxDecoration(
                                                    // border: Border.all(color: Colors.white),
                                                    gradient: LinearGradient(
                                                        begin: Alignment
                                                            .centerLeft,
                                                        end: Alignment
                                                            .centerRight,
                                                        colors: [
                                                          Colors.white
                                                              .withOpacity(0.4),
                                                          Colors.black
                                                              .withOpacity(0.1),
                                                        ]),
                                                    borderRadius:
                                                        const BorderRadius
                                                                .horizontal(
                                                            right:
                                                                Radius.circular(
                                                                    50))),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image: liveStickers[
                                                                          index]
                                                                      .userProfile !=
                                                                  null
                                                              ? DecorationImage(
                                                                  image:
                                                                      NetworkImage(
                                                                    liveStickers[
                                                                            index]
                                                                        .userProfile!,
                                                                  ),
                                                                  // "https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&quality=85&auto=format&fit=max&s=a52bbe202f57ac0f5ff7f47166906403"),
                                                                  fit: BoxFit
                                                                      .cover,
                                                                )
                                                              : null,
                                                        )),
                                                    Text(
                                                      "${liveStickers[index].userName}\n${liveStickers[index].stickerKind}",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                    Image.network(
                                                      // "https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&quality=85&auto=format&fit=max&s=a52bbe202f57ac0f5ff7f47166906403"
                                                      liveStickers[index]
                                                          .sticker,
                                                      width: 50,
                                                      height: 50,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                liveStickers[index]
                                                    .number
                                                    .toString(),
                                                style: const TextStyle(
                                                  color: Colors.amber,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 40,
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return const SizedBox(
                                            height: 10,
                                          );
                                        },
                                        itemCount: liveStickers.length,
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.1,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.9,
                                        child: ListView.separated(
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 40,
                                                  height: 40,
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          image:
                                                              DecorationImage(
                                                            image: NetworkImage(
                                                                "https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&quality=85&auto=format&fit=max&s=a52bbe202f57ac0f5ff7f47166906403"),
                                                            fit: BoxFit.cover,
                                                          )),
                                                ),
                                                Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.79,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                                  decoration: BoxDecoration(
                                                      gradient: LinearGradient(
                                                          end: Alignment
                                                              .bottomCenter,
                                                          begin: Alignment
                                                              .topCenter,
                                                          colors: [
                                                            Colors.white
                                                                .withOpacity(
                                                                    0.4),
                                                            Colors.black
                                                                .withOpacity(
                                                                    0.1),
                                                          ]),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  child: const Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        "الاسم",
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 18),
                                                      ),
                                                      Text(
                                                        "تعليقتعليقتعليقتعليقتعليقتعليقتعليقتعليقتعليقتعليقتعليق",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            );
                                          },
                                          separatorBuilder:
                                              (BuildContext context,
                                                  int index) {
                                            return const SizedBox(
                                              height: 10,
                                            );
                                          },
                                          itemCount: 4,
                                        ),
                                      ),
                                    ),
                                    if (!widget.liveCreator)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LiveChat(
                                                            liveProfile: widget
                                                                .liveModel
                                                                .creator
                                                                .profile,
                                                            liveUser:
                                                                'احمد احمد',
                                                          )));
                                            },
                                            child: const Icon(
                                              Icons.chat_bubble,
                                              size: 25,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: const Icon(
                                              Icons.local_florist_outlined,
                                              size: 25,
                                              color: Colors.pink,
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _controller =
                                                  scaffoldKey.currentState
                                                      ?.showBottomSheet(
                                                          (context) =>
                                                              Container(
                                                                width: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height *
                                                                    0.5,
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      const BorderRadiusDirectional
                                                                          .only(
                                                                    topStart: Radius
                                                                        .circular(
                                                                            20),
                                                                    topEnd: Radius
                                                                        .circular(
                                                                            20),
                                                                  ),
                                                                  color: Colors
                                                                          .grey[
                                                                      800],
                                                                ),
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .symmetric(
                                                                          horizontal:
                                                                              5.0),
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Container(
                                                                            width:
                                                                                30,
                                                                            height:
                                                                                30,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              shape: BoxShape.circle,
                                                                              border: Border.all(
                                                                                color: Colors.white,
                                                                              ),
                                                                              image: DecorationImage(
                                                                                image: NetworkImage(testImage1),
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          const Text(
                                                                            "أرسل هدية لتفعيل مستواك و مكافأتك كمقدم هدايا",
                                                                            style:
                                                                                TextStyle(
                                                                              color: Colors.white,
                                                                            ),
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {},
                                                                            child:
                                                                                const Icon(
                                                                              Icons.arrow_forward_ios,
                                                                              color: Colors.white,
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const Divider(
                                                                      color: Colors
                                                                          .grey,
                                                                    ),
                                                                    Expanded(
                                                                        child: GridView.builder(
                                                                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                                              crossAxisCount: 4,
                                                                              mainAxisExtent: 132,
                                                                              mainAxisSpacing: 5.0,
                                                                              crossAxisSpacing: 5.0,
                                                                            ),
                                                                            itemBuilder: (context, index) => InkWell(
                                                                                  onTap: () {
                                                                                    _controller!.setState!(() {
                                                                                      selectedItem[index] = !selectedItem[index];
                                                                                    });
                                                                                    log("selectedItem $selectedItem");
                                                                                  },
                                                                                  child: Container(
                                                                                    width: 100,
                                                                                    height: 132,
                                                                                    // padding: EdgeInsets.symmetric(horizontal: 10),
                                                                                    decoration: BoxDecoration(
                                                                                      color: selectedItem[index] ? Colors.black54 : null,
                                                                                      borderRadius: BorderRadius.circular(20),
                                                                                    ),
                                                                                    child: Column(
                                                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                                                      children: [
                                                                                        Image.network(
                                                                                          testImage1,
                                                                                          width: 80,
                                                                                          height: 80,
                                                                                        ),
                                                                                        const SizedBox(
                                                                                          width: 80,
                                                                                          child: Text(
                                                                                            "مقدمه لك",
                                                                                            softWrap: true,
                                                                                            textAlign: TextAlign.center,
                                                                                            style: TextStyle(
                                                                                              color: Colors.grey,
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        if (selectedItem[index])
                                                                                          InkWell(
                                                                                            onTap: () {},
                                                                                            child: Container(
                                                                                              width: 100,
                                                                                              alignment: Alignment.center,
                                                                                              color: Colors.red,
                                                                                              child: const Text(
                                                                                                "عرض",
                                                                                                textAlign: TextAlign.center,
                                                                                                style: TextStyle(color: Colors.white),
                                                                                              ),
                                                                                            ),
                                                                                          )
                                                                                        else
                                                                                          const Row(
                                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                                            // crossAxisAlignment: CrossAxisAlignment.center,
                                                                                            children: [
                                                                                              Icon(
                                                                                                Icons.circle,
                                                                                                color: Colors.amber,
                                                                                              ),
                                                                                              Text(
                                                                                                "${1}",
                                                                                                style: TextStyle(color: Colors.white),
                                                                                              )
                                                                                            ],
                                                                                          )
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ))),
                                                                    SizedBox(
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      height:
                                                                          30,
                                                                      child:
                                                                          Row(
                                                                        mainAxisSize:
                                                                            MainAxisSize.max,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Expanded(
                                                                            child:
                                                                                ListView.separated(
                                                                              itemBuilder: (context, index) => InkWell(
                                                                                onTap: () {},
                                                                                child: Container(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                                                                  alignment: Alignment.center,
                                                                                  child: const Text(
                                                                                    "الهدايا",
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              separatorBuilder: (BuildContext context, int index) {
                                                                                return const SizedBox(
                                                                                  width: 10,
                                                                                );
                                                                              },
                                                                              itemCount: 2,
                                                                              scrollDirection: Axis.horizontal,
                                                                            ),
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {},
                                                                            child:
                                                                                Container(
                                                                              margin: const EdgeInsets.symmetric(horizontal: 10),
                                                                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                                                                              decoration: BoxDecoration(
                                                                                color: Colors.black,
                                                                                borderRadius: BorderRadius.circular(8),
                                                                              ),
                                                                              child: const Row(
                                                                                children: [
                                                                                  Icon(
                                                                                    Icons.circle,
                                                                                    color: Colors.amber,
                                                                                  ),
                                                                                  Text(
                                                                                    "اعاده الشحن",
                                                                                    style: TextStyle(color: Colors.white),
                                                                                  ),
                                                                                  Icon(
                                                                                    Icons.arrow_forward_ios,
                                                                                    color: Colors.grey,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                          clipBehavior:
                                                              Clip.hardEdge,
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent);
                                              _controller!.closed.then((value) {
                                                setState(() {
                                                  bottomSheet = !bottomSheet;
                                                  for (int i = 0;
                                                      i < selectedItem.length;
                                                      i++) {
                                                    selectedItem[i] = false;
                                                  }
                                                });
                                              });
                                            },
                                            child: const Icon(
                                              Icons.card_giftcard,
                                              size: 25,
                                              color: Colors.pinkAccent,
                                            ),
                                          ),
/*
                              InkWell(
                                onTap: () {},
                                child: MirrorWidget(
                                  mirror: HelperFunctions.currentLanguage != 'en'
                                      ? false
                                      : true,
                                  child: const SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: Image(
                                        image: AssetImage(
                                          'assets/images/share.png',
                                        ),
                                        color: Colors.white,
                                      )),
                                ),
                              ),
*/
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.4,
                                            height: 30,
                                            child: TextFormField(
                                              controller: commentController,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLines: null,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              style: const TextStyle(
                                                  color: Colors.black),
                                              decoration: InputDecoration(
                                                hintText: "إضافه  تعليق",

                                                filled: true,
                                                fillColor: Colors.white
                                                    .withOpacity(0.4),
                                                // constraints: BoxConstraints(minHeight: 40,maxHeight: 40),
                                                hintMaxLines: 1,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                suffix: InkWell(
                                                  onTap: () {
                                                    log('ffffffffff');

                                                    if (commentController
                                                        .text.isNotEmpty) {
                                                      log('gggggggg');
                                                      try {
                                                        LiveCommentStoreRepo.storeComment(
                                                                liveId: widget
                                                                    .liveModel
                                                                    .id!,
                                                                comment:
                                                                    commentController
                                                                        .text)
                                                            .then((value) {
                                                          log('comment added successfully');
                                                          setState(() {
                                                            commentController
                                                                .clear();
                                                          });
                                                        }).catchError((error) {
                                                          log('comment added failed ${error.toString()}');
                                                        });
                                                      } catch (e) {
                                                        log(' comment error ${e.toString()}');
                                                      }
                                                    }
                                                  },
                                                  child: const Icon(
                                                    Icons.send,
                                                    size: 18,
                                                  ),
                                                ),
                                                border: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                focusedErrorBorder:
                                                    OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                errorBorder: OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                                disabledBorder:
                                                    OutlineInputBorder(
                                                        borderSide:
                                                            BorderSide.none,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30)),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {},
                                            child: const Icon(
                                              Icons.star,
                                              size: 25,
                                              color: Colors.amber,
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.22,
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        if (widget.liveCreator &&
                                            raiseHandList.isNotEmpty)
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                raiseHand = !raiseHand;
                                              });
                                            },
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white),
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  borderRadius:
                                                      const BorderRadius
                                                              .horizontal(
                                                          right:
                                                              Radius.circular(
                                                                  30))),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Text(
                                                    raiseHandList.length
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25),
                                                  ),
                                                  const Icon(
                                                    Icons.front_hand,
                                                    color: Colors.white,
                                                    size: 33,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        InkWell(
                                          onTap: () {
                                            if (!_isHost) {
                                              if (liked) {
                                                LiveDisLikeRepo.disLikeLive(
                                                        liveId: widget
                                                            .liveModel.id!)
                                                    .then((value) {
                                                  setState(() {
                                                    likes = value!;
                                                  });
                                                });
                                              } else {
                                                LiveLikeRepo.likeLive(
                                                        liveId: widget
                                                            .liveModel.id!)
                                                    .then((value) {
                                                  setState(() {
                                                    likes = value!;
                                                  });
                                                });
                                              }
                                              setState(() {
                                                liked = !liked;
                                              });
                                              log('liked ${liked}');

                                            }
                                          },
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white),
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                borderRadius: const BorderRadius
                                                        .horizontal(
                                                    right:
                                                        Radius.circular(30))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                if (likes > 0)
                                                  Text(
                                                    "$likes",
                                                    style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 25),
                                                  ),
                                                Icon(
                                                  liked
                                                      ? CupertinoIcons
                                                          .heart_fill
                                                      : CupertinoIcons.heart,
                                                  color: liked
                                                      ? Colors.red
                                                      : Colors.white,
                                                  size: 33,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          });
    }
    return Scaffold(
      key: scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leadingWidth: 70,
        toolbarHeight: 86,
        leading: Container(
          width: 10,
          height: 10,
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: profile != null
                      ? NetworkImage(profile!)
                      : const AssetImage(personProfile)
                          as ImageProvider<Object>,
                  fit: BoxFit.cover)),
          child: (widget.liveCreator)
              ? null
              : InkWell(
                  onTap: () {
                    FollowRepo.follow(
                      isFollow: followCreator,
                      body: {
                        'user_id': widget.liveModel.creator.id,
                      },
                    ).then((value) {
                      log('follow status changed ${value?.status}');
                    });
                  },
                  child: Container(
                    width: 10,
                    height: 10,
                    // padding: EdgeInsets.symmetric(horizontal: 15,vertical: 2),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        shape: BoxShape.circle
                        // borderRadius: BorderRadius.circular(30)
                        ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.red,
                    ),
                  ),
                ),
        ),
        title: (users?.length ?? 0) - 1 > 0
            ? (widget.liveCreator ||
                    (!widget.liveCreator &&
                        (widget.liveModel.attendance_view == 'public' ||
                            (widget.liveModel.attendance_view ==
                                'followers' //TODO: continue followers condition
                            ))))
                ? InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RoutePaths.liveAttendance,
                          arguments: users);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),

                          /*border: Border.all(
                    color: Colors.black,
                  ),*/
                          borderRadius: const BorderRadius.horizontal(
                              right: Radius.circular(30),
                              left: Radius.circular(30))),
                      child: Text(
                        "${(users ?? []).length - 1}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 25),
                      ),
                    ),
                  )
                : null
            : null,
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              padding: const EdgeInsets.all(12),
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.1),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.card_giftcard,
                    size: 30,
                    color: Colors.white,
                  ),
                  Text(
                    "1500",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.1),

              // border: Border.all(color: Colors.black),
              shape: BoxShape.circle,
            ),
            child: InkWell(
              onTap: () {
                CustomAwesomeDialog().showOptionsDialog(
                  context: context,
                  message: 'هل تريد الخروج من البث ؟',
                  btnOkText: 'خروج',
                  btnCancelText: 'cancel',
                  onConfirm: () {
                    leave();
                    Navigator.pop(context);

                    if (_isHost) {
                      Navigator.pop(context);
                    }
                  },
                  type: DialogType.warning,
                );
              },
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(child: _videoPanel()),
          ),
          SingleChildScrollView(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
/*
                decoration: BoxDecoration(
                  // color: Colors.white,
                    image: liveType
                        ? ( widget.liveModel.creator.profile == null
                        ? null
                        : DecorationImage(
                        image: widget.gallery
                            ? FileImage(File( widget.liveModel.creator.profile!))
                            : NetworkImage( widget.liveModel.creator.profile!)
                        as ImageProvider<Object>,
                        fit: BoxFit.cover,
                        opacity: 0.2,
                        colorFilter: const ColorFilter.mode(
                            Colors.black87, BlendMode.lighten)))
                        : const DecorationImage(
                        image: NetworkImage(
                          "https://www.cdc.gov/diabetes/images/research/reaching-treatment-goals.jpg?_=66821",
                        ),
                        fit: BoxFit.cover)),
*/
              alignment: Alignment.centerRight,
              color: liveType ? null : liveBackground,
              child: SafeArea(
                child: Stack(
                  alignment: const Alignment(0, 1),
                  children: [
                    Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        if (liveType)
                          Align(
                            alignment: const Alignment(0, -1.0),
                            child: Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.5,
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.08,
                                    child: ListView.separated(
                                        scrollDirection: Axis.horizontal,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        itemBuilder: (context, index) {
                                          if (index < 5) {
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    setState(() {
                                                      deleteShown[index] = true;
                                                    });
                                                    await Future.delayed(
                                                        const Duration(
                                                            milliseconds: 1500),
                                                        () {
                                                      setState(() {
                                                        deleteShown[index] =
                                                            false;
                                                      });
                                                    });
                                                  },
                                                  child: Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      CircleAvatar(
                                                        radius: 15,
                                                        backgroundImage:
                                                            NetworkImage(
                                                                testImage1),
                                                      ),
                                                      if (deleteShown[index])
                                                        InkWell(
                                                          onTap: () {
                                                            setState(() {
                                                              raiseHandList
                                                                  .removeAt(
                                                                      index);
                                                            });
                                                          },
                                                          child: const Icon(
                                                            Icons.close,
                                                            color: Colors.red,
                                                          ),
                                                        )
                                                    ],
                                                  ),
                                                ),
                                                Text(
                                                  raiseHandList[index],
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                )
                                              ],
                                            );
                                          } else {
                                            return Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        setState(() {
                                                          deleteShown[index] =
                                                              true;
                                                        });
                                                        await Future.delayed(
                                                            const Duration(
                                                                milliseconds:
                                                                    1500), () {
                                                          setState(() {
                                                            deleteShown[index] =
                                                                false;
                                                          });
                                                        });
                                                      },
                                                      child: Stack(
                                                        alignment:
                                                            Alignment.center,
                                                        children: [
                                                          CircleAvatar(
                                                            radius: 15,
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    testImage1),
                                                          ),
                                                          if (deleteShown[
                                                              index])
                                                            InkWell(
                                                              onTap: () {
                                                                setState(() {
                                                                  raiseHandList
                                                                      .removeAt(
                                                                          index);
                                                                });
                                                              },
                                                              child: const Icon(
                                                                Icons.close,
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            )
                                                        ],
                                                      ),
                                                    ),
                                                    Text(
                                                      raiseHandList[index],
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    )
                                                  ],
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                GuestsListPage(
                                                                  guestsData:
                                                                      raiseHandList,
                                                                  liveProfile: widget
                                                                      .liveModel
                                                                      .creator
                                                                      .profile,
                                                                )));
                                                  },
                                                  child: Container(
                                                    width: 50,
                                                    height: 50,
                                                    color: Colors.blue,
                                                    alignment: Alignment.center,
                                                    child: const Text(
                                                      "المزيد",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            );
                                          }
                                        },
                                        separatorBuilder: (context, index) =>
                                            const SizedBox(
                                              width: 10,
                                            ),
                                        itemCount: raiseHandList.length > 6
                                            ? 6
                                            : raiseHandList.length),
                                  ),
                                  if (widget.gallery)
                                    Image.file(
                                      File(widget.liveModel.creator.profile!),
                                      fit: BoxFit.cover,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      width: MediaQuery.of(context).size.width,
                                    )
                                  /*    : Image.network(
                                           widget.liveModel.creator.profile,
                                          fit: BoxFit.contain,
                                        )
                                  */
                                  ,
                                ],
                              ),
                            ),
                          ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              if (!liveType) ...[
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.32,
                                ),
                                if (widget.liveCreator &&
                                    raiseHand &&
                                    raiseHandList.isNotEmpty)
                                  Container(
                                    margin: const EdgeInsets.only(top: 5),
                                    height: MediaQuery.of(context).size.height *
                                        0.09,
                                    child: CarouselSlider.builder(
                                      options: CarouselOptions(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.09,
                                        viewportFraction: 0.25,
                                        autoPlay: true,
                                      ),
                                      itemCount: raiseHandList.length,
                                      itemBuilder: (BuildContext context,
                                          int index, int realIndex) {
                                        return Column(
                                          children: [
                                            Container(
                                              width: 30,
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                      image: NetworkImage(
                                                          testImage1),
                                                      fit: BoxFit.cover)),
                                            ),
                                            Text(
                                              raiseHandList[index],
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            SizedBox(
                                              width: 50,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        raiseHandList
                                                            .removeAt(index);
                                                      });
                                                    },
                                                    child: Container(
                                                      width: 15,
                                                      height: 15,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.green,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: const Icon(
                                                        Icons.check,
                                                        color: Colors.white,
                                                        size: 15,
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        raiseHandList
                                                            .removeAt(index);
                                                      });
                                                    },
                                                    child: Container(
                                                      width: 15,
                                                      height: 15,
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.red,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: const Icon(
                                                        Icons.close,
                                                        color: Colors.white,
                                                        size: 15,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  /* height: MediaQuery
                                      .of(context)
                                      .size
                                      .height * 0.4,*/
                                  child: Row(
                                    mainAxisAlignment: choicesHidden
                                        ? MainAxisAlignment.end
                                        : MainAxisAlignment.spaceEvenly,
                                    children: choicesHidden
                                        ? [
                                            InkWell(
                                              onTap: () async {
                                                setState(() {
                                                  choicesHidden = false;
                                                });
                                                await Future.delayed(
                                                    const Duration(
                                                        milliseconds: 1500),
                                                    () {
                                                  setState(() {
                                                    choicesHidden = true;
                                                  });
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.more_horiz,
                                                  size: 33,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ]
                                        : [
                                            IconItem(
                                              onIcon: Icons.mic_off,
                                              offIcon: Icons.mic,
                                              onTap: () async {
                                                agoraEngine
                                                    .muteLocalAudioStream(
                                                        false);
                                              },
                                              offTap: () {
                                                agoraEngine
                                                    .muteLocalAudioStream(true);
                                              },
                                            ),
                                            IconItem(
                                              onIcon:
                                                  Icons.videocam_off_outlined,
                                              offIcon: Icons.videocam_outlined,
                                              onTap: () async {
                                                log('fffff');

                                                agoraEngine.enableVideo();
                                              },
                                              offTap: () {
                                                agoraEngine.disableVideo();
                                              },
                                            ),
                                            IconItem(
                                              onIcon: Icons.volume_off,
                                              offIcon: Icons.volume_up,
                                              onTap: () async {
                                                agoraEngine.enableAudio();
                                              },
                                              offTap: () {
                                                agoraEngine.disableAudio();
                                              },
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                await createLink(
                                                        refCode: 'ahmed')
                                                    .then((value) {
                                                  log('share share share');
                                                  Share.share(value);
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(
                                                  Icons.share,
                                                  size: 33,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                await createLink(
                                                        refCode: 'ahmed')
                                                    .then((value) {
                                                  log('share share share');

                                                  NavigationService.push(
                                                    page:
                                                        AllConversationsScreen(
                                                      link: value,
                                                    ),
                                                  );
                                                });
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: MirrorWidget(
                                                  mirror: HelperFunctions
                                                              .currentLanguage ==
                                                          'en'
                                                      ? false
                                                      : true,
                                                  child: const SizedBox(
                                                      height: 33,
                                                      width: 33,
                                                      child: Image(
                                                        image: AssetImage(
                                                          'assets/images/share.png',
                                                        ),
                                                        color: Colors.white,
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ],
                                  ),
                                ),
                              ],
                              if (liveType)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  height:
                                      MediaQuery.of(context).size.height*MediaQuery.of(context).devicePixelRatio* 0.13,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      if (_isHost &&
                                          cameraOn &&
                                          cameras.length > 1)
                                        InkWell(
                                          onTap: () async {
                                            setState(() {
                                              on = !on;
                                            });

                                            await agoraEngine
                                                .switchCamera()
                                                .then((value) {
                                              log('success ');
                                            }).catchError((error) => log(
                                                    'error ${error.toString()}'));
                                          },
                                          child: Container(
                                              padding: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                shape: BoxShape.circle,
                                              ),
                                              child: Icon(
                                                on
                                                    ? Icons.camera_rear_outlined
                                                    : Icons
                                                        .camera_front_outlined,
                                                size: 33,
                                                color: Colors.white,
                                              )),
                                        ),
/*
                                      IconItem(
                                        onIcon: Icons.camera_front_outlined,
                                        offIcon: Icons.camera_rear_outlined,
                                        onTap: () async {
                                          log('ahmed');
try{

 await agoraEngine.switchCamera().then((value){log('success ');}).catchError((error)=>log('error ${error.toString()}'));

}
catch(er){
  log('er ${er.toString()}');
}
                                        },
                                        offTap: () async{
                                                                            },
                                      ),
*/

                                      IconItem(
                                          onIcon: Icons.mic_off,
                                          offIcon: Icons.mic,
                                          onTap: () async {
                                            agoraEngine
                                                .muteLocalAudioStream(false);
                                          },
                                          offTap: () {
                                            agoraEngine
                                                .muteLocalAudioStream(true);
                                          }),
                                      InkWell(
                                        onTap: () async {
                                          if (cameraOn) {
                                            agoraEngine
                                                .disableVideo()
                                                .then((value) {
                                              setState(() {
                                                cameraOn = false;
                                              });
                                            });
                                          } else {
                                            agoraEngine
                                                .enableVideo()
                                                .then((value) {
                                              setState(() {
                                                cameraOn = true;
                                              });
                                            });
                                          }
                                        },
                                        child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.1),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              cameraOn
                                                  ? Icons.videocam_off_outlined
                                                  : Icons.videocam_outlined,
                                              size: 33,
                                              color: Colors.white,
                                            )),
                                      )
/*
                                      IconItem(
                                        onIcon: Icons.videocam_off_outlined,
                                        offIcon: Icons.videocam_outlined,
                                        onTap: () async {
                                          log('fffff');

                                          agoraEngine
                                              .enableVideo()
                                              .then((value) {
                                            setState(() {
                                              cameraOn = true;
                                            });
                                          });
                                        },
                                        offTap: () {
                                          agoraEngine
                                              .disableVideo()
                                              .then((value) {
                                            setState(() {
                                              cameraOn = false;
                                            });
                                          });
                                        },
                                      ),
*/
                                      ,
                                      IconItem(
                                        onIcon: Icons.volume_off,
                                        offIcon: Icons.volume_up,
                                        onTap: () async {
                                          agoraEngine.enableAudio();
                                        },
                                        offTap: () {
                                          agoraEngine.disableAudio();
                                        },
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          await createLink(refCode: 'ahmed')
                                              .then((value) {
                                            log('share share share');
                                            Share.share(value);
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: const Icon(
                                            Icons.share,
                                            size: 33,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          await createLink(refCode: 'ahmed')
                                              .then((value) {
                                            log('share share share');
                                            NavigationService.push(
                                              page: AllConversationsScreen(
                                                link: value,
                                              ),
                                            );
                                          }).catchError((error) {
                                            log('share Error ${error.toString()}');
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            shape: BoxShape.circle,
                                          ),
                                          child: MirrorWidget(
                                            mirror: HelperFunctions
                                                        .currentLanguage ==
                                                    'en'
                                                ? false
                                                : true,
                                            child: const SizedBox(
                                                height: 33,
                                                width: 33,
                                                child: Image(
                                                  image: AssetImage(
                                                    'assets/images/share.png',
                                                  ),
                                                  color: Colors.white,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              if (liveStickers.isNotEmpty)
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: ListView.separated(
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                                // border: Border.all(color: Colors.white),
                                                gradient: LinearGradient(
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                    colors: [
                                                      Colors.white
                                                          .withOpacity(0.4),
                                                      Colors.black
                                                          .withOpacity(0.1),
                                                    ]),
                                                borderRadius: const BorderRadius
                                                        .horizontal(
                                                    right:
                                                        Radius.circular(50))),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  width: 60,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            liveStickers[index]
                                                                .userProfile!),
                                                        // "https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&quality=85&auto=format&fit=max&s=a52bbe202f57ac0f5ff7f47166906403"),
                                                        fit: BoxFit.cover,
                                                      )),
                                                ),
                                                Text(
                                                  "${liveStickers[index].userName}\n${liveStickers[index].stickerKind}",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                Image.network(
                                                  liveStickers[index].sticker,
                                                  // "https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&quality=85&auto=format&fit=max&s=a52bbe202f57ac0f5ff7f47166906403",
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.cover,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            liveStickers[index]
                                                .number
                                                .toString(),
                                            style: const TextStyle(
                                              color: Colors.amber,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 40,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(
                                        height: 10,
                                      );
                                    },
                                    itemCount: liveStickers.length,
                                  ),
                                ),
                              if (liveComments.isNotEmpty)
                                Expanded(
                                  child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.1,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    child: ListView.separated(
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        if (index == 0) {
                                          opacityTimer = Timer(
                                              const Duration(
                                                  milliseconds: 2000), () {
                                            if (opacityValue < 0.2) {
                                              setState(() {
                                                opacityValue = 1.0;
                                                liveComments.removeAt(0);
                                              });
                                            } else {
                                              setState(() {
                                                opacityValue =
                                                    opacityValue - 0.1;
                                              });
                                            }
                                            // log('op $opacityValue');
                                          });
                                        }

                                        return Opacity(
                                          opacity:
                                              index == 0 ? opacityValue : 1.0,
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                width: 40,
                                                height: 40,
                                                decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                      image: liveComments[index]
                                                                  .profile !=
                                                              null
                                                          ? NetworkImage(
                                                              liveComments[
                                                                      index]
                                                                  .profile!,
                                                            )
                                                          : const AssetImage(
                                                              personProfile,
                                                            ) as ImageProvider<
                                                              Object>,
                                                      // "https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&quality=85&auto=format&fit=max&s=a52bbe202f57ac0f5ff7f47166906403"),
                                                      fit: BoxFit.cover,
                                                    )),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.79,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 5),
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        end: Alignment
                                                            .bottomCenter,
                                                        begin:
                                                            Alignment.topCenter,
                                                        colors: [
                                                          Colors.white
                                                              .withOpacity(0.4),
                                                          Colors.black
                                                              .withOpacity(0.1),
                                                        ]),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      liveComments[index].name,
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 18),
                                                    ),
                                                    Text(
                                                      liveComments[index]
                                                          .comment,
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 20,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder:
                                          (BuildContext context, int index) {
                                        return const SizedBox(
                                          height: 10,
                                        );
                                      },
                                      itemCount: liveComments.length,
                                      // reverse: true,
                                    ),
                                  ),
                                ),
                              const SizedBox(
                                height: 40,
                              ),
                              if (!widget.liveCreator)
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LiveChat(
                                                        liveProfile: widget
                                                            .liveModel
                                                            .creator
                                                            .profile,
                                                        liveUser: 'احمد احمد',
                                                      )));
                                        },
                                        child: const Icon(
                                          Icons.chat_bubble,
                                          size: 25,
                                          color: Colors.blue,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.local_florist_outlined,
                                          size: 25,
                                          color: Colors.pink,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          _controller =
                                              scaffoldKey.currentState
                                                  ?.showBottomSheet(
                                                      (context) => Container(
                                                            width:
                                                                MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width,
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.5,
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        10),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  const BorderRadiusDirectional
                                                                      .only(
                                                                topStart: Radius
                                                                    .circular(
                                                                        20),
                                                                topEnd: Radius
                                                                    .circular(
                                                                        20),
                                                              ),
                                                              color: Colors
                                                                  .grey[800],
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsets
                                                                          .symmetric(
                                                                      horizontal:
                                                                          5.0),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Container(
                                                                        width:
                                                                            30,
                                                                        height:
                                                                            30,
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          border:
                                                                              Border.all(
                                                                            color:
                                                                                Colors.white,
                                                                          ),
                                                                          image:
                                                                              DecorationImage(
                                                                            image:
                                                                                NetworkImage(testImage1),
                                                                            fit:
                                                                                BoxFit.cover,
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const Text(
                                                                        "أرسل هدية لتفعيل مستواك و مكافأتك كمقدم هدايا",
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {},
                                                                        child:
                                                                            const Icon(
                                                                          Icons
                                                                              .arrow_forward_ios,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const Divider(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                                Expanded(
                                                                    child: GridView.builder(
                                                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                                                          crossAxisCount:
                                                                              4,
                                                                          mainAxisExtent:
                                                                              132,
                                                                          mainAxisSpacing:
                                                                              5.0,
                                                                          crossAxisSpacing:
                                                                              5.0,
                                                                        ),
                                                                        itemBuilder: (context, index) => InkWell(
                                                                              onTap: () {
                                                                                _controller!.setState!(() {
                                                                                  selectedItem[index] = !selectedItem[index];
                                                                                });
                                                                                log("selectedItem $selectedItem");
                                                                              },
                                                                              child: Container(
                                                                                width: 100,
                                                                                height: 132,
                                                                                // padding: EdgeInsets.symmetric(horizontal: 10),
                                                                                decoration: BoxDecoration(
                                                                                  color: selectedItem[index] ? Colors.black54 : null,
                                                                                  borderRadius: BorderRadius.circular(20),
                                                                                ),
                                                                                child: Column(
                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                  children: [
                                                                                    Image.network(
                                                                                      testImage1,
                                                                                      width: 80,
                                                                                      height: 80,
                                                                                    ),
                                                                                    const SizedBox(
                                                                                      width: 80,
                                                                                      child: Text(
                                                                                        "مقدمه لك",
                                                                                        softWrap: true,
                                                                                        textAlign: TextAlign.center,
                                                                                        style: TextStyle(
                                                                                          color: Colors.grey,
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    if (selectedItem[index])
                                                                                      InkWell(
                                                                                        onTap: () {},
                                                                                        child: Container(
                                                                                          width: 100,
                                                                                          alignment: Alignment.center,
                                                                                          color: Colors.red,
                                                                                          child: const Text(
                                                                                            "عرض",
                                                                                            textAlign: TextAlign.center,
                                                                                            style: TextStyle(color: Colors.white),
                                                                                          ),
                                                                                        ),
                                                                                      )
                                                                                    else
                                                                                      const Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        // crossAxisAlignment: CrossAxisAlignment.center,
                                                                                        children: [
                                                                                          Icon(
                                                                                            Icons.circle,
                                                                                            color: Colors.amber,
                                                                                          ),
                                                                                          Text(
                                                                                            "${1}",
                                                                                            style: TextStyle(color: Colors.white),
                                                                                          )
                                                                                        ],
                                                                                      )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ))),
                                                                SizedBox(
                                                                  width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                                  height: 30,
                                                                  child: Row(
                                                                    mainAxisSize:
                                                                        MainAxisSize
                                                                            .max,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .center,
                                                                    children: [
                                                                      Expanded(
                                                                        child: ListView
                                                                            .separated(
                                                                          itemBuilder: (context, index) =>
                                                                              InkWell(
                                                                            onTap:
                                                                                () {},
                                                                            child:
                                                                                Container(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                                                              alignment: Alignment.center,
                                                                              child: const Text(
                                                                                "الهدايا",
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(color: Colors.white),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          separatorBuilder:
                                                                              (BuildContext context, int index) {
                                                                            return const SizedBox(
                                                                              width: 10,
                                                                            );
                                                                          },
                                                                          itemCount:
                                                                              2,
                                                                          scrollDirection:
                                                                              Axis.horizontal,
                                                                        ),
                                                                      ),
                                                                      InkWell(
                                                                        onTap:
                                                                            () {},
                                                                        child:
                                                                            Container(
                                                                          margin:
                                                                              const EdgeInsets.symmetric(horizontal: 10),
                                                                          padding: const EdgeInsets.symmetric(
                                                                              horizontal: 5,
                                                                              vertical: 2),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                Colors.black,
                                                                            borderRadius:
                                                                                BorderRadius.circular(8),
                                                                          ),
                                                                          child:
                                                                              const Row(
                                                                            children: [
                                                                              Icon(
                                                                                Icons.circle,
                                                                                color: Colors.amber,
                                                                              ),
                                                                              Text(
                                                                                "اعاده الشحن",
                                                                                style: TextStyle(color: Colors.white),
                                                                              ),
                                                                              Icon(
                                                                                Icons.arrow_forward_ios,
                                                                                color: Colors.grey,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                      clipBehavior:
                                                          Clip.hardEdge,
                                                      backgroundColor:
                                                          Colors.transparent);
                                          _controller!.closed.then((value) {
                                            setState(() {
                                              bottomSheet = !bottomSheet;
                                              for (int i = 0;
                                                  i < selectedItem.length;
                                                  i++) {
                                                selectedItem[i] = false;
                                              }
                                            });
                                          });
                                        },
                                        child: const Icon(
                                          Icons.card_giftcard,
                                          size: 25,
                                          color: Colors.pinkAccent,
                                        ),
                                      ),
/*
                                      InkWell(
                                        onTap: () {},
                                        child: MirrorWidget(
                                          mirror: HelperFunctions.currentLanguage != 'en'
                                              ? false
                                              : true,
                                          child: const SizedBox(
                                              height: 25,
                                              width: 25,
                                              child: Image(
                                                image: AssetImage(
                                                  'assets/images/share.png',
                                                ),
                                                color: Colors.white,
                                              )),
                                        ),
                                      ),
*/
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        height: 30,
                                        child: TextFormField(
                                          controller: commentController,
                                          keyboardType: TextInputType.multiline,
                                          maxLines: null,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          style: const TextStyle(
                                              color: Colors.black),
                                          decoration: InputDecoration(
                                            hintText: "إضافه  تعليق",

                                            filled: true,
                                            fillColor:
                                                Colors.white.withOpacity(0.4),
                                            // constraints: BoxConstraints(minHeight: 40,maxHeight: 40),
                                            hintMaxLines: 1,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 10),
                                            suffix: InkWell(
                                              onTap: () {
                                                log('ffffffffff');

                                                if (commentController
                                                    .text.isNotEmpty) {
                                                  log('gggggggg');
                                                  try {
                                                    LiveCommentStoreRepo
                                                            .storeComment(
                                                                liveId: widget
                                                                    .liveModel
                                                                    .id!,
                                                                comment:
                                                                    commentController
                                                                        .text)
                                                        .then((value) {
                                                      log('comment added successfully');
                                                      setState(() {
                                                        commentController
                                                            .clear();
                                                      });
                                                    }).catchError((error) {
                                                      log('comment added failed ${error.toString()}');
                                                    });
                                                  } catch (e) {
                                                    log(' comment error ${e.toString()}');
                                                  }
                                                }
                                              },
                                              child: const Icon(
                                                Icons.send,
                                                size: 13,
                                              ),
                                            ),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            focusedErrorBorder:
                                                OutlineInputBorder(
                                                    borderSide: BorderSide.none,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                            disabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide.none,
                                                borderRadius:
                                                    BorderRadius.circular(30)),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: const Icon(
                                          Icons.star,
                                          size: 25,
                                          color: Colors.amber,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.22,
                              height: MediaQuery.of(context).size.height * 0.4,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  if ((widget.liveCreator &&
                                          raiseHandList.isNotEmpty) ||
                                      (!widget.liveCreator))
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          raiseHand = !raiseHand;
                                        });
                                        log('speaker speaker');
                                        /*   agoraEngine.isSpeakerphoneEnabled().then((value){
                                          log('speaker $value');
                                          agoraEngine.setEnableSpeakerphone(true).then((value){
                                            log('speaker is enabled');
                                          });
                                        });*/
                                        // agoraEngine.setEnableSpeakerphone();
                                        // agoraEngine.setDefaultAudioRouteToSpeakerphone();
                                        // agoraEngine.setCameraTorchOn();
                                        // agoraEngine.setSubscribeAudioAllowlist(uidList: uidList, uidNumber: uidNumber);
                                        // agoraEngine.setSubscribeVideoAllowlist(uidList: uidList, uidNumber: uidNumber);
                                        // agoraEngine.setSubscribeVideoBlocklist(uidList: uidList, uidNumber: uidNumber);
                                        // agoraEngine.setSubscribeAudioBlocklist(uidList: uidList, uidNumber: uidNumber);

                                        agoraEngine
                                            .updateChannelMediaOptions(
                                                const ChannelMediaOptions(
                                          clientRoleType: ClientRoleType
                                              .clientRoleBroadcaster,
                                          channelProfile: ChannelProfileType
                                              .channelProfileLiveBroadcasting,
                                        ))
                                            .then((value) {
                                          log('media change');
                                        }).catchError((error) {
                                          log('media change error ${error.toString()}');
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            borderRadius:
                                                const BorderRadius.horizontal(
                                                    right:
                                                        Radius.circular(30))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Text(
                                              raiseHandList.length.toString(),
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 25),
                                            ),
                                            const Icon(
                                              Icons.front_hand,
                                              color: Colors.white,
                                              size: 33,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  if ((widget.liveCreator &&
                                          widget.liveModel.likes > 0) ||
                                      (!widget.liveCreator))
                                    InkWell(
                                      onTap: () {
                                        log('widget.liveModel.id ${widget.liveModel.id}');
                                        if (!widget.liveCreator) {
                                          if (liked) {
                                            LiveDisLikeRepo.disLikeLive(
                                                    liveId:
                                                        widget.liveModel.id!)
                                                .then((value) {
                                              setState(() {
                                                likes = value!;
                                              });
                                            });
                                          } else {
                                            LiveLikeRepo.likeLive(
                                                    liveId:
                                                        widget.liveModel.id!)
                                                .then((value) {
                                              setState(() {
                                                likes = value!;
                                              });
                                            });
                                          }
                                          setState(() {
                                            liked = !liked;
                                          });
                                        }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            borderRadius:
                                                const BorderRadius.horizontal(
                                                    right:
                                                        Radius.circular(30))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            if (likes > 0)
                                              Text(
                                                "$likes",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25),
                                              ),
                                            Icon(
                                              liked
                                                  ? CupertinoIcons.heart_fill
                                                  : CupertinoIcons.heart,
                                              color: liked
                                                  ? Colors.red
                                                  : Colors.white,
                                              size: 33,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  if ((comments??[]).isNotEmpty)
                                    InkWell(
                                      onTap: () {
                                        log('widget.liveModel.id ${widget.liveModel.id}');

/*
                                      Expanded(
                                        child: GestureDetector(
                                          onVerticalDragEnd: (dragUpdateDetails) {
                                            setState(() {
                                              shown = false;
                                            });
                                          },
                                          child: Container(
                                            height: MediaQuery.sizeOf(context).height * 0.46,
                                            width: MediaQuery.sizeOf(context).width,
                                            color: Colors.transparent,
                                            child: Column(
                                              children: [
                                                if(ribbonShow)
                                                  Row(
                                                    mainAxisSize: MainAxisSize.max,
                                                    children: [
                                                      if(widget.liveModel.privelegeComments == 'public')
                                                        TabWidget(
                                                          title: "التعليقات",
                                                          tabTap: () {
                                                            setState(() {
                                                              tabIndex = 0;
                                                            });
                                                          },
                                                          active: tabIndex == 0,
                                                        ),
                                                      if(widget.liveModel.attendance_view == 'public')
                                                        TabWidget(
                                                          title: "الجمهور",
                                                          tabTap: () {
                                                            setState(() {
                                                              tabIndex = 1;
                                                            });
                                                          },
                                                          active: tabIndex == 1,
                                                        ),
                                                      if(widget.liveModel.gifts == 'public')
                                                        TabWidget(
                                                          title: "الهدايا",
                                                          tabTap: () {
                                                            setState(() {
                                                              tabIndex = 2;
                                                            });
                                                          },
                                                          active: tabIndex == 2,
                                                        ),
                                                    ],
                                                  ),
                                                if(tabWidgets.isNotEmpty)
                                                  Expanded(child: tabWidgets[tabIndex])
                                              ],
                                            ),
                                          ),
                                        ),
                                      )
*/
                                        setState(() {
                                          shown = true;
                                        });

                                        _controller = scaffoldKey.currentState
                                            ?.showBottomSheet((context) {
                                          return Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.5,
                                            padding: const EdgeInsets.only(
                                                top: 20,
                                                bottom: 10,
                                                right: 10,
                                                left: 10),
                                            decoration: const BoxDecoration(
                                              borderRadius:
                                                  BorderRadiusDirectional.only(
                                                topStart: Radius.circular(20),
                                                topEnd: Radius.circular(20),
                                              ),
                                              color: liveBackground,
                                            ),
                                            child: (widget.liveModel
                                                        .privelegeComments ==
                                                    'public')
                                                ? tabCommentWidget(
                                                    liveComments:
                                                        liveCommentsListView,
                                                    deleteFunction:
                                                        (int index) {
                                                      LiveCommentDestroyRepo
                                                              .destroyComment(
                                                                  messageId:
                                                                      liveCommentsListView[
                                                                              index]
                                                                          .id!)
                                                          .then((value) {
                                                        _controller!.setState!(
                                                            () {
                                                          liveCommentsListView
                                                              .removeAt(index);
                                                        });
                                                        previousLiveCommentsLength -=
                                                            1;
                                                        if (liveCommentsListView
                                                            .isEmpty) {
                                                          _controller!.close();
                                                        }
                                                      });
                                                    },
                                                    blockFunction: () {},
                                                    reportFunction: () {})
                                                : null,
                                          );
                                        },
                                                clipBehavior: Clip.hardEdge,
                                                backgroundColor:
                                                    Colors.transparent);
                                        _controller!.closed.then((value) {
                                          setState(() {
                                            bottomSheet = !bottomSheet;
                                          });
                                        });
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 5),
                                        decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.white),
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            borderRadius:
                                                const BorderRadius.horizontal(
                                                    right:
                                                        Radius.circular(30))),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            if (((comments ??
                                                    [])
                                                .isNotEmpty))
                                              Text(
                                                "${(comments ?? []).length}",
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 25),
                                              ),
                                            const Icon(
                                              Icons.comment_outlined,
                                              color: Colors.white,
                                              size: 33,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                    /*if (shown)
                      Expanded(
                        child: GestureDetector(
                          onVerticalDragEnd: (dragUpdateDetails) {
                            setState(() {
                              shown = false;
                            });
                          },
                          child: Container(
                            height: MediaQuery.sizeOf(context).height * 0.46,
                            width: MediaQuery.sizeOf(context).width,
                            color: Colors.transparent,
                            child: Column(
                              children: [
                                if (ribbonShow)
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      if (widget.liveModel.privelegeComments ==
                                          'public')
                                        TabWidget(
                                          title: "التعليقات",
                                          tabTap: () {
                                            setState(() {
                                              tabIndex = 0;
                                            });
                                          },
                                          active: tabIndex == 0,
                                        ),
                                      if (widget.liveModel.attendance_view ==
                                          'public')
                                        TabWidget(
                                          title: "الجمهور",
                                          tabTap: () {
                                            setState(() {
                                              tabIndex = 1;
                                            });
                                          },
                                          active: tabIndex == 1,
                                        ),
                                      if (widget.liveModel.gifts == 'public')
                                        TabWidget(
                                          title: "الهدايا",
                                          tabTap: () {
                                            setState(() {
                                              tabIndex = 2;
                                            });
                                          },
                                          active: tabIndex == 2,
                                        ),
                                    ],
                                  ),
                                if (tabWidgets.isNotEmpty)
                                  Expanded(child: tabWidgets[tabIndex])
                              ],
                            ),
                          ),
                        ),
                      )
                    else if (ribbonShow)
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (widget.liveModel.privelegeComments == 'public')
                            TabWidget(
                              title: "التعليقات",
                              tabTap: () {
                                if (!shown) {
                                  setState(() {
                                    shown = true;
                                  });
                                }
                                setState(() {
                                  tabIndex = 0;
                                });
                              },
                              active: tabIndex == 0,
                            ),
                          if (widget.liveModel.attendance_view == 'public')
                            TabWidget(
                              title: "الجمهور",
                              tabTap: () {
                                if (!shown) {
                                  setState(() {
                                    shown = true;
                                  });
                                }
                                setState(() {
                                  tabIndex = 1;
                                });
                              },
                              active: tabIndex == 1,
                            ),
                          if (widget.liveModel.gifts == 'public')
                            TabWidget(
                              title: "الهدايا",
                              tabTap: () {
                                if (!shown) {
                                  setState(() {
                                    shown = true;
                                  });
                                }
                                setState(() {
                                  tabIndex = 2;
                                });
                              },
                              active: tabIndex == 2,
                            ),
                        ],
                      ),*/
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: widget.liveCreator &&
              (users ?? []).length > 1
          ? FloatingActionButton(
              onPressed: () {
                setState(() {
                  shown = !shown;
                });
                if (shown) {
                  _controller = scaffoldKey.currentState?.showBottomSheet(
                      (context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 10, right: 10, left: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(20),
                          topEnd: Radius.circular(20),
                        ),
                        color: liveBackground,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(mainAxisSize: MainAxisSize.max, children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  _controller!.setState!(() {
                                    chatTabIndex = 0;
                                  });
                                },
                                child: SizedBox(
                                  height: 20.h,
                                  child: const Text('chats',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  _controller!.setState!(() {
                                    chatTabIndex = 1;
                                  });
                                },
                                child: SizedBox(
                                  width: MediaQuery.sizeOf(context).width / 2,
                                  height: 20.h,
                                  child: const Text(' create chat',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white)),
                                ),
                              ),
                            ),
                          ]),
                          Expanded(
                              child: chatTabWidgets(
                                  index: chatTabIndex,
                                  data: chatTabIndex == 1
                                      ? users
                                      : []))
                        ],
                      ),
                    );
                  },
                      clipBehavior: Clip.hardEdge,
                      backgroundColor: Colors.transparent);
                } else {
                  _controller!.close();
                }
                _controller!.closed.then((value) {
                  setState(() {
                    shown = !shown;
                  });
                });
              },
              backgroundColor: liveBackground,
              child: const Icon(
                Icons.chat,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}

Widget tabCommentWidget({
  required List<LiveComments> liveComments,
  required void Function(int index) deleteFunction,
  required void Function() blockFunction,
  required void Function() reportFunction,
}) {
  return ListView.separated(
    padding: const EdgeInsets.only(bottom: 10),
    itemBuilder: (context, index) {
      int reverseIndex = liveComments.length - index - 1;
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: liveComments[reverseIndex].profile != null
                ? NetworkImage(liveComments[reverseIndex].profile!)
                : const AssetImage(personProfile) as ImageProvider<Object>,
            radius: 25,
          ),
          SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.9 * 0.68,
            child: Text(
              "${liveComments[reverseIndex].name}\n\t${liveComments[reverseIndex].comment}",
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
          if (liveComments[reverseIndex].userId !=
              HelperFunctions.currentUser!.id)
            PopupMenuButton(
              icon: const Icon(
                Icons.info_outline,
                color: Colors.white,
              ),
              onSelected: (value) {
                if (!HelperFunctions.validateLogin()) {
                  return;
                }
                /* if (value == 'report') {
  showDialog(
  context: context,
  builder: (context) =>
 */ /* BlocProvider(
  create: (context) => CreateReportCubit(),
  child: ReportDialog(
  reportType: reportType,
  reportTypeId: reportTypeId,
  ),
  ),*/ /*
  );
  } else*/
                if (value == "delete") {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      content: Text(
                        'do_you_want_to_scan'.translate,
                        style: const TextStyle(fontSize: 24),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            // var videoData =
                            /*await RemoveVideoRepo.removeVideo(
  context, body: {"video_id":"$reportTypeId"});*/
                            NavigationService.goBack();

                            // print("ggggggggggggg ${reportTypeId}");
                            /*NavigationService.goBack();
                    storiesCubit.deleteStoryByIndex(
                        storyIndex: storyIndex,
                        pageIndex: pageIndex,
                        userId: storiesCubit
                            .stories[pageIndex].id ??
                            0,
                        context: context);*/
                          },
                          child: Text(
                            'yes'.translate,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            NavigationService.goBack();
                          },
                          child: Text(
                            'no'.translate,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (value == "block") {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      content: const Text(
                        'block_' //${reportType.name}_confirm'.translate
                        ,
                        style: TextStyle(fontSize: 24),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            NavigationService.goBack();
                          },
                          child: Text(
                            'no'.translate,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            // var videoData =
                            // submitBlock(blockType: reportType, blockTypeId: reportTypeId!);

                            // print("ggggggggggggg ${reportTypeId}");
                            /*NavigationService.goBack();
                    storiesCubit.deleteStoryByIndex(
                        storyIndex: storyIndex,
                        pageIndex: pageIndex,
                        userId: storiesCubit
                            .stories[pageIndex].id ??
                            0,
                        context: context);*/
                          },
                          child: Text(
                            'block'.translate,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  );
                  /* CustomAwesomeDialog().showOptionsDialog(
            context: context,
            message: 'block_post_confirm'.translate,
            btnOkText: 'block',
            btnCancelText: 'cancel',
            onConfirm: () {
              submitBlock(blockType: ReportType.post, blockTypeId: reportTypeId!);
            },
            type: DialogType.warning,
          );*/
                }
              },
              position: PopupMenuPosition.under,
              itemBuilder: (_) => [
                if (liveComments[reverseIndex].userId !=
                    HelperFunctions.currentUser!
                        .id) /*...[
  HelperFunctions.buildPopupMenu(
  icons: Icons.edit, title: 'edit', value: 'edit'),
  HelperFunctions.buildPopupMenu(
  icons: Icons.delete, title: 'delete', value: 'delete'),
  ] else*/
                  ...[
                  HelperFunctions.buildPopupMenu(
                      icons: Icons.report, title: 'report', value: 'report'),
                  HelperFunctions.buildPopupMenu(
                      icons: Icons.block, title: 'block', value: 'block'),
                ]
              ],
            )
          else
            InkWell(
              onTap: () {
                CustomAwesomeDialog().showOptionsDialog(
                  context: context,
                  message: 'هل تريد حذف تعليقك ؟',
                  btnOkText: 'خروج',
                  btnCancelText: 'cancel',
                  onConfirm: () {
                    deleteFunction(reverseIndex);
                    // Navigator.pop(context);
                  },
                  type: DialogType.warning,
                );
              },
              child: const Icon(
                Icons.close,
                color: Colors.white,
              ),
            ),
        ],
      );
    },
    separatorBuilder: (BuildContext context, int index) => const Divider(
      color: Colors.grey,
      indent: 20,
      endIndent: 20,
    ),
    itemCount: liveComments.length,
  );
}

Widget tabPublicWidget({bool tabPublicEnable = true}) {
  double radius = 50.0;
  return GridView.builder(
/*
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: radius,
        mainAxisExtent: radius+19,
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
      ),
*/
    gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
    itemBuilder: (context, index) => InkWell(
      onTap: () {},
      child: tabPublicEnable
          ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: radius,
                  height: radius,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBOn9shF9kc5vPqgA30DXU0prx5-aYyh28Rw&usqp=CAU"),
                        fit: BoxFit.cover,
                      )),
                ),
                const Text(
                  "100 ريال",
                  style: TextStyle(fontSize: 10),
                ),
              ],
            )
          : Container(
              width: radius,
              height: radius,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRBOn9shF9kc5vPqgA30DXU0prx5-aYyh28Rw&usqp=CAU"),
                    fit: BoxFit.cover,
                  )),
            ),
    ),
    padding: const EdgeInsets.all(4),
  );
}
