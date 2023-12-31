import 'dart:developer';

import 'package:creen/features/live/presentation/widgets/icon_item.dart';
import 'package:flutter/material.dart';

class GuestsListPage extends StatefulWidget {
  const GuestsListPage({super.key, required this.guestsData, required this.liveProfile});
final List<String> guestsData;
final String? liveProfile;

  @override
  State<GuestsListPage> createState() => _GuestsListPageState();
}

class _GuestsListPageState extends State<GuestsListPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
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
      body: Container(decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
             widget.liveProfile!,
            ),
            fit: BoxFit.cover,
            opacity: 0.2,
            colorFilter: const ColorFilter.mode(
                Colors.black87, BlendMode.lighten)),
      ),
        child: ListView.separated(itemBuilder: (context,index)=>Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 50,
                height: 50,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                image: NetworkImage("https://www.cdc.gov/diabetes/images/research/reaching-treatment-goals.jpg?_=66821"),
                fit: BoxFit.cover
                ),
              ),
            ),
            Text(widget.guestsData[index],style: const TextStyle(fontSize: 20,color: Colors.white),),
            InkWell(onTap:(){
              setState(() {
                widget.guestsData.removeAt(index);

              });
            },child: Icon(Icons.close,color: Colors.white,)),
            IconItem(
              onIcon: Icons.mic,
              offIcon: Icons.mic_off,
              onTap: () async {
                log("mic Tapped");
              }, offTap: () {  },
            ),
            IconItem(
              onIcon: Icons.videocam_outlined,
              offIcon: Icons.videocam_off_outlined,
              onTap: () async {
                log("mic Tapped");
              }, offTap: () {

            },
            ),
            InkWell(onTap:(){
              setState(() {
                widget.guestsData.removeAt(index);

              });
            },child: Icon(Icons.chat,color: Colors.white,)),


          ],
        ), separatorBuilder: (BuildContext context, int index) { return const Divider(color: Colors.grey,); }, itemCount: widget.guestsData.length,),
      ),
    );
  }
}
