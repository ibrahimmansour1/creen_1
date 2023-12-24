import 'package:creen/core/themes/enums.dart';
import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/routing/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../repo/create_report_repo.dart';

part 'create_report_state.dart';

class CreateReportCubit extends Cubit<CreateReportState> {
  CreateReportCubit() : super(CreateReportInitial());

  final formKey = GlobalKey<FormState>();
  var messageController = TextEditingController();
  String _reason = 'politicial';

  String get reason => _reason;

  final List<String> reasonsList = [
    "politicial",
    "moral",
    "violent",
    "security",
    "prohibited",
  ];

  void onReasonChanged(String? value) {
    if (value == null) {
      return;
    }
    _reason = value;
    emit(ReasonStateChanged(reason: _reason));
  }

  String? messageValidate(String? value) {
    if (value!.isEmpty) {
      return 'message_required';
    }
    return null;
  }

  Future<void> submitReport({
    required ReportType reportType,
    required int? reportTypeId,
  }) async {
    FocusManager.instance.primaryFocus?.unfocus();
    var validate = formKey.currentState?.validate() ?? false;
    if (!validate) {
      return;
    }
    emit(CreateReportLoading());
    try {
      var createReportData = await CreateReportRepo.createReport(
        body: {
          'model_type': reportType.name,
          'model_id': reportTypeId,
          'message': messageController.text,
          'reason': _reason.translate,
        },
      );
      if (createReportData == null) {
        emit(CreateReportError());
        return;
      }
      Fluttertoast.showToast(
        msg: createReportData.message ?? '',
      );
      emit(CreateReportDone());
      if (createReportData.status == true) {
        NavigationService.goBack();
      }
    } catch (e) {
      emit(CreateReportError());
    }
  }

  @override
  Future<void> close() {
    messageController.dispose();
    return super.close();
  }
}
