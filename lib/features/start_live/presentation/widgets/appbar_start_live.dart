import 'package:flutter/material.dart';

class AppbarStartLive extends StatelessWidget {
   const AppbarStartLive({super.key,  this.named = false, this.isVideo = true, this.icon});
   final bool named ;
   final bool isVideo;
   final IconData? icon;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double iconWidth = size.width*0.25;

    return  AppBar(
      forceMaterialTransparency: true,
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      title:
     named? Padding(
       padding: const EdgeInsets.all(10.0),
       child: Image.asset('assets/images/${isVideo?'live_stream.png':'mic.png'}',width: iconWidth,height: iconWidth,),
     ):null
      ,
      toolbarHeight:iconWidth*2,      // centerTitle: true,

      actions: [
        Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            shape: BoxShape.circle,
          ),
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.close,color: Colors.white,),
          ),
        )
      ],
    );
  }
}
