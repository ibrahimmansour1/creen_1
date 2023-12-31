import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LiveChat extends StatefulWidget {
  const LiveChat({super.key,required this.liveProfile, required this.liveUser});
  final String? liveProfile;
  final String liveUser;

  @override
  State<LiveChat> createState() => _LiveChatState();
}

class _LiveChatState extends State<LiveChat> {
List<bool> transmitter = [];

  TextEditingController messageController = TextEditingController();
@override
  void initState() {

    transmitter = List<bool>.generate(50, (index) {

      return index%2==0;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(20);

    return  Scaffold(
extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leadingWidth: MediaQuery.of(context).size.width*0.5,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(widget.liveProfile!),
                  fit: BoxFit.cover
                )
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadiusDirectional.horizontal(start: Radius.circular(20),end: Radius.circular(20))
              ),
              child: Text("متابعه",style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),),
            )
          ],
        ),
        actions:[
          InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(

              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black.withOpacity(0.1),

              ),
              child: const Icon(Icons.close,color: Colors.white,),
            ),
          )
        ] ,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                widget.liveProfile!,
              ),
              fit: BoxFit.cover,
              opacity: 0.2,
              colorFilter: const ColorFilter.mode(
                  Colors.black87, BlendMode.lighten)),

        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(itemBuilder: (context,index){
                var crossAxisAlignment =
                transmitter[index] ? CrossAxisAlignment.end : CrossAxisAlignment.start;

                return Container(
                  width: MediaQuery.sizeOf(context).width,
                  // color: widget.selected?Colors.blue.shade50:null,
                  child: InkWell(
                    onTap: ()async{
                      print("show\n\n\n\n\n");
                    /*  setState(() {
                        widget.selected =true;
                      });*/

/*
           await Future.delayed(const Duration(seconds: 2), () {

// Here you can write your code





            });
*/


                    },
                    child: PopupMenuButton(
                      child:  Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment:
                          !transmitter[index] ? MainAxisAlignment.start : MainAxisAlignment.end,
                          // textDirection:  HelperFunctions.currentLanguage == "ar"?TextDirection.rtl:TextDirection.ltr,
                          // textDirection:  HelperFunctions.currentLanguage == "ar"?TextDirection.rtl:TextDirection.ltr,
                          children: <Widget>[
                            /*if(!transmitter[index] && widget.selected )
                  PopupMenuButton(
                    icon: Icon(
                      Icons.more_horiz,

                    ),

                    onSelected: (value) {
                      print("beeeeeeeeeeeeeeeeeeeeeeeeeeee");
                      if (!HelperFunctions.validateLogin()) {
                        return;
                      }
                      print("beeeeeeeeeeeeeeeeeeeeeeeeeeee");

                      print("value ===> ${value}");
                      if (value == 'report') {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              BlocProvider(
                                create: (context) => CreateReportCubit(),
                                child: ReportDialog(
                                  reportType: ReportType.chatMessage,
                                  reportTypeId: widget.messageElement.id,
                                ),
                              ),
                        );
                      } else if (value == "delete") {
                        showDialog(
                          context: context,
                          builder: (_) =>
                              AlertDialog(
                                content: Text(
                                  'do_you_want_to_scan'.translate,
                                  style: const TextStyle(fontSize: 24),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      widget.chatCubit.deleteMessage(id: widget.messageElement.id!);                     // var videoData =
                                      *//*await RemoveVideoRepo.removeVideo(
                                    context, body: {"video_id":"$reportTypeId"});*//*
                                      NavigationService.goBack();

                                      // print("ggggggggggggg ${reportTypeId}");
                                      *//*NavigationService.goBack();
                    storiesCubit.deleteStoryByIndex(
                        storyIndex: storyIndex,
                        pageIndex: pageIndex,
                        userId: storiesCubit
                            .stories[pageIndex].id ??
                            0,
                        context: context);*//*
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
                      }
                      else if(value == "edit"){
                        print("edit message ${widget.message != null}");
                        if(widget.message != null) {
                          print("widget.message ===> ${widget.message}");
                          widget.chatCubit.sendMessageController.text =  widget.message!;
                          widget.chatCubit.edited = true;
                          widget.chatCubit.messageID = widget.messageElement.id;
                          print("widget.chatCubit.messageID ===> ${widget.chatCubit.messageID}");
                          widget.chatCubit.emit(ChatMessageEdit());
                        }
                      }
                      else if(value == "block"){

                      }

                      setState(() {
                        widget.selected =false;
                      });
                      print("hide\n\n\n\n\n");
                    },
                    position: PopupMenuPosition.under,
                    itemBuilder: (_) =>
                    [
                      if (transmitter[index]) ...[
                        HelperFunctions.buildPopupMenu(
                            icons: Icons.edit, title: 'edit', value: 'edit'),
                        HelperFunctions.buildPopupMenu(
                            icons: Icons.delete, title: 'delete', value: 'delete'),
                      ] else
                        ...[
                          HelperFunctions.buildPopupMenu(
                              icons: Icons.report, title: 'report', value: 'report'),
                          HelperFunctions.buildPopupMenu(
                              icons: Icons.block, title: 'block', value: 'block'),
                        ]
                    ],
                  ),
*/
                            // moreChoices(context, id: widget.messageElement.id, mee: transmitter[index]),
                            Flexible(
                              child: Container(
                                width:  260.r,
                                margin: EdgeInsets.symmetric(horizontal: 10),

                                decoration: BoxDecoration(
                                  color: !transmitter[index]
                                      ? Colors.white
                                      : MainStyle.primaryColor.withOpacity(0.6),
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: radius,
                                    bottomRight: radius,
                                    topLeft: ((transmitter[index] && HelperFunctions.currentLanguage == "en")|| (!transmitter[index] && HelperFunctions.currentLanguage == "ar"))  ? radius : Radius.zero,
                                    topRight: ((transmitter[index] && HelperFunctions.currentLanguage == "ar")|| (!transmitter[index] && HelperFunctions.currentLanguage == "en")) ? radius : Radius.zero,
                                    // topRight:  Radius.circular(20),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: crossAxisAlignment,
                                  children: [
                                    Visibility(
                                      visible: widget.liveUser != null,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                          left: 10.r,
                                          right: 10.r,
                                          top: 10.r,
                                        ),
                                        child: Text(
                                          "رساله1رساله1رساله1رساله1رساله1رساله1رساله1رساله1رساله1رساله1رساله1رساله1رساله1رساله1رساله1رساله1رساله1رساله1",
                                          style: TextStyle(
                                              fontSize: 15.r, color: !transmitter[index]
                                              ? Colors.black:Colors.lightBlue
                                              ),
                                        ),
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                            ),
                            /*   if(transmitter[index] && widget.selected )
                  PopupMenuButton(
                    icon: Icon(
                      Icons.more_horiz,

                    ),
                    onSelected: (value) {
                      print("beeeeeeeeeeeeeeeeeeeeeeeeeeee");
                      if (!HelperFunctions.validateLogin()) {
                        return;
                      }
                      print("beeeeeeeeeeeeeeeeeeeeeeeeeeee");

                      print("value ===> ${value}");
                      if (value == 'report') {
                        showDialog(
                          context: context,
                          builder: (context) =>
                              BlocProvider(
                                create: (context) => CreateReportCubit(),
                                child: ReportDialog(
                                  reportType: ReportType.chatMessage,
                                  reportTypeId: widget.messageElement.id,
                                ),
                              ),
                        );
                      } else if (value == "delete") {
                        showDialog(
                          context: context,
                          builder: (_) =>
                              AlertDialog(
                                content: Text(
                                  'do_you_want_to_scan'.translate,
                                  style: const TextStyle(fontSize: 24),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      widget.chatCubit.deleteMessage(id: widget.messageElement.id!);                     // var videoData =
                                      *//*await RemoveVideoRepo.removeVideo(
                                    context, body: {"video_id":"$reportTypeId"});*//*
                                      NavigationService.goBack();

                                      // print("ggggggggggggg ${reportTypeId}");
                                      *//*NavigationService.goBack();
                    storiesCubit.deleteStoryByIndex(
                        storyIndex: storyIndex,
                        pageIndex: pageIndex,
                        userId: storiesCubit
                            .stories[pageIndex].id ??
                            0,
                        context: context);*//*
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
                      }
                      else if(value == "edit"){
                        print("edit message ${widget.message != null}");
                        if(widget.message != null) {
                          print("widget.message ===> ${widget.message}");
                          widget.chatCubit.sendMessageController.text =  widget.message!;
                          widget.chatCubit.edited = true;
                          widget.chatCubit.messageID = widget.messageElement.id;
                          print("widget.chatCubit.messageID ===> ${widget.chatCubit.messageID}");
                          widget.chatCubit.emit(ChatMessageEdit());
                        }
                      }
                      else if(value == "block"){

                      }

                      setState(() {
                        widget.selected =false;
                      });
                      print("hide\n\n\n\n\n");


                    },
                    position: PopupMenuPosition.under,
                    itemBuilder: (_) =>
                    [
                      if (transmitter[index]) ...[
                        HelperFunctions.buildPopupMenu(
                            icons: Icons.edit, title: 'edit', value: 'edit'),
                        HelperFunctions.buildPopupMenu(
                            icons: Icons.delete, title: 'delete', value: 'delete'),
                      ] else
                        ...[
                          HelperFunctions.buildPopupMenu(
                              icons: Icons.report, title: 'report', value: 'report'),
                          HelperFunctions.buildPopupMenu(
                              icons: Icons.block, title: 'block', value: 'block'),
                        ]
                    ],

                  ),*/
                            // moreChoices(context, id: widget.messageElement.id, mee: transmitter[index]),
                          ],
                        ),
                      ),
                      // iconSize: MediaQuery.sizeOf(context).width,

                      onSelected: (value) {
                        print("beeeeeeeeeeeeeeeeeeeeeeeeeeee");
                        if (!HelperFunctions.validateLogin()) {
                          return;
                        }
                        print("beeeeeeeeeeeeeeeeeeeeeeeeeeee");

                      /*  print("value ===> ${value}");
                        if (value == 'report') {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                BlocProvider(
                                  create: (context) => CreateReportCubit(),
                                  child: ReportDialog(
                                    reportType: ReportType.chatMessage,
                                    reportTypeId: widget.messageElement.id,
                                  ),
                                ),
                          );
                        } else if (value == "delete") {
                          showDialog(
                            context: context,
                            builder: (_) =>
                                AlertDialog(
                                  content: Text(
                                    'do_you_want_to_scan'.translate,
                                    style: const TextStyle(fontSize: 24),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        widget.chatCubit.deleteMessage(id: widget.messageElement.id!);                     // var videoData =
                                        *//*await RemoveVideoRepo.removeVideo(
                                    context, body: {"video_id":"$reportTypeId"});*//*
                                        NavigationService.goBack();

                                        // print("ggggggggggggg ${reportTypeId}");
                                        *//*NavigationService.goBack();
                    storiesCubit.deleteStoryByIndex(
                        storyIndex: storyIndex,
                        pageIndex: pageIndex,
                        userId: storiesCubit
                            .stories[pageIndex].id ??
                            0,
                        context: context);*//*
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
                        }
                        else if(value == "edit"){
                          print("edit message ${widget.message != null}");
                          if(widget.message != null) {
                            print("widget.message ===> ${widget.message}");
                            widget.chatCubit.sendMessageController.text =  widget.message!;
                            widget.chatCubit.edited = true;
                            widget.chatCubit.messageID = widget.messageElement.id;
                            print("widget.chatCubit.messageID ===> ${widget.chatCubit.messageID}");
                            widget.chatCubit.emit(ChatMessageEdit());
                          }
                        }
                        else if(value == "block"){

                        }
*/
                        /*setState(() {
                          widget.selected =false;
                        });*/
                        print("hide\n\n\n\n\n");
                      },
                      position: PopupMenuPosition.under,
                      itemBuilder: (_) =>
                      [
                        if (transmitter[index]) ...[
                          HelperFunctions.buildPopupMenu(
                              icons: Icons.edit, title: 'edit', value: 'edit'),
                          HelperFunctions.buildPopupMenu(
                              icons: Icons.delete, title: 'delete', value: 'delete'),
                        ] else
                          ...[
                            HelperFunctions.buildPopupMenu(
                                icons: Icons.report, title: 'report', value: 'report'),
                            HelperFunctions.buildPopupMenu(
                                icons: Icons.block, title: 'block', value: 'block'),
                          ]
                      ],
                    ),




                  ),
                );
              }),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),

              width: MediaQuery.of(context).size.width * 0.6,
              constraints: BoxConstraints(minHeight: 30),
              // height: 30,
              child: TextFormField(
                controller: messageController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                textAlignVertical: TextAlignVertical.center,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "اكتب رساله",

                  filled: true,
                  fillColor: Colors.white.withOpacity(0.4),
                  // constraints: BoxConstraints(minHeight: 40,maxHeight: 40),
                  hintMaxLines: 1,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10),
                  suffix: InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.add,
                      size: 18,
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30)),
                  focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30)),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30)),
                  disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
