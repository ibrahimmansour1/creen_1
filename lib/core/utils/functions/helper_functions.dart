// ignore_for_file: file_names
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:creen/core/themes/screen_utitlity.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/core/utils/routing/route_paths.dart';
import 'package:creen/features/Auth/model/login_model.dart';
// import 'package:flash/flash.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:flutter_images_picker/flutter_images_picker.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_pickers/image_pickers.dart';
import '../../../features/localization/manager/app_localization.dart';
import '../constants.dart';
import '../widgets/box_helper.dart';
import '../widgets/coming_soon_dialog.dart';

class HelperFunctions {
  static Future<void> setLiveId(int? data , ) async {
    await GetStorage().write(
      'liveId',
     data
    );
  }

  static Future<int?> getLiveId( ) async {
    return GetStorage().read(
      'liveId',
    );
  }
  static Future<void> storeUserData(UserData? data) async {
    await GetStorage().write(
      'user',
      jsonEncode(
        data?.toJson(),
      ),
    );
  }

  static Future<void> account( String type) async {
    await GetStorage().write(
      'account',
      type,
    );
  }

  static Future<String> getAccount( ) async {
    return GetStorage().read(
      'account',
    );

  }

  static bool get isLoggedIn => GetStorage().hasData('user');

  static UserData? get currentUser => !isLoggedIn
      ? null
      : UserData.fromJson(jsonDecode(GetStorage().read('user')));
  static String get currentLanguage => localization.currentLanguage.toString();
  static bool get isArabic => currentLanguage == 'ar';
  static Alignment get appAlignment =>
      currentLanguage == 'ar' ? Alignment.centerRight : Alignment.centerLeft;

  static String formatTime(int milliseconds) {
    var secs = milliseconds ~/ 1000;
    var minutes = ((secs % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (secs % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  static TextDirection get reversedDirection =>
      currentLanguage == 'ar' ? TextDirection.ltr : TextDirection.rtl;
  static PopupMenuItem<dynamic> buildPopupMenu({
    required IconData icons,
    required String title,
    String? value,
  }) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(icons),
          const BoxHelper(
            width: 5,
          ),
          Text(title.translate),
        ],
      ),
    );
  }

  static bool validateLogin() {
    if (!isLoggedIn) {
      Fluttertoast.showToast(
        msg: 'login_required'.translate,
        backgroundColor: Colors.red,
      );
      NavigationService.push(
        page: RoutePaths.authLogin,
        isNamed: true,
      );
    }
    return isLoggedIn;
  }

  static String videoShareLink({required int? videoId}) =>
      'https://www.creen-program.com/lives/show/$videoId';
  // static Future<T?> errorBar<T>(
  //   BuildContext context, {
  //   String? title,
  //   required String message,
  //   Duration duration = const Duration(seconds: 4),
  // }) {
  //   return showFlash<T>(
  //     context: context,
  //     duration: duration,
  //     builder: (context, controller) {
  //       return Directionality(
  //         textDirection: TextDirection.rtl,
  //         child: Flash(
  //           behavior: FlashBehavior.fixed,
  //           controller: controller,
  //           horizontalDismissDirection: HorizontalDismissDirection.horizontal,
  //           backgroundColor: Colors.black87,
  //           child: FlashBar(
  //             title: title == null
  //                 ? null
  //                 : Text('login', style: _titleStyle(context, Colors.white)),
  //             content:
  //                 Text(message, style: _contentStyle(context, Colors.white)),
  //             icon: Icon(Icons.warning, color: Colors.red[300]),
  //             indicatorColor: Colors.red[300],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // static Future<T?> successBar<T>(
  //   BuildContext context, {
  //   String? title,
  //   required String message,
  //   Duration duration = const Duration(seconds: 2),
  // }) {
  //   return showFlash<T>(
  //     context: context,
  //     duration: duration,
  //     builder: (context, controller) {
  //       return Directionality(
  //         textDirection: TextDirection.rtl,
  //         child: Flash(
  //           behavior: FlashBehavior.fixed,
  //           alignment: Alignment.bottomCenter,
  //           controller: controller,
  //           horizontalDismissDirection: HorizontalDismissDirection.horizontal,
  //           backgroundColor: Colors.black87,
  //           child: FlashBar(
  //             title: title == null
  //                 ? null
  //                 : Text('login', style: _titleStyle(context, Colors.white)),
  //             content:
  //                 Text(message, style: _contentStyle(context, Colors.white)),
  //             icon: Icon(Icons.check, color: Colors.green[300]),
  //             indicatorColor: Colors.green[300],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  static Future saveUser(data) async {
    await GetStorage.init().then((value) {
      GetStorage().write(kcashedUserData, data);
      GetStorage().write(kIsLoggedIn, true);

      log('IsLoggedIn >>> ${GetStorage().read(kIsLoggedIn)}');
      log(('cashedUserData >>> ${GetStorage().read(kcashedUserData)}'));
    });
  }

  static Future saveToken(String data) async {
    await GetStorage.init().then((value) {
      GetStorage().write(kToken, data);

      log(('kToken >>> ${GetStorage().read(kToken)}'));
    });
  }

  static Future saveFirstTime() async {
    GetStorage().write(kIsFirstTime, false);
  }

  static Future<dynamic> showComingSoonDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const ComingSoonDialog(),
    );
  }

  static ImageProvider chatProfileImage({
    required bool isGroup,
    required String? pic,
  }) =>
      pic == null
          ? AssetImage(
        isGroup?groupProfile:personProfile
              // 'assets/images/${isGroup ? 'new_group_icon.png' : 'person_perview.png'}',
            )
          : NetworkImage(
              pic,
            ) as ImageProvider;
  static Future<List<File>> selectImages({
    int imageCount = 2,
    GalleryMode galleryMode = GalleryMode.image,
    bool showCamera = true,
  }) async {
    // var pickedImages =
    //     await FlutterImagesPicker.pickImages(maxImages: imageCount);
    var pickImages = await ImagePickers.pickerPaths(
      galleryMode: galleryMode,
      selectCount: imageCount,
      showGif: false,
      showCamera: showCamera,
      // showCamera: true,
      // compressSize: 500,
      uiConfig: UIConfig(uiThemeColor: MainStyle.primaryColor),
      // cropConfig: CropConfig(enableCrop: false, width: 2, height: 1),
    );
    if (pickImages.isEmpty) {
      return [];
    }
    var pickedImages = pickImages
        .map(
          (e) => File(
            e.path ?? '',
          ),
        )
        .toList();
    if (pickedImages.isEmpty) {
      return [];
    }

    return pickedImages
        .map(
          (e) => File(
            e.path,
          ),
        )
        .toList();
  }

  static Future saveLang(String? lang) async {
    await GetStorage.init().then((value) {
      GetStorage().write(klanguage, lang);
    });
  }

  static Future saveApplicationInformation(String name, String value) async {
    await GetStorage().write(storageKey + name, value);
  }

  // static UserModel getUser() {

  //   return UserModel.fromJson(
  //     GetStorage().read(kcashedUserData),
  //   );
  // }

  static updateUser(String x, dynamic value) async {
    var data = GetStorage().read(kcashedUserData);
    if (x == 'city' ||
        x == 'phone' ||
        x == 'id_number' ||
        x == 'profile_image' ||
        x == 'name' ||
        x == 'email') {
      if (data['data'] == null) {
        data['data'] = <String, dynamic>{
          'city': '',
          'phone': '',
          'profile_image': '',
          'id_number': ''
        };
      }
      data['data'][x] = value;
    } else {
      data['data'][x] = value;
    }
    debugPrint('$data');

    await GetStorage.init().then((value) {
      GetStorage().write(kcashedUserData, data);
      GetStorage().write(kIsLoggedIn, true);
    });
  }
}

TextStyle _titleStyle(BuildContext context, [Color? color]) {
  var theme = Theme.of(context);
  return (theme.dialogTheme.titleTextStyle ?? theme.textTheme.titleLarge)!
      .copyWith(color: color);
}

TextStyle _contentStyle(BuildContext context, [Color? color]) {
  var theme = Theme.of(context);
  return (theme.dialogTheme.contentTextStyle ?? theme.textTheme.bodyMedium)!
      .copyWith(color: color);
}
