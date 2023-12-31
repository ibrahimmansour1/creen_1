import 'dart:io';

import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
   const ImageView({super.key, required this.image});
final File image;
  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Image.file(widget.image ),
      ),
    );
  }
}
