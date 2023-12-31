import 'package:creen/core/utils/widgets/radio_tile.dart';
import 'package:creen/core/utils/widgets/register_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../features/reports/viewModel/createReport/create_report_cubit.dart';
import '../../themes/enums.dart';
import 'box_helper.dart';
import 'loader_widget.dart';
import 'register_button.dart';

class ReportDialog extends StatelessWidget {
  const ReportDialog({
    super.key,
    required this.reportType,
    required this.reportTypeId,
  });
  final ReportType reportType;
  final int? reportTypeId;

  @override
  Widget build(BuildContext context) {
    var reportCubit = context.read<CreateReportCubit>();
    return Dialog(
      child: Padding(
        padding: EdgeInsets.all(15.0.r),
        child: SingleChildScrollView(
          child: Form(
            key: reportCubit.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BlocBuilder<CreateReportCubit, CreateReportState>(
                  builder: (context, state) {
                    return Column(
                      children: List.generate(
                        reportCubit.reasonsList.length,
                        (index) {
                          var reason = reportCubit.reasonsList[index];

                          return RadioTile(
                            title: reason,
                            value: reason,
                            groupValue: reportCubit.reason,
                            onChanged: reportCubit.onReasonChanged,
                          );
                        },
                      ),
                    );
                  },
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.r),
                      border: Border.all(
                        color: Colors.black,
                      )),
                  child: RegisterTextField(
                    maxLines: null,
                    label: 'leave_a_message_for_administration',
                    controller: reportCubit.messageController,
                    validator: reportCubit.messageValidate,
                    register: true,
                  ),
                ),
                const BoxHelper(
                  height: 25,
                ),
                BlocBuilder<CreateReportCubit, CreateReportState>(
                  builder: (context, state) {
                    if (state is CreateReportLoading) {
                      return const LoaderWidget();
                    }
                    return BoxHelper(
                      // width: 100,
                      child: RegisterButton(
                        radius: 10,
                        title: 'send',
                        onPressed: () => reportCubit.submitReport(
                          reportType: reportType,
                          reportTypeId: reportTypeId,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
