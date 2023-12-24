
import 'dart:developer';
import 'dart:io';

import 'package:creen/core/themes/enums.dart';
import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/features/live/model/live_model.dart';
import 'package:creen/features/live/repo/followers.dart';
import 'package:creen/features/live/repo/live_create_repo.dart';
import 'package:creen/features/start_live/presentation/widgets/appbar_start_live.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/responsive/sizes.dart';
import '../../../live/presentation/pages/live_start_screen.dart';
import 'follower_page.dart';

class SoundPage extends StatefulWidget {
  const SoundPage({super.key});

  @override
  State<SoundPage> createState() => _SoundPageState();
}

class _SoundPageState extends State<SoundPage> {
  TextEditingController soundTextFieldController = TextEditingController();
  XFile? imageFile;
  bool galleryImage = false;
  List<String>? selectedFollowers = [
     ];
  String? liveImage;
  String joinning = LivePermission.public.name;
  String atendanceWatch = LivePermission.public.name;
  String atendanceShare = LiveType.sound.name;
  String shareLink = LivePermission.public.name;
  String commentsWatch = LivePermission.public.name;
  String giftWatch = LivePermission.public.name;
  TextEditingController channelNameController = TextEditingController();
  TextEditingController channelDescriptionController = TextEditingController();

  GlobalKey<FormState> channelFormKey = GlobalKey<FormState>();
LiveModel? liveModel;
List<Follower> admins = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double iconWidth = size.width*0.55;
    return Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/live_background.jpeg')
              ,fit: BoxFit.cover)
      ),

      child: Scaffold(
        backgroundColor: Colors.transparent,
        // backgroundColor: liveBackground,
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.07),
            child: const AppbarStartLive(
              named: true,
              isVideo:false,
              icon: Icons.mic,
            )),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
/*
                const Row(
                  children: [
                    Text("بث صوت مباشر"),
                    Icon(Icons.mic),
                  ],
                ),
*/
                Form(
                  key: channelFormKey,
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.8,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextFormField(
                      controller: channelNameController,
                      style: const TextStyle(color: Colors.white),

                      validator: (str) {
                        if (str!.isEmpty) return "Field required";
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
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.8,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller: soundTextFieldController,
                    style: const TextStyle(color: Colors.white),

                    decoration: const InputDecoration(
                      hintText: "رابط يوتيوب",
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    MaterialButton(
                      onPressed: () async{
                        admins = await  Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FollowerLive()));
                      },
                      color: Colors.green,
                      child: const Text("المشرفين",style: TextStyle(color: Colors.white),),
                    ),
                    InkWell(
                      onTap: () async {
                        // await openGallery();
                        try {
                          await ImagePicker()
                              .pickImage(source: ImageSource.gallery)
                              .then((value) {
                            imageFile = value;
                          });
                          if (imageFile == null ? true : imageFile!.path.isEmpty) {
                            return;
                          }
                          liveImage = imageFile!.path;
                          galleryImage = true;
                          log("gallery Image  ===> $galleryImage");
                          log("live Image  ===> $liveImage");

                          // print("vertical drag ${det.primaryVelocity}");
                        } catch (e) {
                          log("failed to load image");
                        }
// Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GalleryScreen()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          liveImage == null
                              ? const Icon(
                                  Icons.photo,
                                  size: 30,
                            color: Colors.white,
                                )
                              : Image.file(
                                  File(imageFile!.path),
                                  width: 30,
                                  height: 30,
                                ),
                          const Text(
                            "    صورة الخلفيه",
                            style: TextStyle(fontSize: 22, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
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
                          fontSize: 22,color: Colors.white,
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
                          fontSize: 22,color: Colors.white,
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
                          fontSize: 22,color: Colors.white,
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
                          fontSize: 22,color: Colors.white,
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
                          fontSize: 22,color: Colors.white,
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
                  onTap: () async {

                    if(channelFormKey.currentState!.validate()) {
                      log('soundTextFieldController.text ${soundTextFieldController.text}');
String? url = soundTextFieldController.text;
String liveProfile = liveImage ??
      "https://www.cdc.gov/diabetes/images/research/reaching-treatment-goals.jpg?_=66821";
String channelName = channelNameController.text;
                      soundTextFieldController.clear();
                      channelNameController.clear();

                      LiveCreateRepo.createLive(
                        title: channelName,
                        join_method: joinning,
                        attendance_view: atendanceWatch,
                        attendance_share: atendanceShare,
                        link_share: shareLink,
                        comments: commentsWatch,
                        gifts: giftWatch,
                        type: LiveType.audio.name,
                        description: channelDescriptionController.text,
                        image: imageFile == null ?null:await MultipartFile.fromFile(File(imageFile!.path).path),
                        live_id: null,
                        live_link: null,
                        youtube_link: url,
                      ).then((value){
                        // log('Live data ${value != null?value!.data![0].id:null}');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LiveStartScreen(
                                  liveCreator: true,
                                  gallery: galleryImage,
                                 liveModel: value!.data![0],
                                )));

                      });
                    }
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
                Center(child: Image.asset('assets/images/mic.png',width: iconWidth,height: iconWidth,)),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
