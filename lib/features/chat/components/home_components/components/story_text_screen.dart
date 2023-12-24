import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../core/utils/functions/helper_functions.dart';
import '../../../../../core/utils/routing/navigation_service.dart';
import '../../../../../core/utils/widgets/chat_screen.dart';
import '../../../../cam/take_pic.dart';
import '../../../viewModel/stories/stories_cubit.dart';
import 'create_story_view.dart';

class StoryTextScreenUI extends StatefulWidget {
  const StoryTextScreenUI({Key? key, required this.storiesCubit})
      : super(key: key);
  final StoriesCubit storiesCubit;


  @override
  State<StoryTextScreenUI> createState() => _StoryTextScreenUIState();
}

enum FontFamilies { Arial, DIN }

class _StoryTextScreenUIState extends State<StoryTextScreenUI> {
  Color statusColor = Colors.teal;

  Color? pickerColor = Colors.teal;
  Color fontColor = Colors.white;
  Color fontOutlinedColor = Colors.transparent;

  /*List<Color> statusColors = [
    Colors.amber,
    Colors.teal,
    Colors.green,
    Colors.blueAccent,
    Colors.blueGrey,
    Colors.brown,
    Colors.purple,
    Colors.deepPurple,
    Colors.deepPurpleAccent,
    Colors.pink,
    Colors.pinkAccent,
    Colors.indigo,
    Colors.indigoAccent,
    Colors.deepOrange,
    Colors.deepOrangeAccent
  ];*/
/*List<FontWeight>statusFontWeight=[
  FontWeight.w100,
  FontWeight.w200,
  FontWeight.w300,
  FontWeight.normal,
  FontWeight.w500,
  FontWeight.w600,
  FontWeight.bold,
FontWeight.w800,
  FontWeight.w900,
];*/
  int fontWeightIndex = 4;
  String statusContent = "";
  String? statusFontFamily;
  List<double> statusFontSize = [24.0, 26.0, 28.0, 30];
  int statusFontSizeIndex = 0;
  int colorIndex = 0;
  int statusAlignIndex = 1;
  TextEditingController textController = TextEditingController();
  FontStyle statusFontStyle = FontStyle.normal;
  late FocusNode statusFocusNode;

  TextAlign statusAlign = TextAlign.center;

  @override
  void initState() {
    statusFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    statusFocusNode.dispose();

    super.dispose();
  }
   StoriesCubit storiesCubit = StoriesCubit();
  @override
  Widget build(BuildContext context) {
    // print("statusColor ${statusColor.value}");
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        textDirection: HelperFunctions.currentLanguage == "ar"?TextDirection.rtl:TextDirection.ltr,

        children: [
          Stack(
            alignment: Alignment.centerLeft,
            textDirection: HelperFunctions.currentLanguage == "ar"?TextDirection.rtl:TextDirection.ltr,
            children: [
              InkWell(
                onTap: () {
                  statusFocusNode.requestFocus();
                },
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  color: statusColor,
                  alignment: const Alignment(0, -0.85),
                  child: TextFormField(
                    controller: textController,
                    keyboardType: TextInputType.multiline,
                    focusNode: statusFocusNode,
                    autofocus: false,
                    cursorColor: Colors.white,
                    textAlign: statusAlign,
                    // selectionControls: TextSelectionOverlay().selectionControls,

                    enableInteractiveSelection: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                    ),
                    maxLines: null,
                    style: TextStyle(
                      fontSize: statusFontSize[statusFontSizeIndex],
                      fontFamily: statusFontFamily,
                      fontWeight: FontWeight.values[fontWeightIndex],
                      fontStyle: statusFontStyle,
                      color: fontColor,
                      inherit: true,
                      shadows: [
                        Shadow(
                            // bottomLeft
                            offset: const Offset(-1.5, -1.5),
                            color: fontOutlinedColor),
                        Shadow(
                            // bottomRight
                            offset: const Offset(1.5, -1.5),
                            color: fontOutlinedColor),
                        Shadow(
                            // topRight
                            offset: const Offset(1.5, 1.5),
                            color: fontOutlinedColor),
                        Shadow(
                            // topLeft
                            offset: const Offset(-1.5, 1.5),
                            color: fontOutlinedColor),
                      ],
                      /*foreground: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1
                        ..color = Colors.orange,
                      background: Paint()
                        ..style = PaintingStyle.stroke
                        ..strokeWidth = 1
                        ..color = Colors.black,*/
                    ),
                  ),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                textDirection: HelperFunctions.currentLanguage == "ar"?TextDirection.rtl:TextDirection.ltr,

                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 30),
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: const Icon(CupertinoIcons.multiply)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Pick background color!'),
                                    content: SingleChildScrollView(
                                        child: ColorPicker(
                                            pickerColor:
                                                pickerColor ?? statusColor,
                                            //default color
                                            onColorChanged: (Color color) {
                                              //on color picked
                                              setState(() {
                                                pickerColor = color;
                                              });
                                            })),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        child: const Text('DONE'),
                                        onPressed: () {
                                          setState(() {
                                            statusColor =
                                                pickerColor ?? statusColor;
                                          });
                                          Navigator.of(context)
                                              .pop(); //dismiss the color picker
                                        },
                                      ),
                                      ElevatedButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); //dismiss the color picker
                                        },
                                      ),
                                    ],
                                    actionsAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                  );
                                });
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white)),
                            child: const Icon(
                              Icons.color_lens,
                              size: 30,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              statusFontFamily =
                                  statusFontFamily == FontFamilies.Arial.name
                                      ? FontFamilies.DIN.name
                                      : FontFamilies.Arial.name;
                            });
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white)),
                            child: const Icon(
                              Icons.font_download,
                              size: 30,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              statusFontSizeIndex = statusFontSizeIndex >
                                      (statusFontSize.length - 2)
                                  ? 0
                                  : statusFontSizeIndex + 1;
                            });
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white)),
                            child: const Icon(
                              Icons.format_size,
                              size: 30,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Pick Text color!'),
                                    content: SingleChildScrollView(
                                        child: ColorPicker(
                                            pickerColor:
                                                pickerColor ?? fontColor,
                                            //default color
                                            onColorChanged: (Color color) {
                                              //on color picked
                                              setState(() {
                                                pickerColor = color;
                                              });
                                            })),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        child: const Text('DONE'),
                                        onPressed: () {
                                          setState(() {
                                            fontColor =
                                                pickerColor ?? fontColor;
                                          });
                                          Navigator.of(context)
                                              .pop(); //dismiss the color picker
                                        },
                                      ),
                                      ElevatedButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); //dismiss the color picker
                                        },
                                      ),
                                    ],
                                    actionsAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                  );
                                });
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white)),
                            child: const Icon(
                              Icons.format_color_text,
                              size: 30,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Pick Textborder color!'),
                                    content: SingleChildScrollView(
                                        child: ColorPicker(
                                            pickerColor: pickerColor ??
                                                Colors.transparent,
                                            //default color
                                            onColorChanged: (Color color) {
                                              //on color picked
                                              setState(() {
                                                pickerColor = color;
                                              });
                                            })),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        child: const Text('DONE'),
                                        onPressed: () {
                                          setState(() {
                                            fontOutlinedColor = pickerColor ??
                                                Colors.transparent;
                                          });
                                          Navigator.of(context)
                                              .pop(); //dismiss the color picker
                                        },
                                      ),
                                      ElevatedButton(
                                        child: const Text('Cancel'),
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); //dismiss the color picker
                                        },
                                      ),
                                    ],
                                    actionsAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                  );
                                });
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white)),
                            child: const Icon(
                              Icons.format_color_fill,
                              size: 30,
                            ),
                          ),
                        ),
                        /* InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Pick Text shadow color!'),
                                    content: SingleChildScrollView(
                                        child: ColorPicker(
                                            pickerColor: pickerColor,
                                            //default color
                                            onColorChanged: (Color color) {
                                              //on color picked
                                              setState(() {
                                                pickerColor = color;
                                              });
                                            })), actions: <Widget>[
                                    ElevatedButton(
                                      child: const Text('DONE'),
                                      onPressed: () {
                                        setState(() {
                                          statusColor = pickerColor;
                                        });
                                        Navigator.of(context)
                                            .pop(); //dismiss the color picker
                                      },
                                    ),
                                    ElevatedButton(
                                      child: const Text('Cancel'),
                                      onPressed: () {

                                        Navigator.of(context)
                                            .pop(); //dismiss the color picker
                                      },
                                    ),
                                  ],
                                    actionsAlignment: MainAxisAlignment.spaceEvenly,);});
                          },
                          child: Icon(Icons.format_siz,size: 30,e),
                        ),*/
                        InkWell(
                          onTap: () {
                            setState(() {
                              fontWeightIndex = fontWeightIndex >
                                      (FontWeight.values.length - 2)
                                  ? 0
                                  : fontWeightIndex + 1;
                            });
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white)),
                            child: const Icon(
                              Icons.format_bold,
                              size: 30,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              statusFontStyle =
                                  statusFontStyle == FontStyle.normal
                                      ? FontStyle.italic
                                      : FontStyle.normal;
                            });
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white)),
                            child: const Icon(
                              Icons.format_italic,
                              size: 30,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              statusAlignIndex = statusAlignIndex > 1
                                  ? 0
                                  : statusAlignIndex + 1;
                            });
                            if (statusAlignIndex == 0) {
                              setState(() {
                                statusAlign = TextAlign.center;
                              });
                            } else if (statusAlignIndex == 1) {
                              setState(() {
                                statusAlign = TextAlign.left;
                              });
                            } else {
                              setState(() {
                                statusAlign = TextAlign.right;
                              });
                            }
                          },
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white)),
                            child: const Icon(
                              Icons.align_horizontal_left,
                              size: 30,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
          InkWell(
            onTap: () async {
              // print("statusColor.value ${statusColor.value}");

            List<File>? pickFiles = await Navigator.of(context).push(
                MaterialPageRoute(
                 /* builder: (context) =>  const WhatsappCamera(
                    multiple: false,
                  ),*/
                  builder: (context) =>  const TakePicView(),
                ),
              );
              if (pickFiles == null) {
                return;
              }
              var data = await NavigationService.push(
                  page: CreateStoryView(
                pickedImage: pickFiles,
              ));
              if(data == -1) {
                return;
              }
              bool isContain(String format)=>pickFiles.first.path.contains(format);
              bool isImage = (isContain('.jpg')|| isContain('.jpeg')||isContain('.png')||isContain('.gif')||isContain('.bmp')||isContain('.WebP'));
              if(isImage) {
                log('image');
              } else {
                log('video');
              }
              // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>  CameraPrevie()));
           for (StatusDescription statusDescriptionElement in data){
           await   widget.storiesCubit.createNewStory(
                image: (statusDescriptionElement.isVideo)?
                null:statusDescriptionElement.image,
                description: statusDescriptionElement.descriptionController?.text,
                background: "${statusColor.value}",
                fontSize: "${statusFontSize[statusFontSizeIndex]}",
                fontFamily: statusFontFamily,
                fontColor: "${fontColor.value}",
                fontWeight: "${FontWeight.values[fontWeightIndex]}",
                align: "$statusAlign",
                outline: '${statusFontStyle.index}',
                record: null,
                video: (statusDescriptionElement.isVideo)?
                statusDescriptionElement.image:null, fontBorderColor: '${fontOutlinedColor.value}',
              );
            }
              NavigationService.push(
                page: const AllConversationsScreen(),
                isNamed: false,
              );
            },
            child: Container(
              width: 60,
              height: 60,
              margin: const EdgeInsets.only(bottom: 10),
              decoration: const BoxDecoration(
                  color: Colors.white, shape: BoxShape.circle),
              child: const Icon(
                Icons.camera_alt,
                size: 55,
              ),
            ),
          )
        ],
      ),

      floatingActionButton: InkWell(
        onTap: () {
          statusContent = textController.text;
          if (statusContent.isNotEmpty) {
            storiesCubit.createNewStory(
              image: null,
              description: statusContent,
              background: "${statusColor.value}",
              fontSize: "${statusFontSize[statusFontSizeIndex]}",
              fontFamily: statusFontFamily,
              fontColor: "${fontColor.value}",
              fontWeight: "${FontWeight.values[fontWeightIndex].index}",
              align: "${statusAlign.index}",
              outline: '${statusFontStyle.index}',
              record: null,
              video: null, fontBorderColor: '${fontOutlinedColor.value}',
            );
            NavigationService.goBack(result: statusContent);
          } else {
            Fluttertoast.showToast(msg: "The status is empty");
          }
        },
        child: Container(
            width: 55,
            height: 55,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.teal,
                border: Border.all(color: Colors.white),
                shape: BoxShape.circle),
            child: const Icon(
              Icons.send,
              color: Colors.white,
              size: 30,
            )),
      ),
    );
  }
}
