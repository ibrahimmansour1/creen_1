import 'package:creen/core/utils/extensions/string.dart';
import 'package:creen/features/wallets/viewModel/points/points_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/themes/themes.dart';
import '../../../../core/utils/widgets/box_helper.dart';
import '../../../../core/utils/widgets/customized_table.dart';
import '../../../../core/utils/widgets/loader_widget.dart';
import '../../../../core/utils/widgets/register_button.dart';
import '../../../../core/utils/widgets/register_text_field.dart';
import '../../../../core/utils/widgets/table_text.dart';

class PointsView extends StatelessWidget {
  const PointsView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var pointsCubit = context.read<PointsCubit>();
    return BlocBuilder<PointsCubit, PointsState>(
      builder: (context, state) {
        if (state is PointsLoading) {
          return const LoaderWidget();
        }
        var total = pointsCubit.total?.toString() ?? '0.0';
        return SingleChildScrollView(
          controller: pointsCubit.scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomizedTable(
                columnWidths: const {
                  0: FlexColumnWidth(),
                  1: IntrinsicColumnWidth(),
                  2: FlexColumnWidth(),
                },
                tableRow: [
                   TableRow(children: [
                    TableText(
                      title: 'points'.translate,
                      fontWeight: FontWeight.bold,
                    ),
                    TableText(
                      title: 'for'.translate,
                      fontWeight: FontWeight.bold,
                    ),
                    TableText(
                      title: 'value'.translate,
                      fontWeight: FontWeight.bold,
                    ),
                  ]),
                  ...List.generate(
                    pointsCubit.points.length,
                    (index) {
                      var point = pointsCubit.points[index];
                      return TableRow(children: [
                        TableText(
                          title: point.points?.toString() ?? '0',
                        ),
                        TableText(
                          title: point.description ?? '_',
                        ),
                        TableText(
                            title: point.grandTotal?.toStringAsFixed(2) ?? '0'),
                      ]);
                    },
                  ),
                ],
              ),
              const BoxHelper(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 14.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${'total_points'.translate} $total',
                      style: MainTheme.authTextStyle,
                    ),
                    const BoxHelper(
                      height: 20,
                    ),
                    Text(
                      '${'all_points_value'} $total ${'sr'.translate}',
                      style: MainTheme.authTextStyle,
                    ),
                    const BoxHelper(
                      height: 20,
                    ),
                    Column(
                      children: [
                        BoxHelper(
                          // width: 100,
                          child: RegisterButton(
                            radius: 10,
                            title: 'transfer_balance_to_wallet',
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                      30.r,
                                    ),
                                    topRight: Radius.circular(
                                      30.r,
                                    ),
                                  ),
                                ),
                                builder: (context) => BlocProvider.value(
                                  value: pointsCubit,
                                  child: const TransferPointSheet(
                                    type: 'wallet',
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        BoxHelper(
                          // width: 100,
                          child: RegisterButton(
                            radius: 10,
                            title: 'transfer_points_as_gift',
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(
                                      30.r,
                                    ),
                                    topRight: Radius.circular(
                                      30.r,
                                    ),
                                  ),
                                ),
                                builder: (context) => BlocProvider.value(
                                  value: pointsCubit,
                                  child: const TransferPointSheet(
                                    type: 'gift',
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class TransferPointSheet extends StatelessWidget {
  const TransferPointSheet({
    Key? key,
    required this.type,
  }) : super(key: key);

  /// ['wallet'] to to transfer it to gift balance in wallet
  /// ['gift'] to send it as gift to specific user
  final String type;

  @override
  Widget build(BuildContext context) {
    var pointsCubit = context.read<PointsCubit>();
    var isGift = type == 'gift';
    return WillPopScope(
      onWillPop: () async {
        pointsCubit.clearFields();
        return true;
      },
      child: Padding(
        padding: EdgeInsets.all(15.0.r),
        child: Form(
          key: pointsCubit.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'please_enter_points'.translate,
                style: MainTheme.authTextStyle,
              ),
              const BoxHelper(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.all(8.0.r),
                child: RegisterTextField(
                  type: TextInputType.phone,
                  label: 'points',
                  controller: pointsCubit.pointsController,
                ),
              ),
              Visibility(
                visible: isGift,
                child: Padding(
                  padding: EdgeInsets.all(8.0.r),
                  child: RegisterTextField(
                    type: TextInputType.phone,
                    label: 'phone_number',
                    controller: pointsCubit.mobileController,
                  ),
                ),
              ),
              const BoxHelper(
                height: 20,
              ),
              BlocBuilder<PointsCubit, PointsState>(
                builder: (context, state) {
                  if (state is TransferPointsLoading) {
                    return const LoaderWidget();
                  }
                  return BoxHelper(
                    // width: 100,
                    child: RegisterButton(
                      radius: 10,
                      title: 'transfer',
                      onPressed: () => pointsCubit.transfer(isGift: isGift),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
