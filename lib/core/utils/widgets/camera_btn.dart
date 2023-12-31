import 'package:flutter/material.dart' hide NavigationDrawer;

class CameraButton extends StatelessWidget {
  final String? title;
  final bool? isImage;
  final double? width, radius, height;
  final void Function() function;
  const CameraButton(
      {Key? key,
      required this.title,
      required this.function,
      this.width,
      this.radius,
      this.height,
      this.isImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: function,child:               Container(
      margin: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.1),
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.green,
        shape: BoxShape.circle,
      ),
      child:const Icon(Icons.camera_alt,size: 70,color: Colors.white,),),
    )/*SizedBox(
      height: height ?? Sizes.screenHeight() * 0.07,
      width: width ?? Sizes.screenWidth() * 0.23,
      child: *//*TextButton(
        onPressed: function,
       *//**//* style: TextButton.styleFrom(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 10),
              side: const BorderSide(color: MainStyle.primaryColor)),
          shadowColor: MainStyle.shadowColor,
          backgroundColor: Colors.white,
        ),*//**//*
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              *//**//*ImageIcon(
                  AssetImage(isImage!
                      ? 'assets/images/gallery.png'
                      : 'assets/images/video.png'),
                  color: MainStyle.primaryColor),*//**//*
              CircleAvatar(child:Icon(Icons.camera_alt,size: 50,),backgroundColor: Colors.green,radius: 60,),

              const SizedBox(
                width: 10,
              ),
*//**//*
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  title!.translate,
                  style: MainTheme.authTextStyle
                      .copyWith(fontSize: 16, fontWeight: FontWeight.normal),
                  //textAlign: TextAlign.start,
                ),
              ),
*//**//*

              //Icon(Icons.photo,color: MainStyle.primaryColor,),
            ],
          ),
        ),
      )*//*,
    )*/;
  }
}
