import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:flutter/material.dart' hide NavigationDrawer;
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../core/utils/routing/navigation_service.dart';
import '../../../../core/utils/routing/route_paths.dart';
import '../../manager/app_localization.dart';

part 'lang_state.dart';

class LangCubit extends Cubit<LangState> {
  LangCubit() : super(LangInitial());
  Future<void> changeLanguage({
    required BuildContext context,
    required String code,
  }) async {
    emit(
      LoadingState(),
    );
    await GetStorage().write(
      'language',
      code,
    );
    await GetStorage().write(
      'lang',
      true,
    );
    await localization.setNewLanguage(
      _currentLanguage,
      true,
    );
    emit(
      ChosenLanguage(
        language: _currentLanguage,
      ),
    );
    // var canPop = context.router.canNavigateBack;
    NavigationService.pushReplacementAll(
        page: RoutePaths.mainPage, isNamed: true);

    // NavigationService.pushAndRemoveUntil(
    //   page: canPop ? '/' : LoginScreen.routeName,
    //   isNamed: true,
    //   predicate: (_) => false,
    // );
    Phoenix.rebirth(context);
  }

  String _currentLanguage = localization.currentLanguage.toString();
  String get currentLanguage => _currentLanguage;

  void chooseLanguage(
    String? code,
    BuildContext context,
  ) {
    if (code == null || code == HelperFunctions.currentLanguage) {
      NavigationService.goBack();
      return;
    }
    _currentLanguage = code;
    emit(
      ChosenLanguage(
        language: code,
      ),
    );
    // changeLanguage(
    //   context: context,
    // );
  }
}
