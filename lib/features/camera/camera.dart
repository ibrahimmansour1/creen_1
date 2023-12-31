import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class CameraPrevie extends StatefulWidget {
  const CameraPrevie({Key? key}) : super(key: key);

  @override
  State<CameraPrevie> createState() => _CameraPrevieState();
}

class _CameraPrevieState extends State<CameraPrevie> {
  late CameraController controller;
  @override
  void initState() {
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
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Container();
  }
}
