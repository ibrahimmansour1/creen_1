import 'dart:io';

import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

import '../../../../../core/utils/widgets/register_text_field.dart';

class CreateStoryView extends StatefulWidget {
  const CreateStoryView({
    super.key,
    required this.pickedImage,
  });

  final List<File> pickedImage;

  @override
  State<CreateStoryView> createState() => _CreateStoryViewState();
}

class _CreateStoryViewState extends State<CreateStoryView> {
  List<StatusDescription> statusDescriptionList = [];
  int pickedImageLength = 0;
  late final Size video;

  @override
  void initState() {
    pickedImageLength = widget.pickedImage.length;
    statusDescriptionList =
        List<StatusDescription>.generate(pickedImageLength, (index) {
      var isvideo = !(widget.pickedImage[index].path.contains('.jpg') ||
          widget.pickedImage[index].path.contains('.jpeg'));
      VideoPlayerController? videoController = isvideo
          ? VideoPlayerController.file(widget.pickedImage[index])
          : null;
      // var videoController = isvideo?videoController[index]!.initialize():null;
      if (isvideo) {
        videoController!.setLooping(true);
      }
      return StatusDescription(
          image: widget.pickedImage[index],
          videoController: videoController,
          isVideo: isvideo,
          descriptionController: TextEditingController(),
          initializeVideoPlayerFuture:
              isvideo ? videoController!.initialize() : null);
    });

    super.initState();
  }

  @override
  void dispose() {
    for (StatusDescription statusDescriptionElement in statusDescriptionList) {
      statusDescriptionElement.descriptionController!.dispose();

      if (statusDescriptionElement.isVideo) {
        statusDescriptionElement.videoController!.dispose().then((value) {});
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const AllConversationsScreen()));
            NavigationService.goBack(result: -1);
            // Navigator.of(context).pop();
          },
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: PageView.builder(
        itemBuilder: (context, index) {
          StatusDescription statusElement = statusDescriptionList[index];
          if(statusElement.isVideo){
            statusElement.videoController!.play();
          }
          return Column(
            children: [
              if (statusElement.isVideo)
                // Use a FutureBuilder to display a loading spinner while waiting for the
// VideoPlayerController to finish initializing.
                FutureBuilder(
                  future: statusElement.initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If the VideoPlayerController has finished initialization, use
                      // the data it provides to limit the aspect ratio of the video.
                      return SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.8,
                        child: AspectRatio(
                          aspectRatio:
                          statusElement.videoController!.value.aspectRatio,
                          // Use the VideoPlayer widget to display the video.
                          child: VideoPlayer(statusElement.videoController!),
                        ),
                      );
                    } else {
                      // If the VideoPlayerController is still initializing, show a
                      // loading spinner.
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                )
              else
                Expanded(
                  child: Image.file(
                    statusElement.image!,
                    // widget.pickedImage[index],
                    height: 300.r,
                    width: 300.r,
                  ),
                ),

              // else

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                textDirection: TextDirection.ltr,
                children: [
                  InkWell(
                    onTap: () {
                      NavigationService.goBack(
                          result: statusDescriptionList);
                          // result: statusElement.descriptionController!.text);
                      // NavigationService.pushReplacement(page:,arguments: descriptionController.text);
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.green,
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 10.r,left: 20,right: 10),
                    child: RegisterTextField(
                      maxLines: null,
                      controller: statusElement.descriptionController,
                      isStatus: true,
                    ),
                  ),
                ],
              ),
            ],
          );
        },
        // itemCount: widget.pickedImage.length,
        itemCount: statusDescriptionList.length,
      ),
    );
  }
}

class StatusDescription {
  File? image;
  VideoPlayerController? videoController;
  bool isVideo;
  TextEditingController? descriptionController;
  Future<void>? initializeVideoPlayerFuture;

  StatusDescription({
    required this.image,
    required this.videoController,
    required this.isVideo,
    required this.descriptionController,
    required this.initializeVideoPlayerFuture,
  });
}
