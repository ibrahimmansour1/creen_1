import 'dart:developer';
import 'dart:io';

import 'package:creen/features/block/repo/block_status_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/laravel_exception.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../model/profile_model.dart';
import '../../repo/profile_repo.dart';
import '../../repo/update_profile_repo.dart';

part 'profile_state.dart';

enum UpdatingMode {
  userData,
  password,
  none,
}

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    this.userId,
  }) : super(ProfileInitial());

  /// in case we wanna get specific user profile
  final int? userId;
  bool darkMode = false;
  bool get isMe => userId == HelperFunctions.currentUser?.id;
  TextEditingController? nameController;
  TextEditingController? addressController;
  TextEditingController? aboutController;
  TextEditingController? phoneController;
  TextEditingController? emailController;
  TextEditingController? passwordController;
  TextEditingController? passwordConfirmationController;
  String? _gender;

  String? get gender => _gender;
  bool blocked = false;
  int? blockId;
void changeDarkMode({required bool isDarkMode}){
  darkMode = isDarkMode;
  emit(ProfileChangeDarkMode());
}
  void initCtrls() {
    nameController = TextEditingController(text: _profileData?.name);
    addressController = TextEditingController(text: _profileData?.address);
    phoneController = TextEditingController(text: _profileData?.mobile);
    emailController = TextEditingController(text: _profileData?.email);
    aboutController = TextEditingController(text: _profileData?.about);
    _gender = _profileData?.gender;
    passwordController = TextEditingController();
    passwordConfirmationController = TextEditingController();
  }

  void onGenderChanged(String? value) {
    if (value == null) {
      return;
    }
    log('message');
    _gender = value;
    emit(GenderStateChanged(gender: _gender ?? ''));
  }

  Future<bool> removeCtrls() async {
    nameController = null;
    addressController = null;
    phoneController = null;
    emailController = null;
    aboutController = null;
    passwordController = null;
    passwordConfirmationController = null;
    return true;
  }

  Future<void> getProfile(context,
      {bool bottomNavigationBarindication = false}) async {
    emit(ProfileLoading());
    try {
      var userData = (!bottomNavigationBarindication)
          ? await ProfileRepo.getProfileData(
              context,
              userId: userId ?? HelperFunctions.currentUser?.id,
            )
          : null;
      if (userData == null) {
        emit(ProfileError());
        return;
      }
      if (userData.status == true) {
        _profileData = userData.data;
        blockStatus();
        emit(ProfileDone());
      } else {
        emit(ProfileError());
      }
    } on LaravelException catch (error) {
      emit(ProfileError());
      Fluttertoast.showToast(
        msg: error.exception,
      );
    }
  }

  Future<void> updateProfile(
    context, {
    UpdatingMode updatingMode = UpdatingMode.none,
  }) async {
    emit(UpdateProfileLoading(
      mode: updatingMode,
    ));

    try {
      var currentUser = HelperFunctions.currentUser;
      var userData = await UpdateProfileRepo.updateProfileData(
        context,
        body: {
          if (pickedProfileImage != null) ...{
            'profile': await MultipartFile.fromFile(pickedProfileImage!.path),
          },
          if (pickedCoverImage != null) ...{
            'cover': await MultipartFile.fromFile(pickedCoverImage!.path),
          },
          'name': nameController?.text ?? currentUser?.name,
          'gender': gender ?? currentUser?.gender,
          if (updatingMode == UpdatingMode.userData) ...{
            'address': addressController?.text,
            'about': aboutController?.text,
            'mobile': phoneController?.text,
            'email': emailController?.text,
          },
          if (updatingMode == UpdatingMode.password) ...{
            'password': passwordController?.text,
          },
        },
      );
      if (userData == null) {
        emit(ProfileError());
        return;
      }
      if (userData.status == true) {
        Fluttertoast.showToast(msg: userData.message ?? '');
        _profileData = userData.data;
        pickedCoverImage = null;
        pickedProfileImage = null;
        if (updatingMode == UpdatingMode.password) {
          passwordController?.clear();
          passwordConfirmationController?.clear();
        }
        emit(ProfileDone());
      } else {
        Fluttertoast.showToast(
          msg: userData.message ?? '',
          backgroundColor: Colors.red,
        );
        emit(ProfileError());
      }
    } on LaravelException catch (error) {
      emit(ProfileError());
      Fluttertoast.showToast(
        msg: error.exception,
      );
    }
  }

  ProfileData? _profileData;

  ProfileData? get profileData => _profileData;

  void changeFollowStatus({int? publisherId}) {
    if (_profileData?.id == HelperFunctions.currentUser?.id) {
      log('isMe');
      return;
    }
    log('notMe');

    _profileData?.isFollow = !(_profileData?.isFollow ?? false);
    emit(
      FollowStateChanged(
        isFollow: _profileData?.isFollow ?? false,
        userId: publisherId ?? 0,
      ),
    );
  }

  File? pickedProfileImage;
  File? pickedCoverImage;

  bool get showSubmitButton =>
      (pickedCoverImage != null || pickedProfileImage != null) &&
      HelperFunctions.currentUser?.id == profileData?.id;

  void pickProfileImage() async {
    var images = await HelperFunctions.selectImages(
      imageCount: 1,
      showCamera: true,
    );
    if (images.isEmpty) {
      return;
    }
    pickedProfileImage = images.first;
    emit(ProfileImagePicked(image: pickedProfileImage));
  }

  void pickCoverImage() async {
    var images = await HelperFunctions.selectImages(
      imageCount: 1,
      showCamera: true,
    );
    if (images.isEmpty) {
      return;
    }
    pickedCoverImage = images.first;
    emit(CoverImagePicked(image: pickedCoverImage));
  }

  void blockStatus() async {
    log("block status ««««««««««««");
    await BlockStatusRepo.blockStatus(id: userId).then((value) {
      log("block status response success ===> ${value?.message}");
if(value?.message){
  blocked = true;
  blockId = value!.data;

}
else{
  blocked  = false;

}
      log("blocked ==> $blocked && block_id ==> $blockId");

      emit(ProfileDone());
    }).catchError((e) {
      log("block status response error ===> ${e.toString()}");
      emit(ProfileError());
    });
  }

  @override
  Future<void> close() {
    _profileData = null;
    log('closed', name: 'profile_cubit');
    return super.close();
  }
}
