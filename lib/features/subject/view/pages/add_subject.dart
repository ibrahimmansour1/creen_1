
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/responsive/sizes.dart';
import 'package:creen/core/utils/widgets/app_loader.dart';
import 'package:creen/core/utils/widgets/camera_btn.dart';
import 'package:creen/core/utils/widgets/custom_appbar.dart';
import 'package:creen/core/utils/widgets/custom_image.dart';
import 'package:creen/core/utils/widgets/dropdown_widget.dart';
import 'package:creen/core/utils/widgets/text_button.dart';
import 'package:creen/features/ads/view/widgets/ads_item.dart';
import 'package:creen/features/market/viewModel/categories/categories_cubit.dart';
import 'package:creen/features/subject/viewModel/createBlogs/create_new_blogs_cubit.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';

//final valueProvider1 = StateProvider((ref) => '');
// ignore: must_be_immutable
class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({Key? key}) : super(key: key);

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> {
  late CategoriesCubit categoriesCubit;
  late CreateNewBlogsCubit createNewBlogsCubit;

  String? value;
  @override
  void initState() {
    categoriesCubit = context.read<CategoriesCubit>()..getCategories(context);
    createNewBlogsCubit = context.read<CreateNewBlogsCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // String value1 = ref.watch(valueProvider1);

    return Scaffold(

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
              Column(

                children: [
                  SizedBox(
                    height: Sizes.screenWidth() * 0.05,
                  ),
                  Row(children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: InkWell(onTap: (){
                        Navigator.pop(context);
                      },child: const Icon(Icons.arrow_back_ios_new_outlined)),
                    ),
                  ],),
                  SizedBox(
                    height: Sizes.screenWidth() * 0.05,
                  ),
                  BlocBuilder<CategoriesCubit, CategoriesState>(
                    builder: (context, state) {
                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: DropDownWidget(
                          labelText: 'category',
                          selectedValueIndex: (createNewBlogsCubit.blog ==
                                      null ||
                                  state is CategoriesLoading)
                              ? null
                              : categoriesCubit.categoryIndexByCategoryId(
                                  categoryId: createNewBlogsCubit.categoryId,
                                ),
                          validator: createNewBlogsCubit.categoryValidator,
                          values: categoriesCubit.categories
                              .map((e) => e.name ?? '')
                              .toList(),
                          onChanged: (v) {
                            if (v == null) {
                              return;
                            }
                            createNewBlogsCubit.categoryId =
                                categoriesCubit.categories[v].id;
                          },
                        ),
                        // child: DropdownButton<String?>(
                        //   value: value,
                        //   items: categoriesCubit.categories
                        //       .map(
                        //         (element) => buildMenuItem(
                        //           element.name,
                        //         ),
                        //       )
                        //       .toList(),
                        //   onChanged: (String? value) {},
                        //   isExpanded: true,
                        //   icon: const Icon(
                        //       Icons.keyboard_arrow_down_outlined),
                        //   hint: const Text('القسم'),
                        // ),
                      );
                    },
                  ),
                  Form(
                    key: createNewBlogsCubit.titleFormKey,

                    child: AdsItem(
                      text: '',
                      controller: createNewBlogsCubit.titleController,
                      validator: createNewBlogsCubit.titleValidator,
                      isMessage: false,
                      onChanged: (v) {},
                      hintText: 'blog_title',
                    ),
                  ),
                  Form(
                    key: createNewBlogsCubit.urlFormKey,
                    child: AdsItem(
                      text: '',
                      controller: createNewBlogsCubit.youtubeUrlController,
                      validator: createNewBlogsCubit.youtubeUrlValidator,
                      isMessage: false,
                      onChanged: (v) {},
                      hintText: 'youtube_link',
                    ),
                  ),
                  Form(
                    key: createNewBlogsCubit.descriptionFormKey,
                    child: AdsItem(
                      text: '',
                      isMessage: true,
                      onChanged: (v) {},
                      controller: createNewBlogsCubit.contentController,
                      validator: createNewBlogsCubit.contentValidator,
                      hintText: 'blog_description',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      top: 10,
                      bottom: Sizes.screenHeight() * 0.06,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
/*
                        CameraButton(
                          width: Sizes.screenWidth() * 0.43,
                          title: 'upload_video',
                          function: () {},
                          radius: 25,
                          isImage: false,
                        ),
*/
                        const SizedBox(
                          width: 20,
                        ),
                        CameraButton(
                          width: Sizes.screenWidth() * 0.5,
                          title: 'upload_photo',
                          function: () async{
                          /*  List<File>? data = await Navigator.of(context).push(MaterialPageRoute<List<File>>(
                              builder:(BuildContext context)=> const CameraApp(
//multiple image selection flag
                                  isMultiple :true
                              ),),);*/
                            createNewBlogsCubit.pickImages();
                          },
                          radius: 25,
                          isImage: true,
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<CreateNewBlogsCubit, CreateNewBlogsState>(
                    builder: (context, state) {
                      return Visibility(
                        visible: createNewBlogsCubit.pickedImages.isNotEmpty,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              createNewBlogsCubit.pickedImages.length,
                              (index) {
                                var pickedImage =
                                    createNewBlogsCubit.pickedImages[index];
                                return CustomImage(
                                  pickedImage: pickedImage,
                                  onRemoved: () => createNewBlogsCubit
                                      .deleteImagesByIndex(index: index),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  BlocBuilder<CreateNewBlogsCubit, CreateNewBlogsState>(
                    builder: (context, state) {
                      if (state is CreateNewBlogsLoading) {
                        return const AppLoader();
                      }
                      return CustomTextButton(
                        width: Sizes.screenWidth() * 0.9,
                        title: 'add',
                        function: () => createNewBlogsCubit.createNewBlog(
                          context,
                        ),
                        radius: 25,
                      );
                    },
                  ),
                  SizedBox(
                    height: Sizes.screenHeight() * 0.06,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String?> buildMenuItem(String? item) => DropdownMenuItem(
        value: item,
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: const EdgeInsets.only(bottom: 10),
            // decoration:  const BoxDecoration(
            //             border: Border(
            //                 bottom: BorderSide(color: MainStyle.navigationColor)),
            //           ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                item == 'ads_advertise'.translate
                    ? const Icon(Icons.work)
                    : item == 'good_advertisment'.translate
                        ? const Icon(Icons.shopping_cart)
                        : const Icon(Icons.account_balance_wallet),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  item!,
                ),
              ],
            ),
          ),
        ),
      );
}
