import 'dart:developer';

import 'package:creen/core/utils/functions/helper_functions.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:creen/features/Auth/presentation/pages/login.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/utils/routing/route_paths.dart';
import '../../repo/logout_repo.dart';

part 'logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  LogoutCubit() : super(LogoutInitial());

  Future<void> logout({
    required BuildContext context,
  }) async {
    HelperFunctions.getAccount().then((value) async{
      value;
      log('HelperFunctions.getAccount()$value');
      switch (value) {
        case 'email':
          try {
            var logoutData = await LogoutRepo.logout();
            if (logoutData == null) {
              Fluttertoast.showToast(
                msg: 'network',
              );

              return;
            }
            GetStorage().remove('user').then((_) {
              Phoenix.rebirth(context);
              NavigationService.pushAndRemoveUntil(
                page: RoutePaths.mainPage,
                isNamed: true,
                predicate: (p0) => false,
              );
            });
          } catch (error) {
            return;
          }
          break;

        case 'apple':
          break;
        case 'google':
          googleSignInObject.signOut().then((value) {
            GetStorage().remove('user').then((_) {
              Phoenix.rebirth(context);
              NavigationService.pushAndRemoveUntil(
                page: RoutePaths.mainPage,
                isNamed: true,
                predicate: (p0) => false,
              );
            });

          });
          break;
        case 'facebook':
          break;
        case 'x':
          break;
        case 'weChat':
          break;
      }
    });


  }
}
