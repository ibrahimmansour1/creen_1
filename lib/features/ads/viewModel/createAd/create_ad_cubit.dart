import 'dart:io';

import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/features/ads/viewModel/ads/ads_cubit.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_pickers/image_pickers.dart';

import '../../model/ad_data.dart';
import '../../repo/create_ads_repo.dart';

part 'create_ad_state.dart';

class CreateAdCubit extends Cubit<CreateAdState> {
  CreateAdCubit({
    this.ad,
  }) : super(CreateAdInitial()) {
    if (ad != null) {
      categoryId = ad?.promotionCategoryId;
      whatsappController.text = ad?.whatsapp ?? '';
      linkController.text = ad?.link ?? '';
      descController.text = ad?.text?.content ?? '';
      if (ad?.video?.filename == null) {
        youtubeController.text = ad?.video?.url ?? '';
      }
    }
  }
  final AdData? ad;
  final formKey = GlobalKey<FormState>();
  var youtubeController = TextEditingController();
  var whatsappController = TextEditingController();
  var linkController = TextEditingController();
  var descController = TextEditingController();
  var titleController = TextEditingController();
  // File? _pickedImage;
  final List<File> _selectedVideos = [];
  final List<File> _selectedImages = [];
  List<File> get selectedImages => [..._selectedImages];
  List<File> get selectedVideos => [..._selectedVideos];
  int? categoryId;

  Future<void> createNewAd({
    required BuildContext context,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();
    var validate = formKey.currentState?.validate() ?? false;
    if (!validate) {
      return;
    }
    try {
      var allAdsCubit = context.read<AllAdsCubit>();
      emit(CreateAdLoading());
      var isEdit = ad != null;
      var createNewAdData = await CreateAdRepo.createAds(
        isEdit: isEdit,
        body: {
          if (isEdit) ...{
            'id': ad?.id,
          },
          // 'title': titleController.text,
          'content': descController.text,
          'link': linkController.text,
          'linkvideo': youtubeController.text,
          if (_selectedImages.isNotEmpty) ...{
            for (int i = 0; i < _selectedImages.length; i++)
              'images[$i]':
                  await MultipartFile.fromFile(_selectedImages[i].path),
          },
          if (_selectedVideos.isNotEmpty) ...{
            for (int i = 0; i < _selectedVideos.length; i++)
              'videos[$i]':
                  await MultipartFile.fromFile(_selectedVideos[i].path),
          },
          'whatsapp': whatsappController.text,
          'category': categoryId,
          'type': 'general'
        },
      );
      if (createNewAdData == null) {
        emit(CreateAdError());
        return;
      }
      if (createNewAdData.status == true) {
        Fluttertoast.showToast(msg: createNewAdData.message ?? '');
        allAdsCubit.modifyAd(
          adData: createNewAdData.data,
        );
        NavigationService.goBack();
      } else {
        Fluttertoast.showToast(
          msg: createNewAdData.message ?? '',
          backgroundColor: Colors.red,
        );
      }
      emit(CreateAdDone());
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'something_wrong'.translate,
        backgroundColor: Colors.red,
      );
      emit(CreateAdError());
    }
  }

  @override
  Future<void> close() {
    youtubeController.dispose();
    whatsappController.dispose();
    linkController.dispose();
    descController.dispose();
    titleController.dispose();
    return super.close();
  }

  void onImagePicked() async {
    var pickedImages = await HelperFunctions.selectImages(
      imageCount: 7,
      showCamera: true,
    );
    if (pickedImages.isEmpty) {
      return;
    }
    _selectedImages.addAll(pickedImages.map((e) => e));
    emit(AddImages(
      imagesLength: _selectedImages.length,
    ));
  }

  void onVideoPicked() async {
    var pickedVideos = await HelperFunctions.selectImages(
      imageCount: 7,
      showCamera: true,
      galleryMode: GalleryMode.video,
    );
    if (pickedVideos.isEmpty) {
      return;
    }
    _selectedVideos.addAll(pickedVideos.map((e) => e));
    emit(AddVideos(
      videosLength: _selectedVideos.length,
    ));
  }

  void delImageByIndex({required int index}) {
    _selectedImages.removeAt(index);
    emit(AddImages(imagesLength: _selectedImages.length));
  }

  void delVideoByIndex({required int index}) {
    _selectedVideos.removeAt(index);
    emit(AddVideos(videosLength: _selectedVideos.length));
  }

  void onCategoryChanged(
    int? categoryId,
  ) {
    if (categoryId == null) {
      return;
    }
    this.categoryId = categoryId;
  }
}
