import 'package:creen/core/utils/constants.dart';
import 'package:creen/features/live/model/live_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LiveAttendance extends StatelessWidget {
  const LiveAttendance({super.key, required this.users});
  final List<LiveUser> users;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: liveBackground,

      body: SafeArea(
        child: GridView.builder(
/*
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: radius,
          mainAxisExtent: radius+19,
          mainAxisSpacing: 20.0,
          crossAxisSpacing: 20.0,
        ),
*/
          gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
          itemBuilder: (context, index) {
            LiveUser user = users[index];
            String? userProfile =  user.user?.profile;
            return InkWell(
            onTap: () {

            },
            child: Column(
              children: [
                if(userProfile != null)
              Container(
              width: 50.r,
              height: 50.r,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(userProfile!,), fit: BoxFit.cover,
                  )),
            )

                else
                  CircleAvatar(radius: 25.r,backgroundImage: AssetImage(personProfile),backgroundColor: Colors.transparent,)
/*
                Container(
                  width: 50.r,
                  height: 50.r,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration:  BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(userProfile!,), fit: BoxFit.cover,
                      )),
                ),
*/
                ,Text(user.guest??user.user!.name!,style: const TextStyle(color: Colors.white),)
              ],
            ),
          );},
          padding: const EdgeInsets.all(4),
          itemCount:users.length-1 ,
        ),
      )

    );
  }
}
