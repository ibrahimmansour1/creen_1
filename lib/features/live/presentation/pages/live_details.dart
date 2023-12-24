import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:creen/core/utils/network_utils.dart';
import 'package:creen/core/utils/widgets/custom_awesome_dialog.dart';
import 'package:creen/features/live/model/live_model.dart';
import 'package:creen/features/live/presentation/models/live_details_model.dart';
import 'package:creen/features/live/presentation/widgets/live_details_grid_view.dart';
import 'package:creen/features/live/presentation/widgets/tab_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../../core/utils/constants.dart';

class LiveDetails extends StatefulWidget {
  const LiveDetails({super.key, required this.liveItem});
final LiveDataModel liveItem;
  @override
  State<LiveDetails> createState() => _LiveDetailsState();
}

class _LiveDetailsState extends State<LiveDetails> {
  List<LiveDetailsModel> liveDetailslist = [
    LiveDetailsModel(
      name: "الاسم",
      profile:
          "https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&quality=85&auto=format&fit=max&s=a52bbe202f57ac0f5ff7f47166906403",
      cover:
          "https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&quality=85&auto=format&fit=max&s=a52bbe202f57ac0f5ff7f47166906403",
    ),
/*    LiveDetailsModel(
      name: "الاسم",
      profile:
          "https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&quality=85&auto=format&fit=max&s=a52bbe202f57ac0f5ff7f47166906403",
      cover:
          "https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&quality=85&auto=format&fit=max&s=a52bbe202f57ac0f5ff7f47166906403",
    ),
    LiveDetailsModel(
      name: "الاسم",
      profile:
          "https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&quality=85&auto=format&fit=max&s=a52bbe202f57ac0f5ff7f47166906403",
      cover:
          "https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&quality=85&auto=format&fit=max&s=a52bbe202f57ac0f5ff7f47166906403",
    ),
    LiveDetailsModel(
      name: "الاسم",
      profile:
          "https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&quality=85&auto=format&fit=max&s=a52bbe202f57ac0f5ff7f47166906403",
      cover:
          "https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&quality=85&auto=format&fit=max&s=a52bbe202f57ac0f5ff7f47166906403",
    ),*/
  ];
  List<LiveComments> liveComments = [
    LiveComments(
        name: "الاسم بالكامل",
        profile:
            "https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&quality=85&auto=format&fit=max&s=a52bbe202f57ac0f5ff7f47166906403",
        comment: "التعليق التعليق التعليق التعليق التعليق التعليق "),
    LiveComments(
        name: "الاسم بالكامل",
        profile:
            "https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&quality=85&auto=format&fit=max&s=a52bbe202f57ac0f5ff7f47166906403",
        comment: "التعليق التعليق التعليق التعليق التعليق التعليق "),
    LiveComments(
        name: "الاسم بالكامل",
        profile:
            "https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&quality=85&auto=format&fit=max&s=a52bbe202f57ac0f5ff7f47166906403",
        comment: "التعليق التعليق التعليق التعليق التعليق التعليق "),
  ];
  List<Widget> tabWidgets = [];
  int tabIndex = 0;
  bool shown = false;
  List<Widget> conversationItemWidgets = [];

  String channelName = "test";
  String token =
      "007eJxTYPgamcTZER+7d7bV5V0v70j27T80vXXL8w97Q5etlFGe3NSuwGCRbGRoaWSelGhhnmxiYGKeaG5hYmRhaG5hZGGcamxi+lFLIbUhkJHhVNEeZkYGCATxWRhKUotLGBgA21Ig5A==";
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int uid = 0; // uid of the local user

  int? _remoteUid; // uid of the remote user
  bool _isJoined = false; // Indicates if the local user has joined the channel
  bool _isHost =
      false; // Indicates whether the user has joined as a host or audience
  late RtcEngine agoraEngine;// Agora engine instance

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>(); // Global key to access the scaffold
  YoutubePlayerController? youtubeController;

  Future<void> fetchToken(
      int uid,
      String channelName,
      int tokenRole,
      ) async {
    final util = NetworkUtil();
    int tokenExpireTime = 7400; // Expire time in Seconds.
    // channelName = 'test';
    // Prepare the Url
    String url =
        '$serverUrl/rtc/$channelName/${tokenRole.toString()}/uid/${uid.toString()}?expiry=${tokenExpireTime.toString()}';

    // Send the request
    Response? response ;
    await util.get(
      url,
    ).then((value){
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
            .catchError((error) => log('startPreview Error ${error.toString()}'));
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

      await fetchToken(uid, channelName, _isHost?1:2);
    }
  }
  Widget _videoPanel() {
    if (!_isJoined) {
      return const CircularProgressIndicator();
    } else if (_isHost) {
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
        return const Text(
          'Waiting for a host to join',
          textAlign: TextAlign.center,
        );
      }
    }
  }

  Future<void> setupVideoSDKEngine() async {
    log('setupVideoSDKEngine');
    // retrieve or request camera and microphone permissions
    await [Permission.microphone, Permission.camera].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine
        .initialize(const RtcEngineContext(appId: appId))
        .then((value) => log('agoraEngine'))
        .catchError((error) => log('agoraEngine Error  ${error.toString()}'));

    await agoraEngine
        .enableVideo()
        .then((value) => log('enableVideo'))
        .catchError((error) => log('enableVideo Error ${error.toString()}'));

    // Register the event handler
    agoraEngine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          showMessage(
              "Local user uid:${connection.localUid} joined the channel");
          setState(() {
            _isJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          showMessage("Remote user uid:$remoteUid joined the channel");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
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
            fetchToken(uid, channelName, _isHost?1:2);
          });
        },
      ),
    );
    await fetchToken(uid, channelName,_isHost?1:2 );
    await join();
  }

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
        .then((value) => log('joinChannel'))
        .catchError((error) => log('joinChannel Error ${error.toString()}'));
  }

  void leave() {
    setState(() {
      _isJoined = false;
      _remoteUid = null;
    });
    agoraEngine.leaveChannel();
  }

  showMessage(String message) {
    log("message show $message");
    scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  void initState() {
    channelName = widget.liveItem.title;
    tabWidgets = [
      if(widget.liveItem.privelegeComments == 'public')
        tabCommentWidget(liveComments: liveComments),
      if(widget.liveItem.attendance_view == 'public')
        tabPublicWidget(tabPublicEnable: false),
      if(widget.liveItem.gifts == 'public')
        tabPublicWidget(),
    ];
    if(widget.liveItem.youtube_link != null) {
      youtubeController =
          YoutubePlayerController(initialVideoId: widget.liveItem.youtube_link!.split('/').last);
    }

    // Set up an instance of Agora engine
    setupVideoSDKEngine();

    super.initState();
  }
@override
  void deactivate() {
    if(widget.liveItem.youtube_link != null) {
      youtubeController!.pause();
    }

    super.deactivate();
  }
  // Release the resources when you leave
  @override
  void dispose() async {
    await agoraEngine.leaveChannel();
    agoraEngine.release();
    if(widget.liveItem.youtube_link != null) {
      youtubeController!.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      conversationItemWidgets = [
        Container(
          width: double.infinity,
          alignment: const Alignment(0, 0.8),
/*
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(liveDetailslist[0].cover),
            fit: BoxFit.cover),
      ),
*/
          child: Stack(
            alignment: Alignment.topLeft,
            children: [
              Stack(
                alignment: Alignment(0, 0.8),
                children: [

                  _videoPanel(),
                  if(widget.liveItem.youtube_link != null)
                  YoutubePlayerBuilder(
                      player: YoutubePlayer(
                        controller: youtubeController!,
                      ),
                      builder: (ctx, player) {
                        return Scaffold(
                          key: scaffoldKey,
                          extendBodyBehindAppBar: true,
                          appBar: AppBar(
                            backgroundColor: Colors.transparent,
                            elevation: 0.0,
                            leadingWidth: /*widget.liveCreator ? 130 :*/ 145,
                            toolbarHeight: 86,
                            automaticallyImplyLeading: false,
                            centerTitle: true,
                            actions: [
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

                                        Navigator.pop(context);
                                      },
                                      type: DialogType.warning,
                                    );
                                  },
                                  child: Icon(
                                    Icons.close,
                                    color: widget.liveItem.type == 'audio'  ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          body: Stack(
                            alignment: Alignment.center,
                            children: [
                              if (!(widget.liveItem.type == 'audio')  && true/*camera on*/)
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: Center(child: _videoPanel()),
                                ),
                              Container(
                                width: MediaQuery.of(context).size.width,
/*
                decoration: BoxDecoration(
                  // color: Colors.white,
                    image: widget.soundLive
                        ? (widget.liveProfile == null
                        ? null
                        : DecorationImage(
                        image: widget.gallery
                            ? FileImage(File(widget.liveProfile!))
                            : NetworkImage(widget.liveProfile!)
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
                                      if (widget.liveItem.type == 'audio' )
                                        Align(
                                          alignment: const Alignment(0, -1.0),
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: MediaQuery.of(context).size.width,
                                            height:
                                            MediaQuery.of(context).size.height * 0.5,
                                            child:                                                   player,

                                          ),
                                        ),
                                      Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width:
                                            MediaQuery.of(context).size.width * 0.22,
                                            height:
                                            MediaQuery.of(context).size.height * 0.4,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [

                                                InkWell(
                                                  onTap: () {},
                                                  child: Container(
                                                    padding: const EdgeInsets.symmetric(
                                                        horizontal: 10, vertical: 5),
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: Colors.white),
                                                        color:
                                                        Colors.black.withOpacity(0.1),
                                                        borderRadius:
                                                        const BorderRadius.horizontal(
                                                            right:
                                                            Radius.circular(30))),
                                                    child: const Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                      children: [
                                                        Text(
                                                          "5k",
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontSize: 25),
                                                        ),
                                                        Icon(
                                                          CupertinoIcons.heart,
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
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                  if(widget.liveItem.image != null && widget.liveItem.type == 'audio')
                    Image.network(widget.liveItem.image!,width: MediaQuery.sizeOf(context).width,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        color: Colors.grey.shade500.withOpacity(0.4),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          textDirection: TextDirection.ltr,
                          children: [
                            SizedBox(
                              width: 112.4,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(widget.liveItem.creator.name!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            CircleAvatar(
                              backgroundImage:widget.liveItem.creator.profile != null?
                                  NetworkImage(widget.liveItem.creator.profile!):AssetImage('assets/images/profile.png')as ImageProvider<Object>,
                              radius: 30,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),


                ],
              ),

             /* SafeArea(
                child: Container(
                  width: 50,
                  height: 50,
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


                        },
                        type: DialogType.warning,
                      );
                    },
                    child: Icon(
                      Icons.close,
                      color:  Colors.white,
                    ),
                  ),
                ),
              ),
*/
            ],
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                alignment: const Alignment(0, 0.8),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(liveDetailslist[0].cover),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      color: Colors.grey.shade500.withOpacity(0.4),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        textDirection: TextDirection.ltr,
                        children: [
                          SizedBox(
                            width: 112.4,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(liveDetailslist[0].name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(liveDetailslist[0].profile),
                            radius: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                alignment: const Alignment(0, 0.8),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(liveDetailslist[0].cover),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      color: Colors.grey.shade500.withOpacity(0.4),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        textDirection: TextDirection.ltr,
                        children: [
                          SizedBox(
                            width: 112.4,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(liveDetailslist[0].name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(liveDetailslist[0].profile),
                            radius: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                alignment: const Alignment(0, 0.8),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(liveDetailslist[0].cover),
                      fit: BoxFit.cover),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      color: Colors.grey.shade500.withOpacity(0.4),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        textDirection: TextDirection.ltr,
                        children: [
                          SizedBox(
                            width: 112.4,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(liveDetailslist[0].name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                          CircleAvatar(
                            backgroundImage:
                                NetworkImage(liveDetailslist[0].profile),
                            radius: 30,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      alignment: const Alignment(0, 0.8),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(liveDetailslist[0].cover),
                            fit: BoxFit.cover),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            color: Colors.grey.shade500.withOpacity(0.4),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              textDirection: TextDirection.ltr,
                              children: [
                                SizedBox(
                                  width: 112.4,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(liveDetailslist[0].name,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(liveDetailslist[0].profile),
                                  radius: 30,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: const Alignment(0, 0.8),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(liveDetailslist[0].cover),
                            fit: BoxFit.cover),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            color: Colors.grey.shade500.withOpacity(0.4),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.end,
                              textDirection: TextDirection.ltr,
                              children: [
                                SizedBox(
                                  width: 112.4,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(liveDetailslist[0].name,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: const TextStyle(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(liveDetailslist[0].profile),
                                  radius: 30,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ];
    });
    if (liveDetailslist.isEmpty) {
      return const CircularProgressIndicator();
    } else {
      return Stack(
alignment: Alignment(0,1),
        children: [


          Expanded(
            child: conversationItemWidgets.length >= liveDetailslist.length
                ? conversationItemWidgets[liveDetailslist.length - 1]
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                    itemBuilder: (context, index) => LiveDetailsGridViewItem(
                      liveImage: liveDetailslist[index].cover,
                      profileImage: liveDetailslist[index].profile,
                      name: liveDetailslist[index].name,
                      // address: "عنوان",
                      once: liveDetailslist.length == 1,
                      video: _videoPanel,
                    ),
                    itemCount: liveDetailslist.length,
                  ),
          ),
          if (shown) Expanded(
            child: GestureDetector(
              onVerticalDragEnd: (dragUpdateDetails) {
                setState(() {
                  shown = false;
                });
              },
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.16,
                width: MediaQuery.sizeOf(context).width,
                color: Colors.transparent,
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if(widget.liveItem.privelegeComments == 'public')
                          TabWidget(
                            title: "التعليقات",
                            tabTap: () {
                              setState(() {
                                tabIndex = 0;
                              });
                            },
                            active: tabIndex == 0,
                          ),
                        if(widget.liveItem.attendance_view == 'public')
                          TabWidget(
                            title: "الجمهور",
                            tabTap: () {
                              setState(() {
                                tabIndex = 1;
                              });
                            },
                            active: tabIndex == 1,
                          ),
                        if(widget.liveItem.gifts == 'public')
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
          ) else Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(widget.liveItem.privelegeComments == 'public')
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
              if(widget.liveItem.attendance_view == 'public')
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
              if(widget.liveItem.gifts == 'public')

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
          ),if (shown) Expanded(
            child: GestureDetector(
              onVerticalDragEnd: (dragUpdateDetails) {
                setState(() {
                  shown = false;
                });
              },
              child: Container(
                height: MediaQuery.sizeOf(context).height * 0.16,
                width: MediaQuery.sizeOf(context).width,
                color: Colors.transparent,
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        if(widget.liveItem.privelegeComments == 'public')
                          TabWidget(
                            title: "التعليقات",
                            tabTap: () {
                              setState(() {
                                tabIndex = 0;
                              });
                            },
                            active: tabIndex == 0,
                          ),
                        if(widget.liveItem.attendance_view == 'public')
                          TabWidget(
                            title: "الجمهور",
                            tabTap: () {
                              setState(() {
                                tabIndex = 1;
                              });
                            },
                            active: tabIndex == 1,
                          ),
                        if(widget.liveItem.gifts == 'public')
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
          ) else Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(widget.liveItem.privelegeComments == 'public')
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
              if(widget.liveItem.attendance_view == 'public')
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
              if(widget.liveItem.gifts == 'public')

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
          ),

        ],
      );
    }
  }
}

Widget tabCommentWidget({
  required List<LiveComments> liveComments,
}) {
  return ListView.separated(
    padding: const EdgeInsets.only(bottom: 10),
    itemBuilder: (context, index) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(liveComments[index].profile??personProfile),
          radius: 25,
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width * 0.9 * 0.68,
          child: Text(
            "${liveComments[index].name}\n\t${liveComments[index].comment}",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12,color: Colors.white),
          ),
        ),
        InkWell(
          onTap: () {},
          child: const Icon(
            Icons.info_outline,
            color: Colors.grey,
          ),
        ),
        InkWell(
          onTap: () {},
          child: const Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ],
    ),
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
