import 'dart:developer';
import 'package:creen/core/utils/constants.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/routing/navigation_service.dart';
import '../../../core/utils/routing/route_paths.dart';
import 'app_localization.dart';

StateNotifierProvider<ChangeLanguageProvider, Object?> languageProvider =
    StateNotifierProvider(
  (ref) => ChangeLanguageProvider(null),
);

class ChangeLanguageProvider extends StateNotifier<void> {
  ChangeLanguageProvider(void state) : super(state);
  bool selectLang = false;
  String? lang;

  int? id;

  Future<void> changeLang(String language) async {
    selectLang = true;

    lang = language;
    await HelperFunctions.saveLang(lang);
  }

  void changeCountry(int id2) {
    id = id2;
  }

  void changeLanguage(String newLang, BuildContext context) {
    var currentLanguage = localization.currentLanguage.toString();
    if (newLang == 'العربية' && currentLanguage == 'ar' ||
        newLang == 'Urdu' && currentLanguage == 'ur' ||
        newLang == 'English' && currentLanguage == 'en') {
      log('message');
      return;
    }
    changeLang(newLang.contains('English')
            ? 'en'
            : newLang.contains('العربية')
                ? 'ar'
                : 'ur')
        .then(
      (value) async {
        await localization.setNewLanguage(lang, true);
        selectLang = false;
        log(GetStorage().read(klanguage));
        Phoenix.rebirth(context);

        NavigationService.pushReplacementAll(
          isNamed: true,
          page: RoutePaths.coreSplash,
        );
      },
    );
  }
}
