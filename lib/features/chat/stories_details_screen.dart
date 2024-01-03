import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/extensions/num_extensions.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/core/utils/widgets/custom_appbar.dart';
import 'package:creen/features/chat/components/home_components/components/view_story_screen.dart';
import 'package:creen/features/chat/viewModel/stories/stories_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/*

class StoriesDetailsScreen extends StatefulWidget {
  const StoriesDetailsScreen({super.key,
    // required this.stories
  });

  @override
  State<StoriesDetailsScreen> createState() => _StoriesDetailsScreenState();
}

class _StoriesDetailsScreenState extends State<StoriesDetailsScreen> {
 // final List<StoryPublisher> stories;
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
        child: const CustomAppBar(
          back: true,
          title: 'stories',
          main: false,
        ),
      ),


      body: BlocProvider.value(
          value: storiesCubit!,
          child: BlocConsumer<StoriesCubit,StoriesState>(listener: (BuildContext context, state) {

      }, builder: (BuildContext context, Object? state) {
            log('state $state');
        state is StoriesLoading? log('loading'):storiesCubit!.emit(StoriesDone());

        return state is StoriesDone? GridView.builder(gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 15,crossAxisSpacing: Sizes.screenWidth()*0.2,mainAxisExtent: Sizes.screenHeight()*0.3,), itemBuilder: (context,index){
          return InkWell(
            onTap: (){
              NavigationService.push(
                page: BlocProvider.value(
                  value: storiesCubit!,
                  child: ViewStoryScreen(
                    initStoryPage: index,
                  ),
                ),
              );
            },
            child: Stack(
              alignment: HelperFunctions.isArabic?Alignment.bottomRight:Alignment.bottomLeft,
              children: [
                if(storiesCubit!.stories.isNotEmpty && storiesCubit?.stories[index] != null)
                  Container(
                    width: Sizes.screenWidth()*0.31,
                    height: Sizes.screenHeight()*0.3,
                    margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: storiesCubit?.stories[index].story?[0].image !=null?DecorationImage(
                            image: NetworkImage(storiesCubit?.stories[index].story![0].image),
                            fit: BoxFit.cover
                        ):null
                    ),
                  ),
                if(storiesCubit!.stories.isNotEmpty)
                  Container(
                    width: 45,
                    height: 45,
                    margin: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:Border.all(color: Colors.primaries[ index >= 17 ? 0 : index + 1],width: 3.0),
                        image: DecorationImage(
                          image: NetworkImage(storiesCubit!.stories[index].profile!),
                          fit: BoxFit.cover,
                        )
                    ),
                  )
              ],
            ),
          );
        },itemCount: storiesCubit?.stories.length,):const CircularProgressIndicator();
      },)),
    );
  }
}
*/

/*
GridView.builder(gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 15,crossAxisSpacing: Sizes.screenWidth()*0.2,mainAxisExtent: Sizes.screenHeight()*0.3,), itemBuilder: (context,index){
          return InkWell(
            onTap: (){
              NavigationService.push(
                page: BlocProvider.value(
                  value: storiesCubit!,
                  child: ViewStoryScreen(
                    initStoryPage: index,
                  ),
                ),
              );
            },
            child: Stack(
              alignment: HelperFunctions.isArabic?Alignment.bottomRight:Alignment.bottomLeft,
              children: [
                if(storiesCubit!.stories.isNotEmpty && storiesCubit?.stories[index] != null)
                  Container(
                    width: Sizes.screenWidth()*0.31,
                    height: Sizes.screenHeight()*0.3,
                    margin: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: storiesCubit?.stories[index].story?[0].image !=null?DecorationImage(
                            image: NetworkImage(storiesCubit?.stories[index].story![0].image),
                            fit: BoxFit.cover
                        ):null
                    ),
                  ),
                if(storiesCubit!.stories.isNotEmpty)
                  Container(
                    width: 45,
                    height: 45,
                    margin: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border:Border.all(color: Colors.primaries[ index >= 17 ? 0 : index + 1],width: 3.0),
                        image: DecorationImage(
                          image: NetworkImage(storiesCubit!.stories[index].profile!),
                          fit: BoxFit.cover,
                        )
                    ),
                  )
              ],
            ),
          );
        },itemCount: storiesCubit?.stories.length,)
*/

class StoriesDetailsScreen extends StatefulWidget {
  const StoriesDetailsScreen({Key? key}) : super(key: key);

  @override
  State<StoriesDetailsScreen> createState() => _StoriesDetailsScreenState();
}

class _StoriesDetailsScreenState extends State<StoriesDetailsScreen> {
  late StoriesCubit storiesCubit;
  int ColorValue = 0;

  @override
  void initState() {
    storiesCubit = context.read<StoriesCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          liveBackground,
// Color(0xff071B19) ,
          Color(0xff07544E),
        ],
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,

          // appBar: PreferredSize(
          //   preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
          //   child: const CustomAppBar(
          //     title: 'stories',
          //     back: true,
          //     removeBottomBorderColor: true,
          //   ),
          // ),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child:  Row(children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white.withOpacity(.3),
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined, color: Colors.white,
                        size:MediaQuery.of(context).size.height*.02,),
                    ),
                  )
                ],),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 1,
                    mainAxisExtent: Sizes.screenHeight() * 0.3,),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        NavigationService.push(
                          page: BlocProvider.value(
                            value: storiesCubit!,
                            child: ViewStoryScreen(
                              initStoryPage: index,
                            ),
                          ),
                        );
                      },
                      child: Stack(
                        alignment: HelperFunctions.isArabic ? Alignment
                            .bottomRight : Alignment.bottomLeft,
                        children: [
                          if(storiesCubit!.stories.isNotEmpty &&
                              storiesCubit?.stories[index] != null)
                            Container(
                              width: Sizes.screenWidth() * 0.31,
                              height: Sizes.screenHeight() * 0.3,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 5),
                              decoration: BoxDecoration(
                                  color: storiesCubit?.stories[index].story![0]
                                      .image != null
                                      ? Colors.transparent
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: storiesCubit?.stories[index]
                                          .story![0].image != null
                                          ? NetworkImage(
                                          storiesCubit?.stories[index].story![0]
                                              .image)
                                          : const AssetImage(
                                          'assets/images/playbutton.png') as ImageProvider<
                                          Object>,
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                          if(storiesCubit!.stories.isNotEmpty)
                            Container(
                              width: 45,
                              height: 45,
                              margin: const EdgeInsets.all(18),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: Colors.primaries[ index >= 17
                                          ? 0
                                          : index + 1], width: 3.0),
                                  image: DecorationImage(
                                    image: storiesCubit!.stories[index]
                                        .profile != null
                                        ? NetworkImage(
                                        storiesCubit!.stories[index].profile!)
                                        : const AssetImage(
                                        personProfile) as ImageProvider<Object>,
                                    fit: BoxFit.cover,
                                  )
                              ),
                            )
                        ],
                      ),
                    );
                  },
                  itemCount: storiesCubit?.stories.length,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

