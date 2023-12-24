import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/core/utils/widgets/report_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/block/cubit/bloc_cubit.dart';
import '../../../features/reports/viewModel/createReport/create_report_cubit.dart';
import '../../../features/videos/repo/remove_video.dart';
import '../../themes/enums.dart' show ReportType;
export '../../themes/enums.dart' show ReportType;
import '../functions/helper_functions.dart';
import '../routing/navigation_service.dart';

class ReportAndBlockMenu extends StatelessWidget {
  const ReportAndBlockMenu({
    super.key,
    required this.reportTypeId,
    required this.reportType,
    this.me = false,
    this.iconColor = Colors.black,

  });

  final int? reportTypeId;
  final ReportType reportType;
  final Color iconColor;
  final bool me;



  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: Icon(
        Icons.more_vert,
        color: iconColor,
      ),
      onSelected: (value) {
        if (!HelperFunctions.validateLogin()) {
          return;
        }
        if (value == 'report') {
          showDialog(
            context: context,
            builder: (context) =>
                BlocProvider(
                  create: (context) => CreateReportCubit(),
                  child: ReportDialog(
                    reportType: reportType,
                    reportTypeId: reportTypeId,
                  ),
                ),
          );
        } else if (value == "delete") {
          showDialog(
            context: context,
            builder: (_) =>
                AlertDialog(
                  content: Text(
                    'do_you_want_to_scan'.translate,
                    style: const TextStyle(fontSize: 24),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        // var videoData =
                        await RemoveVideoRepo.removeVideo(
                            context, body: {"video_id":"$reportTypeId"});
                        NavigationService.goBack();

                        // print("ggggggggggggg ${reportTypeId}");
                        /*NavigationService.goBack();
                    storiesCubit.deleteStoryByIndex(
                        storyIndex: storyIndex,
                        pageIndex: pageIndex,
                        userId: storiesCubit
                            .stories[pageIndex].id ??
                            0,
                        context: context);*/
                      },
                      child: Text(
                        'yes'.translate,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        NavigationService.goBack();
                      },
                      child: Text(
                        'no'.translate,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
          );
        }
        else if (value == "block"){
        showDialog(
            context: context,
            builder: (_) =>
                AlertDialog(
                  content: Text(
                    'block_${reportType.name}_confirm'.translate,
                    style: const TextStyle(fontSize: 24),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        NavigationService.goBack();
                      },
                      child: Text(
                        'no'.translate,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        // var videoData =
                        submitBlock(blockType: reportType, blockTypeId: reportTypeId!);

                        // print("ggggggggggggg ${reportTypeId}");
                        /*NavigationService.goBack();
                    storiesCubit.deleteStoryByIndex(
                        storyIndex: storyIndex,
                        pageIndex: pageIndex,
                        userId: storiesCubit
                            .stories[pageIndex].id ??
                            0,
                        context: context);*/
                      },
                      child: Text(
                        'block'.translate,
                        style: const TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
          );
         /* CustomAwesomeDialog().showOptionsDialog(
            context: context,
            message: 'block_post_confirm'.translate,
            btnOkText: 'block',
            btnCancelText: 'cancel',
            onConfirm: () {
              submitBlock(blockType: ReportType.post, blockTypeId: reportTypeId!);
            },
            type: DialogType.warning,
          );*/
        }
      },
      position: PopupMenuPosition.under,
      itemBuilder: (_) =>
      [
        if (me) ...[
          HelperFunctions.buildPopupMenu(
              icons: Icons.edit, title: 'edit', value: 'edit'),
          HelperFunctions.buildPopupMenu(
              icons: Icons.delete, title: 'delete', value: 'delete'),
        ] else
          ...[
            HelperFunctions.buildPopupMenu(
                icons: Icons.report, title: 'report', value: 'report'),
            HelperFunctions.buildPopupMenu(
                icons: Icons.block, title: 'block', value: 'block'),
          ]
      ],
    );
  }
}
