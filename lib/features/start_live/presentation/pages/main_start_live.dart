import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/features/start_live/presentation/pages/sound_page.dart';
import 'package:creen/features/start_live/presentation/pages/video_page.dart';
import 'package:creen/features/start_live/presentation/widgets/appbar_start_live.dart';
import 'package:creen/features/start_live/presentation/widgets/main_start_live_select_item.dart';
import 'package:creen/features/start_live/viewmodel/cubit/main_start_live_cubit.dart';
import 'package:creen/features/start_live/viewmodel/state/main_start_live_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/responsive/sizes.dart';

class MainStartLive extends StatelessWidget {
  MainStartLive({super.key});

   MainStartLiveCubit mainStartLiveCubit = MainStartLiveCubit();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    double iconWidth = size.width*0.3;

    return BlocProvider(
      create: (BuildContext context) =>MainStartLiveCubit(),
      child: BlocConsumer<MainStartLiveCubit, MainStartLiveStates>(
        builder: (BuildContext context, MainStartLiveStates state) {
          return Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/live_backgroundd.jpeg')
              ,fit: BoxFit.cover)
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              // backgroundColor: liveBackground,
              appBar: PreferredSize(
                  preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
                  child: const AppbarStartLive()),
              body: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

/*
                  const Text(
                    "اختر نوع البث المباشر",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
*/
                  // Image.asset('assets/images/earth.png',width: MediaQuery.sizeOf(context).width*,),
                  // SizedBox(height: 30,),
/*
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.2),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MainStartLiveSelectItem(
                          selectIcon: Icons.play_arrow_outlined,
                          selectLabel: 'فيديو',
                          selectTap: () {
                            mainStartLiveCubit.selectItem(context,
                                // page:  const Agora());
                                page:  const VideoPage());
                          },
                        ),
                        MainStartLiveSelectItem(
                          selectIcon: Icons.mic,
                          selectLabel: 'صوت',
                          selectTap: () {
                            mainStartLiveCubit.selectItem(context,
                                page:  const SoundPage());
                          },
                        ),
                      ],
                    ),
                  ),
*/
                  Padding(
                    padding:  EdgeInsets.only(top: 70.0.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: (){
                            mainStartLiveCubit.selectItem(context,
                                // page:  const Agora());
                                page:  const VideoPage());
                          },
                          child:                   Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(0.3),

                              ),
                              child: Image.asset('assets/images/live_stream.png',width: iconWidth,height: iconWidth,)),

                        ),


                        InkWell(
                          onTap: (){

                            // HelperFunctions.showComingSoonDialog(context);

                          },
                          child:                   Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(0.3),

                              ),

                              child: Image.asset('assets/images/vs.png',width: iconWidth,height: iconWidth,)),

                        ),
                        InkWell(
                          onTap: (){
                            mainStartLiveCubit.selectItem(context,
                                page:  const SoundPage());
                          },
                          child:                   Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.withOpacity(0.3),

                              ),

                              child: Image.asset('assets/images/mic.png',width: iconWidth,height: iconWidth,)),

                        ),
                      ],
                    ),
                  )

                ],
              ),
            ),
          );
        },
        listener: (BuildContext context, MainStartLiveStates state) {},
      ),
    );
  }
}
