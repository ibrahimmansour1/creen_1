import 'package:creen/core/themes/themes.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/widgets/box_helper.dart';
import 'package:creen/core/utils/widgets/camera_btn.dart';
import 'package:creen/core/utils/widgets/custom_appbar.dart';
import 'package:creen/core/utils/widgets/loader_widget.dart';
import 'package:creen/core/utils/widgets/text_button.dart';
import 'package:creen/features/ads/view/widgets/ads_item.dart';
import 'package:creen/features/ads/viewModel/createAd/create_ad_cubit.dart';
import 'package:creen/features/drawer/presentaion/pages/naviigation_drawer.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/utils/widgets/custom_image.dart';

//final valueProvider1 = StateProvider((ref) => '');
// ignore: must_be_immutable
class GeneralAdScreen extends StatefulWidget {
  const GeneralAdScreen({Key? key}) : super(key: key);

  @override
  State<GeneralAdScreen> createState() => _GeneralAdScreenState();
}

class _GeneralAdScreenState extends State<GeneralAdScreen> {
  // int? value;

  final items = [
    // 'اعلانات عام',
    'job_ads',
    'commodity_ads',
    'services_ads',
  ];
  late CreateAdCubit createAdCubit;

  @override
  void initState() {
    createAdCubit = context.read<CreateAdCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // String value1 = ref.watch(valueProvider1);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        drawer: const NavigationDrawer(),

        appBar: PreferredSize(
          preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
          child: const CustomAppBar(
            back: true,
            title: 'add_ad',
          ),
        ),
        // PreferredSize(
        //     preferredSize: Size.fromHeight(Sizes.screenHeight() * 0.08),
        //     child: Directionality(
        //       textDirection: TextDirection.rtl,
        //       child: AppBar(
        //         centerTitle: true,
        //         title: Row(
        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //           children: [
        //             // IconButton(
        //             //   onPressed: () => NavigationService.goBack(),

        //             //),
        //             //SizedBox(width: 1,),
        //             Text(
        //               'اضافة إعلان عام',
        //               style: MainTheme.appBarTextStyle,
        //             ),

        //                 const Icon(
        //                 Icons.notifications,
        //                 color: Colors.white,

        //             ),
        //           ],
        //         ),
        //         leading:  const Icon(
        //                 Icons.arrow_back_ios,
        //                 color: Colors.white,
        //               ),

        //       ),
        //     )),
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.black, Colors.black45],
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  tileMode: TileMode.clamp)),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            ),
            child: ListView(
              children: [
                Form(
                  key: createAdCubit.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Sizes.screenWidth() * 0.15,
                      ),
                      AdsItem(
                        text: '',
                        isMessage: true,
                        content: 'category',
                        widget: DropdownButtonHideUnderline(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: DropdownButtonFormField<int?>(
                              value: createAdCubit.categoryId,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                              ),
                              items: List.generate(
                                items.length,
                                (index) => buildMenuItem(
                                    index: index, item: items[index]),
                              ),
                              onChanged: createAdCubit.onCategoryChanged,
                              isExpanded: true,
                              icon: const Icon(
                                  Icons.keyboard_arrow_down_outlined),
                              hint: Text(
                                'category'.translate,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.r),
                        child: Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: CameraButton(
                                  width: Sizes.screenWidth() * 0.9,
                                  title: 'upload_photo',
                                  function: createAdCubit.onImagePicked,
                                  radius: 25,
                                  isImage: true,
                                ),
                              ),
                            ),
                            const BoxHelper(
                              width: 20,
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: CameraButton(
                                  width: Sizes.screenWidth() * 0.9,
                                  title: 'upload_video',
                                  function: createAdCubit.onVideoPicked,
                                  radius: 25,
                                  isImage: false,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      BlocBuilder<CreateAdCubit, CreateAdState>(
                        builder: (context, state) {
                          return Visibility(
                            visible: createAdCubit.selectedImages.isNotEmpty ||
                                createAdCubit.selectedVideos.isNotEmpty,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Row(
                                    children: List.generate(
                                      createAdCubit.selectedImages.length,
                                      (index) => CustomImage(
                                        pickedImage:
                                            createAdCubit.selectedImages[index],
                                        onRemoved: () => createAdCubit
                                            .delImageByIndex(index: index),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: List.generate(
                                      createAdCubit.selectedVideos.length,
                                      (index) => CustomImage(
                                        isVideo: true,
                                        pickedImage:
                                            createAdCubit.selectedVideos[index],
                                        onRemoved: () => createAdCubit
                                            .delVideoByIndex(index: index),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      // AdsItem(
                      //   controller: createAdCubit.titleController,
                      //   text: '',
                      //   isMessage: false,
                      //   onChanged: (v) {},
                      //   hintText: 'عنوان الإعلان',
                      //   validator: (v) {
                      //     if (v!.isEmpty) {
                      //       return 'العنوان مطلوب';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      AdsItem(
                        controller: createAdCubit.youtubeController,
                        text: '',
                        isMessage: false,
                        keyboardType: TextInputType.url,
                        onChanged: (v) {},
                        hintText: 'youtube_link',
                      ),
                      AdsItem(
                        controller: createAdCubit.whatsappController,
                        text: '',
                        isMessage: false,
                        keyboardType: TextInputType.phone,
                        onChanged: (v) {},
                        hintText: 'whats',
                      ),
                      AdsItem(
                        controller: createAdCubit.linkController,
                        text: '',
                        isMessage: false,
                        onChanged: (v) {},
                        hintText: 'link',
                      ),
                      AdsItem(
                        text: '',
                        controller: createAdCubit.descController,
                        isMessage: true,
                        onChanged: (v) {},
                        hintText: 'content',
                      ),
                      // Row(
                      //   children: [
                      //     Checkbox(
                      //       value: true,
                      //       onChanged: (v) {},
                      //       activeColor: Colors.black,
                      //     ),
                      //     const Text('إضافة محتوى')
                      //   ],
                      // ),
                      SizedBox(
                        height: Sizes.screenHeight() * 0.06,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: BlocBuilder<CreateAdCubit, CreateAdState>(
                          builder: (context, state) {
                            if (state is CreateAdLoading) {
                              return const LoaderWidget();
                            }
                            return CustomTextButton(
                              width: Sizes.screenWidth() * 0.9,
                              title: 'add',
                              function: () => createAdCubit.createNewAd(
                                context: context,
                              ),
                              radius: 10,
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        height: Sizes.screenHeight() * 0.06,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<int?> buildMenuItem({
    String? item,
    int? index,
  }) =>
      DropdownMenuItem(
        value: (index ?? 0) + 1,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              index == 0
                  ? const Icon(Icons.work)
                  : index == 1
                      ? const Icon(Icons.shopping_cart)
                      : const Icon(Icons.account_balance_wallet),
              SizedBox(
                width: 10.w,
              ),
              Text(
                item!.translate,
                style: MainTheme.authTextStyle.copyWith(
                  fontSize: 15.r,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      );
}
