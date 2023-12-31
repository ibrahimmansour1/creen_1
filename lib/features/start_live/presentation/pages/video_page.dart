import 'dart:async';
import 'dart:developer';

import 'package:creen/core/themes/enums.dart';
import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/features/live/presentation/pages/live_start_screen.dart';
import 'package:creen/features/live/repo/followers.dart';
import 'package:creen/features/live/repo/live_checktitle_repo.dart';
import 'package:creen/features/live/repo/live_create_repo.dart';
import 'package:creen/features/start_live/presentation/pages/follower_page.dart';
import 'package:creen/features/start_live/presentation/widgets/appbar_start_live.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/responsive/sizes.dart';

// import 'package:flutter_zoom_sdk/zoom_options.dart';
// import 'package:flutter_zoom_sdk/zoom_view.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  List<String>? selectedFollowers = [];

  String joinning = LivePermission.public.name;
  String atendanceWatch = LivePermission.public.name;
  String atendanceShare = LiveType.sound.name;
  String shareLink = LivePermission.public.name;
  String commentsWatch = LivePermission.public.name;
  String giftWatch = LivePermission.public.name;
  late Timer timer;
bool checkTitle = false;
  TextEditingController channelNameController = TextEditingController();
  TextEditingController channelDescriptionController = TextEditingController();

  GlobalKey<FormState> channelFormKey = GlobalKey<FormState>();
  List<Follower> admins = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('(selectedFollowers ?? []).length ${(selectedFollowers ?? []).length}');
    Size size = MediaQuery.sizeOf(context);
    double iconWidth = size.width*0.70;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(image: AssetImage('assets/images/live_background.jpeg'),fit: BoxFit.cover),

      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // backgroundColor: liveBackground,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.07),
            child: const AppbarStartLive(
              named: true,
              icon: Icons.play_arrow_outlined,
            )),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              textDirection: TextDirection.rtl,
              mainAxisSize: MainAxisSize.max,
              children: [
                Form(
                  key: channelFormKey,
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: channelNameController,
                      style: const TextStyle(color: Colors.white),
                      onChanged: (title){
                        LiveCheckTitleRepo.checkTitle(liveTitle: title).then((value){
log('title is $value');
setState(() {
  checkTitle = value!;
});
log('checkTitle $checkTitle');
if(channelFormKey.currentState!.validate()){

}
                        });

                      },
                      onEditingComplete: (){
                        if(channelFormKey.currentState!.validate()){

                        }
                      },
                      onFieldSubmitted: (st){
                        if(channelFormKey.currentState!.validate()){

                        }
                      },
                      onTapOutside: (pointer){
                        if(channelFormKey.currentState!.validate()){

                        }
                      },
                      validator: (str) {
                        if (str!.isEmpty) {
                          return "Field required";
                        }
                        else if(checkTitle){
                          return "This title is used before";
                        }
                        return null;
                      },
                      decoration:  InputDecoration(
                        hintText: "العنوان",
                        hintStyle: const TextStyle(color: Colors.white),
                        border: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                        ),
                        disabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.amber.shade100)
                        ),
                        errorStyle: TextStyle(color: Colors.amber.shade100)
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: channelDescriptionController,
                    style: const TextStyle(color: Colors.white),

                    decoration: const InputDecoration(
                      hintText: "الوصف",
                        hintStyle: TextStyle(color: Colors.white),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white)
                      ),


                    ),
                  ),
                ),
                MaterialButton(
                  onPressed: () async{
                    admins = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const FollowerLive()));
                    log('admins list length ${admins.length}');
                  },
                  color: Colors.green,
                  child: const Text("المشرفين",style: TextStyle(color: Colors.white),),
                ),
                if((selectedFollowers ?? []).isNotEmpty)
                SizedBox(
                  height: 50,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            backgroundImage:
                                NetworkImage(selectedFollowers![index]),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                selectedFollowers!.removeAt(index);
                              });
                            },
                            radius: 15,
                            child: const CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.transparent,
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 15,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return const SizedBox(
                        width: 5,
                      );
                    },
                    itemCount: (selectedFollowers ?? []).length,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                PopupMenuButton(
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value:LivePermission.public.name,
                      child: const Text("عام"),
                    ),
                    PopupMenuItem(
                      value: LivePermission.followers.name,
                      child: const Text("المتابعين"),
                    ),
                    PopupMenuItem(
                      value: LivePermission.subscripers.name,
                      child: const Text("المشتركين"),
                    ),
                  ],
                  initialValue: joinning.translate,
                  offset: const Offset(-1, 0),
                  onSelected: (value) {
                    setState(() {
                      joinning = value;
                    });
                    log(value);
                    log(joinning);
                  },
                  child: Row(
                    children: [
                      const Text(
                        "طريقه الانضمام :    ",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(joinning.translate,style: const TextStyle(color: Colors.white),),
                            const Icon(Icons.arrow_drop_down,color: Colors.white,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                PopupMenuButton(
                  offset: const Offset(-1, 0),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: LivePermission.public.name,
                      child: const Text("الجميع"),
                    ),
                    PopupMenuItem(
                      value: LivePermission.admins.name,
                      child: const Text("المشرفين"),
                    ),
                    PopupMenuItem(
                      value: LivePermission.no_one.name,
                      child: const Text("لا أحد"),
                    ),
                  ],
                  onSelected: (value) {
                    setState(() {
                      atendanceWatch = value;
                    });
                    log(value);
                    log(atendanceWatch);
                  },
                  initialValue: atendanceWatch.translate,
                  child: Row(
                    children: [
                      const Text(
                        "مشاهده الحضور :   ",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,

                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(atendanceWatch.translate,style: const TextStyle(color: Colors.white),),
                            const Icon(Icons.arrow_drop_down,color: Colors.white,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                PopupMenuButton(
                  offset: const Offset(-1, 0),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: LiveType.sound.name,
                      child: const Text("صوت"),
                    ),
                    PopupMenuItem(
                      value: LiveType.video.name,
                      child: const Text("فيديو"),
                    ),
                    PopupMenuItem(
                      value: LiveType.writing.name,
                      child: const Text("كتابه"),
                    ),
                  ],
                  initialValue: atendanceShare.translate,
                  onSelected: (value) {
                    setState(() {
                      atendanceShare = value;
                    });
                    log(value);
                    log(atendanceShare);
                  },
                  child: Row(
                    children: [
                      const Text(
                        "مشاركه الحضور :    ",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,

                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(atendanceShare.translate,style: const TextStyle(color: Colors.white),),
                            const Icon(Icons.arrow_drop_down,color: Colors.white,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                PopupMenuButton(
                  offset: const Offset(-1, 0),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: LivePermission.public.name,
                      child: const Text("الجميع"),
                    ),
                    PopupMenuItem(
                      value: LivePermission.admins.name,
                      child: const Text("المشرفين"),
                    ),
                    PopupMenuItem(
                      value: LivePermission.no_one.name,
                      child: const Text("لا أحد"),
                    ),
                  ],
                  initialValue: shareLink.translate,
                  onSelected: (value) {
                    setState(() {
                      shareLink = value;
                    });
                    log(value);
                    log(shareLink);
                  },
                  child: Row(
                    children: [
                      const Text(
                        "نشر رابط البث :      ",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,

                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(shareLink.translate,style: const TextStyle(color: Colors.white),),
                            const Icon(Icons.arrow_drop_down,color: Colors.white,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                PopupMenuButton(
                  offset: const Offset(-1, 0),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: LivePermission.public.name,
                      child: const Text("الجميع"),
                    ),
                    PopupMenuItem(
                      value: LivePermission.admins.name,
                      child: const Text("المشرفين"),
                    ),
                    PopupMenuItem(
                      value: LivePermission.no_one.name,
                      child: const Text("لا أحد"),
                    ),
                  ],
                  initialValue: commentsWatch.translate,
                  onSelected: (value) {
                    setState(() {
                      commentsWatch = value;
                    });
                    log(value);
                    log(commentsWatch);
                  },
                  child: Row(
                    children: [
                      const Text(
                        "مشاهده التعليقات : ",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,

                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(commentsWatch.translate,style: const TextStyle(color: Colors.white),),
                            const Icon(Icons.arrow_drop_down,color: Colors.white,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                PopupMenuButton(
                  offset: const Offset(-1, 0),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: LivePermission.public.name,
                      child: const Text("الجميع"),
                    ),
                    PopupMenuItem(
                      value: LivePermission.admins.name,
                      child: const Text("المشرفين"),
                    ),
                    PopupMenuItem(
                      value: LivePermission.no_one.name,
                      child: const Text("لا أحد"),
                    ),
                  ],
                  initialValue: giftWatch.translate,
                  onSelected: (value) {
                    setState(() {
                      giftWatch = value;
                    });
                    log(value);
                    log(giftWatch);
                  },
                  child: Row(
                    children: [
                      const Text(
                        "مشاهده الهدايا :     ",
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,

                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(giftWatch.translate,style: const TextStyle(color: Colors.white),),
                            const Icon(Icons.arrow_drop_down,color: Colors.white,)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    // startMeeting(context);
                    if (channelFormKey.currentState!.validate()) {
                      LiveCreateRepo.createLive(
                        title: channelNameController.text,
                        join_method: joinning,
                        attendance_view: atendanceWatch,
                        attendance_share: atendanceShare,
                        link_share: shareLink,
                        comments: commentsWatch,
                        gifts: giftWatch,
                        type: LiveType.video.name,
                        description: channelDescriptionController.text,
                        image: null,
                        live_id: null,
                        live_link: null,
                        youtube_link: null,
                      ).then((value){
                        log('Live data ${value != null?value!.data![0].title:null}');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LiveStartScreen(liveCreator: true,
                                  liveModel: value!.data![0],
                                )));
                      });
                    }
// Navigator.push(context, MaterialPageRoute(builder: (context)=>test()));
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    alignment: Alignment.center,
                    color: Colors.green,
                    child: const Text(
                      "ابدأ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                ),
                Center(child: Image.asset('assets/images/live_stream.png',width: iconWidth,height: iconWidth,)),
              ],
            ),
          ),
        ),
      ),
    );
  }
/* startMeeting(BuildContext context) {
    bool _isMeetingEnded(String status) {
      var result = false;

      if (Platform.isAndroid) {
        result = status == "MEETING_STATUS_DISCONNECTING" ||
            status == "MEETING_STATUS_FAILED";
      } else {
        result = status == "MEETING_STATUS_IDLE";
      }

      return result;
    }

    ZoomOptions zoomOptions = ZoomOptions(
      domain: "zoom.us",
      appKey:
      "XKE4uWfeLwWEmh78YMbC6mqKcF8oM4YHTr9I", //API KEY FROM ZOOM -- SDK KEY
      appSecret:
      "bT7N61pQzaLXU6VLj9TVl7eYuLbqAiB0KAdb", //API SECRET FROM ZOOM -- SDK SECRET
    );
    var meetingOptions = ZoomMeetingOptions(
        userId: 'evilrattdeveloper@gmail.com', //pass host email for zoom
        userPassword: 'Dlinkmoderm0641', //pass host password for zoom
        disableDialIn: "false",
        disableDrive: "false",
        disableInvite: "false",
        disableShare: "false",
        disableTitlebar: "false",
        viewOptions: "true",
        noAudio: "false",
        noDisconnectAudio: "false");

    var zoom = ZoomView();
    zoom.initZoom(zoomOptions).then((results) {
      if (results[0] == 0) {
        zoom.onMeetingStatus().listen((status) {
          if (kDebugMode) {
            print("[Meeting Status Stream] : " + status[0] + " - " + status[1]);
          }
          if (_isMeetingEnded(status[0])) {
            if (kDebugMode) {
              print("[Meeting Status] :- Ended");
            }
            timer.cancel();
          }
          if (status[0] == "MEETING_STATUS_INMEETING") {
            zoom.meetinDetails().then((meetingDetailsResult) {
              if (kDebugMode) {
                print("[MeetingDetailsResult] :- " +
                    meetingDetailsResult.toString());
              }
            });
          }
        });
        zoom.startMeeting(meetingOptions).then((loginResult) {
          if (kDebugMode) {
            print(
                "[LoginResult] :- " + loginResult[0] + " - " + loginResult[1]);
          }
          if (loginResult[0] == "SDK ERROR") {
            //SDK INIT FAILED
            if (kDebugMode) {
              print((loginResult[1]).toString());
            }
            return;
          } else if (loginResult[0] == "LOGIN ERROR") {
            //LOGIN FAILED - WITH ERROR CODES
            if (kDebugMode) {
              if (loginResult[1] ==
                  ZoomError.ZOOM_AUTH_ERROR_WRONG_ACCOUNTLOCKED) {
                print("Multiple Failed Login Attempts");
              }
              print((loginResult[1]).toString());
            }
            return;
          } else {
            //LOGIN SUCCESS & MEETING STARTED - WITH SUCCESS CODE 200
            if (kDebugMode) {
              print((loginResult[0]).toString());
            }
          }
        }).catchError((error) {
          if (kDebugMode) {
            print("[Error Generated] : " + error);
          }
        });
      }
    }).catchError((error) {
      if (kDebugMode) {
        print("[Error Generated] : " + error);
      }
    });
  }*/
}
