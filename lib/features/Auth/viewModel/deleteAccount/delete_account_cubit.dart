import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/utils/routing/navigation_service.dart';
import '../../../../core/utils/routing/route_paths.dart';
import '../../repo/delete_account_repo.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit() : super(DeleteAccountInitial());

  Future<void> deleteAccount({
    required BuildContext context,
  }) async {
    try {
      var logoutData = await DeleteAccountRepo.deleteAccount();
      if (logoutData == null) {
        Fluttertoast.showToast(
          msg: 'network'.translate,
        );

        return;
      }
      if (logoutData.data == true && logoutData.status == true) {
        GetStorage().remove('user').then((_) {
          Fluttertoast.showToast(msg: logoutData.message ?? '');
          Phoenix.rebirth(context);
          NavigationService.pushAndRemoveUntil(
            page: RoutePaths.mainPage,
            isNamed: true,
            predicate: (p0) => false,
          );
        });
      } else {
        Fluttertoast.showToast(
          msg: logoutData.message ?? 'something_wrong'.translate,
          backgroundColor: Colors.red,
        );
      }
    } catch (error) {
      Fluttertoast.showToast(
        msg: 'something_wrong'.translate,
        backgroundColor: Colors.red,
      );
    }
  }
}
