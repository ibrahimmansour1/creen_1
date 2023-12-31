import 'dart:developer';

import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/features/live/repo/followers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FollowerLive extends StatefulWidget {
  const FollowerLive({super.key});

  @override
  State<FollowerLive> createState() => _FollowerLiveState();
}

class _FollowerLiveState extends State<FollowerLive> {
  List<Follower> followersData = [

  ];
  List<Follower> searchResult = [];
  List<Follower> selectedFollowers = [];
late List<String> names;
  TextEditingController searchController = TextEditingController();
  bool search = false;

  @override
  void initState() {
    FollowersRepo.getFollowers(userId: HelperFunctions.currentUser!.id!).then(
        (value){
setState(() {
  followersData.addAll(value!);
});
        }
    );
    for(Follower element in followersData){
      names.add(element.name);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    search = searchController.text.isNotEmpty;
    return Scaffold(
      backgroundColor: liveBackground,
      appBar: AppBar(
        forceMaterialTransparency: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        title: ((search && searchResult.isEmpty))
            ? null
            : MaterialButton(
                onPressed: () {
                  Navigator.pop(context,selectedFollowers);
                },
                color: selectedFollowers.isEmpty?Colors.grey:Colors.green,
                child: const Text("موافق",style: TextStyle(
                  color: Colors.white
                ),),
              ),
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
      ),
      body: Column(
        children: [
          TextFormField(
            controller: searchController,
            style: const TextStyle(color: Colors.white,),
            onChanged: (str) {
              if (str.isEmpty) {
                setState(() {
                  search = false;
                });
              } else {
                setState(() {
                  search = true;
                });
                if (names.contains(searchController.text)) {
                  log("Follower is found");
                } else {
                  log("Follower is not found");
                }
              }
            },
            decoration: InputDecoration(
                hintText: "بحث",
                hintStyle: const TextStyle(color: Colors.white),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                suffix: InkWell(
                  onTap: () {
                    if (names.contains(searchController.text)) {
                      log("Follower is found");
                    } else {
                      log("Follower is not found");
                    }
                  },
                  child: const Icon(Icons.search_rounded,color: Colors.white,),
                ),   border: const UnderlineInputBorder(
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
              ),),
          ),
          const SizedBox(
            height: 15,
          ),
          (search && searchResult.isEmpty)
              ? const Text("لا يوجد متابع بهذا الاسم",style: TextStyle(color: Colors.white),)
              : Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    // height: MediaQuery.of(context).size.height,
                    child: ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        var existed =
                            selectedFollowers.contains(followersData[index]);
                        return InkWell(
                          onTap: () {
                            if (existed) {
                              setState(() {
                                selectedFollowers.remove(followersData[index]);
                              });
                            } else {
                              setState(() {
                                selectedFollowers.add(followersData[index]);
                              });
                            }
                          },
                          child: Row(
                            children: [
                              Container(
                                width: 20.r,
                                height: 20.r,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white)),
                                child: (selectedFollowers.isNotEmpty && existed)
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.green,
                                        size: 15,
                                      )
                                    : null,
                              ),
                               Padding(
                                 padding:  EdgeInsets.symmetric(horizontal: 8.w),
                                 child: CircleAvatar(
                                  radius: 30.r,
                                  backgroundColor: followersData[index].profile == null ?Colors.white:null,
                                  backgroundImage: followersData[index].profile == null ? const AssetImage('assets/images/person_default.png',):NetworkImage(
                                      followersData[index].profile!
                              )as ImageProvider<Object>,
                               ),),
                              Expanded(
                                child: Text(
                                  followersData[index].name,
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  style:  TextStyle(fontSize: 20.sp,color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemCount: followersData.length,
                    ),
                  ),
                ),

        ],
      ),
    );
  }
}
