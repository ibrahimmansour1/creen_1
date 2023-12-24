import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';


class test extends StatefulWidget {
  test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  String token = '';
  String appId = '';
  String channelName = '';
  int uid = 0;
  int tokenRole = 1;

  // use 1 for Host/Broadcaster, 2 for Subscriber/Audience
  String serverUrl = "";

  // The base URL to your token server, for example "https://agora-token-service-production-92ff.up.railway.app"
  int tokenExpireTime = 45;

  // Expire time in Seconds.
  bool isTokenExpiring = false;

  // Set to true when the token is about to expire
  final channelTextController = TextEditingController(text: '');
  late final RtcEngine engine; // Agora engine instance
  bool isJoined = false;

/*
  // To access the TextField
   Future<void> fetchToken(int uid, String channelName, int tokenRole) async {
     // Prepare the Url
     String url = '$serverUrl/rtc/$channelName/${tokenRole.toString()}/uid/${uid.toString()}?expiry=${tokenExpireTime.toString()}';

     // Send the request
     final response = await http.get(Uri.parse(url));

     if (response.statusCode == 200) {
       // If the server returns an OK response, then parse the JSON.
       Map<String, dynamic> json = jsonDecode(response.body);
       String newToken = json['rtcToken'];
       debugPrint('Token Received: $newToken');
       // Use the token to join a channel or renew an expiring token
       setToken(newToken);
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
      log("Token renewed");
    } else {
      // Join a channel.
      log("Token received, joining a channel...");

      channelName = channelTextController.text;
      if (channelName.isEmpty) {
        log("Enter a channel name");
        return;
      } else {
        log("Fetching a token ...");
      }

      await fetchToken(uid, channelName, tokenRole);

    }
  }
  Future<void> setupVideoSDKEngine() async {
    // retrieve or request camera and microphone permissions
    await [Permission.microphone, Permission.camera].request();

    //create an instance of the Agora engine
    agoraEngine = createAgoraRtcEngine();
    await agoraEngine.initialize(const RtcEngineContext(
        appId: appId
    ));

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
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          log('Token expiring');
          isTokenExpiring = true;
          setState(() {
            // fetch a new token when the current token is about to expire
            fetchToken( uid: uid, channelName: channelName, tokenRole: 2);
          });
        },
      ),
    );

  }
*/
  Future<void> initEngine() async {
    engine = createAgoraRtcEngine();
    await engine.initialize(RtcEngineContext(
      appId: appId,
    ));
    engine.registerEventHandler(RtcEngineEventHandler(
      onError: (ErrorCodeType err, String msg) {
        log('on Error err: $err , ,msg: $msg');
      },
      onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
        log('on connection ${connection.toJson()}');
        isJoined = true;
      },
      onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
        log('User uId : $remoteUid joined');
      },
      onLeaveChannel: (RtcConnection connection, RtcStats stats) {
        log("User left");
        isJoined = false;
      },
      onRtcStats: (RtcConnection connection, RtcStats stats) {
        log('time..... ${stats.duration}');
      },
    ));
    await engine.enableAudio();
    await engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await engine.setAudioProfile(
      profile: AudioProfileType.audioProfileDefault,
      scenario: AudioScenarioType.audioScenarioGameStreaming,
    );
  }

  @override
  void initState() {
    initEngine();
    // Set up an instance of Agora engine
    // setupVideoSDKEngine();
    super.initState();
  }

  @override
  void dispose() async {
    // await agoraEngine.leaveChannel();
    // agoraEngine.release();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextField(
        controller: channelTextController,
        decoration:
            const InputDecoration(hintText: 'Type the channel name here'),
      ),
    );
  }
}
