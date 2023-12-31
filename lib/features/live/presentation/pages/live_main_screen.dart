import 'dart:async';
import 'dart:developer';

import 'package:creen/features/live/model/live_model.dart';
import 'package:creen/features/live/presentation/models/live_item_model.dart';
import 'package:creen/features/live/presentation/pages/live_screen.dart';
import 'package:creen/features/live/presentation/pages/live_start_screen.dart';
import 'package:creen/features/live/repo/live_repo.dart';
import 'package:flutter/material.dart';

import '../../viewModel/live/live_main_cubit.dart';
import '../widgets/grid_view_item.dart';

class LiveMainScreen extends StatefulWidget {
  const LiveMainScreen({super.key});

  @override
  State<LiveMainScreen> createState() => _LiveMainScreenState();
}

class _LiveMainScreenState extends State<LiveMainScreen> {
  bool openScreen = false;
  late LiveMainCubit liveMainCubit;
  List<LiveItemModel> liveList= [
LiveItemModel(name: 'test', content: 'content', userProfile: 'https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&quality=85&auto=format&fit=max&s=a52bbe202f57ac0f5ff7f47166906403', liveSnapshot: '/storage/emulated/0/Android/data/com.creen_program/files/example.jpg'),
  ];
 List<LiveDataModel>? live;
/*
  int uid = 0; // uid of the local user

  int? _remoteUid; // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel
  bool _isHost =
      true; // Indicates whether the user has joined as a host or audience
  late RtcEngine agoraEngine; // Agora engine instance
  Future<void> setupVideoSDKEngine() async {
    // retrieve or request camera and microphone permissions
    await [Permission.microphone, Permission.camera].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(appId: appId));

    await agoraEngine.enableVideo();

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          log("Local user uid:${connection.localUid} joined the channel");
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          log("Remote user uid:$remoteUid joined the channel");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          log("Remote user uid:$remoteUid left the channel");
          setState(() {
            _remoteUid = null;
          });
        },
      ),
    );
  }

  void join() async {
    // Set channel options
    ChannelMediaOptions options;

    // Set channel profile and client role
    if (_isHost) {
      options = const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleBroadcaster,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      );
      await agoraEngine.startPreview();
    } else {
      options = const ChannelMediaOptions(
        clientRoleType: ClientRoleType.clientRoleAudience,
        channelProfile: ChannelProfileType.channelProfileLiveBroadcasting,
      );
    }

    await agoraEngine.joinChannel(
      token: token,
      channelId: channelName,
      options: options,
      uid: uid,
    );
  }

  void leave() {
    setState(() {
      _isJoined = false;
      _remoteUid = null;
    });
    agoraEngine.leaveChannel();
  }

// Set the client role when a radio button is selected
  void _handleRadioValueChange(bool? value) async {
    setState(() {
      _isHost = (value == true);
    });
    if (_isJoined) leave();
  }

  Widget _videoPanel() {
    if (!_isJoined) {
      return const Text(
        'Join a channel',
        textAlign: TextAlign.center,
      );
    } else if (_isHost) {
      // Show local video preview
      return AgoraVideoView(
        controller: VideoViewController(
          rtcEngine: agoraEngine,
          canvas: VideoCanvas(uid: 0),
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
        return const Text(
          'Waiting for a host to join',
          textAlign: TextAlign.center,
        );
      }
    }
  }
*/
Timer? timer;
  @override
  void initState() {
    liveMainCubit = LiveMainCubit.get(context);
    timer = Timer.periodic(const Duration(seconds: 2), (Timer t) {
      LiveRepo.getLive().then((value) {
        setState(() {
          live = value!.data!;
        });
    });
/*    setupVideoSDKEngine().then((value) {
      _handleRadioValueChange(false);
      join();
    });*/


            // (live??[]).add(liveModel!.data![0]);

          // log('liveModel!.data![i] ${live?[0].likes}');
     });

     /*for(int i=0;i<((liveModel?.data??[]).length);i++) {
       (live??[]).add(liveModel!.data![i]);
       log('live list ${live?[i].title} ${live?[i].image} ${live?[i].comments} ${live?[i].attendance_share} ${live?[i].attendance_view} ${live?[i].description} ${live?[i].filename} ${live?[i].gifts} ${live?[i].join_method} ${live?[i].likes} ${live?[i].link_share}\n');
     }*/


    super.initState();
  }

  // Release the resources when you leave
  @override
  void dispose() async {
 /*   await agoraEngine.leaveChannel();
    agoraEngine.release();*/
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(live == null) {
      return const Center(child: CircularProgressIndicator(),);
    }
    else if((live??[]).isEmpty && live != null) {
      return const Center(child: Text('لا يوجد بث الان',style: TextStyle(color: Colors.white,fontSize: 25),),);
    } else {
      return GridView.builder(
      padding: const EdgeInsets.only(bottom: 10,top: 20.0,right: 20.0),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
      maxCrossAxisExtent: openScreen ? 400 : 200,
      mainAxisExtent: openScreen ? 600 : 300,
      mainAxisSpacing: 20,
      crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
     LiveDataModel liveItem = live![index];
     log('liveItem.image ${liveItem.image}');
    return GridViewItem(
      liveImage:
          liveItem.image,
      profileImage:
          liveItem.creator.profile,
      name: liveItem.title,
      address: liveItem.description??'',
      screenActive: openScreen,
      liveCubit: liveCubit,
      index: index,
      itemTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.transparent,
                    child: Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                          // gradient: LinearGradient(
                          //   colors: [Colors.black, Colors.black45],
                          //   begin: Alignment.topRight,
                          //   end: Alignment.topLeft,
                          //   tileMode: TileMode.clamp,
                          // ),
                        ),
                        child: Scaffold(
                          body: LiveStartScreen( liveModel: liveItem,),
                          backgroundColor: Colors.transparent,
                        )))));
        // liveMainCubit.itemTap();
      },
      // video: _videoPanel,
    );
      },
      itemCount: openScreen ? 1 : (live??[]).length,
    );
    }
  }
}
