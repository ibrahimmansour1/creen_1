import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:creen/features/cam/image_item_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../main.dart';
import 'camera_mode.dart';
import 'camera_notifier.dart';
import 'camera_service.dart';
import 'camera_side.dart';

class TakePicView extends StatefulWidget {
  const TakePicView({super.key});

  @override
  State<TakePicView> createState() => _TakePicViewState();
}

class _TakePicViewState extends State<TakePicView> {
  late CameraController controller;
  XFile? imageFile;
  List<File>? files = [];
  List<bool> selectedIndex = [];
  FlashMode flashMode = FlashMode.off;
  bool videoRecording = false;
  int flashIndex = 0;

  bool isFront = false;

  Widget getIconByPlatform() {
    if (kIsWeb) {
      return const Icon(
        Icons.flip_camera_android,
        color: Colors.white,
      );
    }
    if (Platform.isAndroid) {
      return const Icon(
        Icons.flip_camera_android,
        color: Colors.white,
      );
    } else {
      return const Icon(
        Icons.flip_camera_ios,
        color: Colors.white,
      );
    }
  }

  IconData get flashModeIcon {
    switch (flashMode) {
      case FlashMode.always:
        {
          return Icons.flash_on;
        }

      case FlashMode.auto:
        {
          return Icons.flash_auto;
        }

      case FlashMode.off:
        {
          return Icons.flash_off;
        }

      case FlashMode.torch:
        {
          return FontAwesomeIcons.lightbulb;
        }

      default:
        throw "INVALID FLASH MODE";
    }
  }

  void onFileFunction(file) {
    // controller.captureImage(file);
    // Navigator.pop(context, controller.selectedImages);
  }

  late CameraNotifier cont = CameraNotifier(
    flashModes: FlashMode.values,
    service: CameraServiceImpl(),
    onPath: (path) => onFileFunction(File(path)),
    cameraSide: CameraSide.all,
    enableAudio: false,
    mode: CameraMode.ratio16s9,
  );

  final FilterOptionGroup _filterOptionGroup = FilterOptionGroup(
    imageOption: const FilterOption(
      sizeConstraint: SizeConstraint(ignoreSize: true),
    ),
  );
  ThumbnailOption option =
      const ThumbnailOption(size: ThumbnailSize.square(100));

  // final int _sizePerPage = 50;

  AssetPathEntity? _path;
  int _totalEntitiesCount = 0;

  int _page = 0;
  bool _isLoading = false;
  bool _isLoadingMore = false;
  bool _hasMoreToLoad = true;
  List<AssetEntity> entities = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
/*
      cont = CameraNotifier(
        flashModes: FlashMode.values,
        service: CameraServiceImpl(),
        onPath: (path) => onFileFunction(File(path)),
        cameraSide: CameraSide.all,
        enableAudio: false,
        mode: CameraMode.ratio16s9,
      );
*/
      final PermissionState ps = await PhotoManager.requestPermissionExtend();
      if (ps.isAuth) {
        // Granted.
        final List<AssetPathEntity> paths = await PhotoManager.getAssetPathList(
          onlyAll: true,
          filterOption: _filterOptionGroup,
        );
        if (!mounted) {
          return;
        }
        // Return if not paths found.
        if (paths.isEmpty) {
          setState(() {
            _isLoading = false;
          });
          if (kDebugMode) {
            print('No paths found.');
          }
          return;
        }
        setState(() {
          _path = paths.first;
        });
        _totalEntitiesCount = await _path!.assetCountAsync;
        await _path!.getAssetListRange(start: 0, end: 40).then((value) {
          // print("gggggggggggggg ${value}");
          setState(() {
            entities = value;
            selectedIndex =
                List<bool>.generate(entities.length, (index) => false);
          });
          if (kDebugMode) {
            print("entities $entities");
          }

          return entities;
        });
      } else {
        // Limited(iOS) or Rejected, use `==` for more precise judgements.
        // You can call `PhotoManager.openSetting()` to open settings for further steps.
      }
    });
    controller = CameraController(cameras[0], ResolutionPreset.max);

    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    if (!controller.value.isInitialized) {
      return Container();
    }
    if (kDebugMode) {
      print("entites ${entities.length}");
    }
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
              width: size.width,
              height: size.height,
              child: CameraPreview(controller)),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              // color: Colors.red,
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).systemGestureInsets.top),
              height: 80,
              // alignment: Alignment.centerRight,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 32, right: 64),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.black.withOpacity(0.6),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: (() {
                            files = [];
                            Navigator.pop(context);
                          }),
                          icon: const Icon(Icons.close),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 32, left: 64),
                      child: CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.black.withOpacity(0.6),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              flashIndex += 1;
                              if (flashIndex > FlashMode.values.length) {
                                flashIndex = 0;
                              }
                              flashMode = FlashMode.values[flashIndex];
                              controller.setFlashMode(flashMode);
                            });
                          },
                          icon: Icon(
                            flashModeIcon,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  /*IconButton(
                    color: Colors.white,
                    onPressed: () async {
                      controller.openGallery().then((value) {
                        if (controller.selectedImages.isNotEmpty) {
                          Navigator.pop(context, controller.selectedImages);
                        }
                      });
                    },
                    icon: const Icon(Icons.image),
                  ),*/
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (selectedIndex.contains(true))
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                        onTap: () {
                          setState(() {
                            // selectedIndex.setAll(0, [false]);
                            for (int i = 0; i < selectedIndex.length; i++) {
                              selectedIndex[i] = false;
                            }
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: const Color(0xFF3B9889),
                          radius: 26.r,
                          child: Icon(
                            Icons.close,
                            color: Colors.white,
                            size: 25.r,
                          ),
                        )),
                    InkWell(
                      onTap: () async {
                        for (int i = 0; i < selectedIndex.length; i++) {
                          if (selectedIndex[i]) {
                            await entities[i]
                                .file
                                .then((value) => files!.add(value!));
                          }
                        }
                        // print("image File path ==> ${imageFile!.path}");
                        // files!.add(File(imageFile!.path));
                        if (kDebugMode) {
                          print("files length ==> ${(files ?? []).length}");
                        }
                        if (context.mounted) {
                          Navigator.pop(context, files);
                        }
                      },
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFF3B9889),
                        radius: 26.r,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 25.r,
                        ),
                      ),
                    ),
/*
                    CustomTextButton(
                      width: Sizes.screenWidth() * 0.45,
                      title: 'unselect',
                      function: () {
                        setState(() {
                          // selectedIndex.setAll(0, [false]);
                          for (int i =0 ;i< selectedIndex.length;i++) {
                            selectedIndex[i] = false;
                          }
                        });
                      },
                    ),
*/
/*
                    CustomTextButton(
                      width: Sizes.screenWidth() * 0.45,
                      title: 'submit',
                      function: () async{
                       for(int i=0;i<selectedIndex.length;i++){
                         if(selectedIndex[i]) {
                         await  entities[i].file.then((value) => files!.add( value!));

                         }
                       }
                        // print("image File path ==> ${imageFile!.path}");
                        // files!.add(File(imageFile!.path));
                        if (kDebugMode) {
                          print("files length ==> ${(files??[]).length}");
                        }
                        if(context.mounted) {
                          Navigator.pop(context, files);
                        }
                      },
                    ),
*/
                  ],
                ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Divider(
                    color: Colors.white,
                    endIndent: 150,
                    indent: 150,
                    thickness: 5,
                  ),
                  GestureDetector(
                    child: Container(
                      width: size.width,
                      height: 100,
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      /*decoration: BoxDecoration(
                      border: Border(top:BorderSide(color: Colors.white,width: 4))
                    ),*/
                      child: ListView.separated(
                        itemBuilder: (_, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex[index] = !selectedIndex[index];
                              });
                              if (kDebugMode) {
                                print(
                                    "photo its index $index and path ${entities[index].relativePath} selected:${selectedIndex[index]}");
                              }
                            },
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  /*decoration: BoxDecoration(
                              */ /*image: DecorationImage(
                                // image: FileImage("file"),
                                  image: ,
                                  // image: NetworkImage("https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&quality=85&auto=format&fit=max&s=a52bbe202f57ac0f5ff7f47166906403"),
                                  fit: BoxFit.cover
                              )*/ /*
                          ),*/
                                  child: ImageItemWidget(
                                    entity: entities[index],
                                    option: option,
                                  ),
                                ),
                                if (selectedIndex[index])
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.grey.shade700.withOpacity(0.4),
                                      // shape: BoxShape.circle
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 4,
                        ),
                        itemCount: entities.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    onVerticalDragEnd: (det) async {
                      // await openGallery();
                      try {
                        List<XFile> imagesList =
                            await ImagePicker().pickMultipleMedia();
                        if (imagesList.isEmpty) {
                          return;
                        }
                        files!.addAll(List<File>.generate(imagesList.length,
                            (index) => File(imagesList[index].path)));
                        if (context.mounted) {
                          Navigator.pop(context, files);
                        }

                        // print("vertical drag ${det.primaryVelocity}");
                      } catch (e) {
                        if (kDebugMode) {
                          print("failed to load images");
                        }
                      }
// Navigator.of(context).push(MaterialPageRoute(builder: (context)=>GalleryScreen()));
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () async {
                      try {
                        List<XFile> imagesList =
                            await ImagePicker().pickMultipleMedia();
                        if (imagesList.isEmpty) {
                          return;
                        }
                        files!.addAll(List<File>.generate(imagesList.length,
                            (index) => File(imagesList[index].path)));
                        if (context.mounted) {
                          Navigator.pop(context, files);
                        }

                        // print("vertical drag ${det.primaryVelocity}");
                      } catch (e) {
                        if (kDebugMode) {
                          print("failed to load images");
                        }
                      }
/*
                     showDialog(context: context, builder: (context)=>Dialog(
                       child: Container(
                         width: 75,
                         height: 150,
                         color: Colors.white,
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                           crossAxisAlignment: CrossAxisAlignment.end,
                           mainAxisSize: MainAxisSize.min,
                           children: [
                             InkWell(
                               onTap: (){
                                 Navigator.pop(context);
                               },
                               child: Container(
                                 width: 50,
                                 height: 50,
                                 decoration: const BoxDecoration(
                                   shape: BoxShape.circle,
                                 ),
                                 child: const Icon(Icons.close,color: Colors.black,),
                               ),
                             ),

                             InkWell(onTap: ()async{

                             },
                             child: Container(
                               width: MediaQuery.sizeOf(context).width,
                               alignment: Alignment.center,
                               child: const Text('choose photo'),
                             ),
                             ),
                             InkWell(onTap: ()async{
                               try {
                                 List<XFile> imagesList = [] ;
                                 await ImagePicker().pickVideo(source: ImageSource.gallery).then((value) {
                                   imagesList.add(value!);
                                 });
                                 if (imagesList.isEmpty) {
                                   return;
                                 }
                                 files!.addAll(List<File>.generate(
                                     imagesList.length,
                                         (index) => File(imagesList[index].path)));
                                 if(context.mounted) {
                                   Navigator.pop(context, files);
                                 }

                                 // print("vertical drag ${det.primaryVelocity}");
                               } catch (e) {
                                 if (kDebugMode) {
                                   print("failed to load images");
                                 }
                               }
                             },
                             child: Container(
                               width: MediaQuery.sizeOf(context).width,
                               alignment: Alignment.center,
                               child: const Text('choose Video'),
                             ),
                             ),

                           ],
                         ),
                       ),
                     ));
*/
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.withOpacity(0.8)),
                      child: const Icon(
                        Icons.photo,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  /*InkWell(onTap: () async{
                  await  controller.takePicture().then((value) {
                    setState(() {
                      imageFile =  value;
                    });
                    file = File(imageFile!.path);

                  });
                  */ /* if(context.mounted) {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>ImageView(image: file!)));
        }*/ /*

                },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    width: 100,
                    height: 100,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white,width: 6),
                      shape: BoxShape.circle,
                    ),
                  ),


                ),*/
                  Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(bottom: 32),
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: videoRecording ? Colors.red : Colors.white,
                            width: 4),
                        shape: BoxShape.circle),
                    child: InkWell(
                      onTap: () async {
                        if (videoRecording) {
                          controller.stopVideoRecording().then((value) {
                            log('video value $value');
                            setState(() {
                              videoRecording = false;
                              imageFile = value;
                            });
                            log('format ${imageFile!.name.contains('jpg') || imageFile!.name.contains('jpeg')}');
                            if (kDebugMode) {
                              print("image File path ==> ${imageFile!.path}");
                            }
                            files!.add(File(imageFile!.path));
                            if (kDebugMode) {
                              print("files length ==> ${(files ?? []).length}");
                            }
                            if (context.mounted) {
                              Navigator.pop(context, files);
                            }
                          });
                        } else {
                          await controller.takePicture().then((value) {
                            if (kDebugMode) {
                              print("good");
                            }
                            setState(() {
                              imageFile = value;
                            });
                            log('format ${imageFile!.name.contains('jpg') || imageFile!.name.contains('jpeg')}');
                            if (kDebugMode) {
                              print("image File path ==> ${imageFile!.path}");
                            }
                            files!.add(File(imageFile!.path));
                            if (kDebugMode) {
                              print("files length ==> ${(files ?? []).length}");
                            }
                            if (context.mounted) {
                              Navigator.pop(context, files);
                            }
                          });
                        }

                        /* if(context.mounted) {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>ImageView(image: file!)));
        }*/
                      },
                      onLongPress: () async {
                        controller.startVideoRecording();
                        setState(() {
                          videoRecording = true;
                        }); /* try {
                          List<XFile> imagesList =[];
                          await ImagePicker().pickVideo(source: ImageSource.camera).then((value) {
if(value != null) {
  imagesList.add(value)
                            ;
}
                          });

                          if (imagesList.isEmpty) {
                            return;
                          }
                          files!.addAll(List<File>.generate(
                              imagesList.length,
                                  (index) => File(imagesList[index].path)));


                          // print("vertical drag ${det.primaryVelocity}");
                        } catch (e) {
                          print("failed to load images");
                        }*/
                      },
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor:
                            videoRecording ? Colors.transparent : Colors.white,
                        child: videoRecording
                            ? const Icon(
                                Icons.stop,
                                color: Colors.red,
                                size: 25,
                              )
                            : null,
                      ),
                    ),
                  ),
                  if (cameras.length > 1)
                    InkWell(
                      onTap: () async {
                        if (isFront) {
                          await controller.setDescription(cameras[0]);
                        } else {
                          await controller.setDescription(cameras[1]);
                        }
                        setState(() {
                          isFront = !isFront;
                        });
                        // cont.changeCamera();
                      },
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.8)),
                        child: getIconByPlatform(),
                      ),
                    ),
                ],
              ),
            ],
          )
        ],
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      // floatingActionButton: InkWell(onTap: () async{
      //   await  controller.takePicture().then((value) {
      //     setState(() {
      //       imageFile =  value;
      //     });
      //     file = File(imageFile!.path);
      //
      //   });
      //  /* if(context.mounted) {
      //     Navigator.push(context,MaterialPageRoute(builder: (context)=>ImageView(image: file!)));
      //   }*/
      //
      // },
      //   child: Container(
      //     padding: const EdgeInsets.all(20),
      //     width: 100,
      //     height: 100,
      //     alignment: Alignment.bottomCenter,
      //     decoration: BoxDecoration(
      //       color: Colors.white,
      //           border: Border.all(color: Colors.white,width: 6),
      //       shape: BoxShape.circle,
      //     ),
      //   ),
      //
      //
      // ),
    );
  }
}
