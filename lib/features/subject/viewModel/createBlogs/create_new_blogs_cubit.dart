import 'dart:developer';
import 'dart:io';

import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/laravel_exception.dart';
import 'package:creen/features/subject/viewModel/blogs/blogs_cubit.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../core/utils/responsive/sizes.dart';
import '../../../../core/utils/routing/navigation_service.dart';
import '../../../../core/utils/widgets/custom_dialog.dart';
import '../../../../core/utils/widgets/text_button.dart';
import '../../model/blogs_model.dart';
import '../../repo/create_new_blog_repo.dart';

part 'create_new_blogs_state.dart';

class CreateNewBlogsCubit extends Cubit<CreateNewBlogsState> {
  CreateNewBlogsCubit({
    this.blog,
  }) : super(CreateNewBlogsInitial()) {
    if (blog != null) {
      titleController.text = blog?.title ?? '';
      contentController.text = blog?.content ?? '';
      categoryId = blog?.categoryId;
      youtubeUrlController.text = blog?.youtube ?? '';
    }
  }
  final Blogs? blog;

  final titleFormKey = GlobalKey<FormState>();
  final urlFormKey = GlobalKey<FormState>();
  final descriptionFormKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var contentController = TextEditingController();
  var youtubeUrlController = TextEditingController();
  List<File> pickedImages = [];
  int? categoryId;

  // TODO : configure blog image network after add from api
  List<String> networkImages = [];

  Future<void> createNewBlog(
    BuildContext context,
  ) async {
    var titleValidate = titleFormKey.currentState?.validate() ?? false;
    var urlValidate = titleFormKey.currentState?.validate() ?? false;
    var descriptionValidate = titleFormKey.currentState?.validate() ?? false;
    var blogsCubit = context.read<BlogsCubit>();
    if ((!titleValidate || !urlValidate || !descriptionValidate) && pickedImages.isEmpty/*|| (pickedImages.isEmpty && blog == null)*/) {
      // if (pickedImages.isEmpty) {
      //   Fluttertoast.showToast(
      //     msg: 'blog_photos_required'.translate,
      //     backgroundColor: Colors.red,
      //   );
      // }
      return;
    }
    FocusManager.instance.primaryFocus?.unfocus();
    emit(CreateNewBlogsLoading());

    try {
      List<MultipartFile> imagesToUpload = [];
      for (var index = 0; index < pickedImages.length; index++) {
        var modifiedImage = await MultipartFile.fromFile(
          pickedImages[index].path,
        );
        imagesToUpload.add(modifiedImage);
      }
      var body2 = {
        'title': titleController.text,
        'content': contentController.text,
        'category_id': categoryId??7,
        if (imagesToUpload.isNotEmpty) ...{
          'images[]': imagesToUpload,
        },
        if (blog != null) ...{
          'blog_id': blog?.id,
        },
        if (youtubeUrlController.text.isNotEmpty) ...{
          'youtube': youtubeUrlController.text.contains('&')
              ? youtubeUrlController.text.split('&').first
              : youtubeUrlController.text,
        }
      };
      log('$body2', name: 'createBlogRequestBody');
      var createBlogsData ;
      await CreateNewBlogRepo.createBlog(
        isEdit: blog != null,
        body: body2,
      ).then((value) {
        print(value);
        createBlogsData = value;
      });
      if (createBlogsData == null) {
        showDialog(
          context: context,
          builder: (_) => CustomDialog(
            title: 'يرجى التحقق من الاتصال بالانترنت',
            widget: [
              SizedBox(
                width: Sizes.screenWidth() * 0.3,
                child: CustomTextButton(
                  title: 'Ok',
                  function: () {
                    NavigationService.goBack();
                  },
                ),
              ),
            ],
          ),
        );
        emit(CreateNewBlogsError());
        return;
      }
      if (createBlogsData.status == true) {
        blogsCubit.insertNewBlog(
          jsonData: createBlogsData.data?.toJson(),
        );
        emit(CreateNewBlogsDone());
        NavigationService.goBack();
      } else {
        showDialog(
          context: context,
          builder: (_) => CustomDialog(
            title: /*(createBlogsData.message.runtimeType == 'String')? createBlogsData.message:*/(createBlogsData.message??
              {'b': ['']}
                    ).values.first[0],
            widget: [
              SizedBox(
                width: Sizes.screenWidth() * 0.3,
                child: CustomTextButton(
                  title: 'Ok',
                  function: () {
                    NavigationService.goBack();
                  },
                ),
              ),
            ],
          ),
        );
        return;
      }
    } on LaravelException catch (error) {
      emit(CreateNewBlogsError());
      Fluttertoast.showToast(
        msg: error.exception,
      );
    }
  }

  String? titleValidator(String? v) {
    if (v!.isEmpty &&
        contentController.text.isEmpty &&
        youtubeUrlController.text.isEmpty) {
      return 'blog_title_required'.translate;
    }
    return null;
  }

  String? contentValidator(String? v) {
    if (v!.isEmpty &&
        titleController.text.isEmpty &&
        youtubeUrlController.text.isEmpty) {
      return 'blog_description_required'.translate;
    }
    return null;
  }

  String? categoryValidator(int? v) {
    if (v == null) {
      return 'category_required'.translate;
    }
    return null;
  }

  Future<void> pickImages() async {
    var myImages = await HelperFunctions.selectImages(
      imageCount: 7,
    );
    pickedImages.addAll(
      myImages.map((e) => e),
    );
    emit(ImagesListStateChanged(
      length: pickedImages.length,
    ));
  }

  void deleteImagesByIndex({required int index}) {
    pickedImages.removeAt(index);
    emit(ImagesListStateChanged(
      length: pickedImages.length,
    ));
  }

  String? youtubeUrlValidator(String? v) {
    if (v!.isEmpty &&
        titleController.text.isEmpty &&
        contentController.text.isEmpty) {
      return 'youtube_link_required'.translate;
    }
    return null;
  }

  @override
  Future<void> close() {
    titleController.dispose();
    contentController.dispose();
    youtubeUrlController.dispose();

    return super.close();
  }
}
